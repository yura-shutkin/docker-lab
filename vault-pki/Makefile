SHELL := /bin/bash
DEFAULT_GOAL := help

export VAULT_ADDR := http://vault.pki.infra

.PHONY: help
help: ## 					Show this help.
	@sed -e '/__hidethis__/d; /##/!d; s/:.\+## /\t/g' $(MAKEFILE_LIST)

.PHONY: up
up: ## 					Launch or update project
	@docker-compose up -d nginx
	@docker-compose up -d
	@$(MAKE) vault-init

.PHONY: down
down: ## 					Stop project and remove containers
	@docker-compose down

.PHONY: cleanup
cleanup: ## 					Stop project and remove volumes and orphans as well
	-@docker-compose down --volumes --remove-orphans
	-@rm -v vault_creds.json ./*.csr ./*.pem *.json
	-@git checkout -- conf/nginx/certs/*

.PHONY: vault-init
vault-init: ## 				Init vault node
	@echo "Sleep for 20 secs be cause no checker if vault alive"
	@sleep 20
	@curl -sk -X GET ${VAULT_ADDR}/v1/sys/init | grep false && curl -sk -X PUT -d '{"secret_shares": 1, "secret_threshold": 1}' -o vault_creds.json ${VAULT_ADDR}/v1/sys/init
	@echo "Check ${VAULT_ADDR}"
	@cat vault_creds.json

.PHONY: show-root-token
show-root-token: ## 				Show root token
	@cat vault_creds.json | jq -r '.root_token'

.PHONY: vault-unseal
vault-unseal: ## 				Try to unseal vault instances
	@curl -sk -X PUT -d "{\"key\": \"$(shell cat vault_creds.json | sed -e 's/\"].*//' -e 's/.*\"//')\"}" ${VAULT_ADDR}/v1/sys/unseal

.PHONY: openssl-generate-root
openssl-generate-root: ## 			Generate root self signed certificate
	@openssl req -x509 -sha256 -nodes -days 365 -keyout private.pem -out cert.pem -config req.conf
	@cat cert.pem private.pem > bundle_ca.pem

.PHONY: vault-enable-pki
vault-enable-pki: ## 			Enable CA PKI Secrets Engine
	@VAULT_TOKEN=$(shell make show-root-token) vault secrets enable -path=my-project__pki -max-lease-ttl=87600h pki

.PHONY: vault-ca-set-custom
vault-ca-set-custom: ## 			Upload your cert
	@VAULT_TOKEN=$(shell make show-root-token) vault write my-project__pki/config/ca pem_bundle=@bundle_ca.pem
	@VAULT_TOKEN=$(shell make show-root-token) vault write my-project__pki/config/urls issuing_certificates="${VAULT_ADDR}/v1/my-project__pki/ca" crl_distribution_points="${VAULT_ADDR}/v1/my-project__pki/crl"

.PHONY: vault-ca-generate-and-set
vault-ca-generate-and-set: ## 		Generate new cert for CA
	@VAULT_TOKEN=$(shell make show-root-token) vault write -field=certificate my-project__pki/root/generate/internal common_name="PKI Infra" ttl=87600h > ca_cert.pem
	@VAULT_TOKEN=$(shell make show-root-token) vault write my-project__pki/config/urls issuing_certificates="${VAULT_ADDR}/v1/my-project__pki/ca" crl_distribution_points="${VAULT_ADDR}/v1/my-project__pki/crl"

.PHONY: vault-enable-pki-int
vault-enable-pki-int: ## 			Enable Intermediate PKI Secrets Engine
	@VAULT_TOKEN=$(shell $(MAKE) show-root-token) vault secrets enable -path=my-project__pki-int -max-lease-ttl=43800h pki

.PHONY: vault-intermediate-setup
KEY_BITS := 2048
vault-intermediate-setup: ## 		Create intermediate cert
	@VAULT_TOKEN=$(shell $(MAKE) show-root-token) vault write -format=json my-project__pki-int/intermediate/generate/internal common_name="Infra PKI Intermediate Authority" key_type=rsa key_bits=${KEY_BITS} | jq -r '.data.csr' > pki_intermediate.csr
	@VAULT_TOKEN=$(shell $(MAKE) show-root-token) vault write -format=json my-project__pki/root/sign-intermediate csr=@pki_intermediate.csr format=pem_bundle ttl="43800h" | jq -r '.data.certificate' > intermediate.cert.pem
	@VAULT_TOKEN=$(shell $(MAKE) show-root-token) vault write my-project__pki-int/intermediate/set-signed certificate=@intermediate.cert.pem

.PHONY: vault-create-role-wildcard
vault-create-role-wildcard: ## 		Create role for pki.infra certificate
	@VAULT_TOKEN=$(shell $(MAKE) show-root-token) vault write my-project__pki-int/roles/pki_infra allowed_domains="pki.infra" allow_subdomains=true max_ttl="720h"

.PHONY: vault-create-role-subdomain
SUBDOMAIN ?= blog
vault-create-role-subdomain: ## 		Create role for consul.pki.infra certificate
	@VAULT_TOKEN=$(shell $(MAKE) show-root-token) vault write my-project__pki-int/roles/${SUBDOMAIN}_pki_infra allowed_domains="${SUBDOMAIN}.pki.infra" allow_subdomains=false allow_bare_domains=true max_ttl="720h"

.PHONY: vault-intermediate-generate-cert
SUBDOMAIN ?= blog
vault-intermediate-generate-cert: ## 	Generate certificate <SUBDOMAIN>.pki.infra
	@VAULT_TOKEN=$(shell $(MAKE) show-root-token) vault write -format=json my-project__pki-int/issue/${SUBDOMAIN}_pki_infra common_name="${SUBDOMAIN}.pki.infra" ttl="720h" format="pem" > ${SUBDOMAIN}.pki.infra.json
	@cat ${SUBDOMAIN}.pki.infra.json | jq -r '.data.certificate' > conf/nginx/certs/bundle_${SUBDOMAIN}.pki.infra.pem
	@cat ${SUBDOMAIN}.pki.infra.json | jq -r '.data.issuing_ca' >> conf/nginx/certs/bundle_${SUBDOMAIN}.pki.infra.pem
	@cat ${SUBDOMAIN}.pki.infra.json | jq -r '.data.ca_chain[0]' >> conf/nginx/certs/bundle_${SUBDOMAIN}.pki.infra.pem
	@cat ${SUBDOMAIN}.pki.infra.json | jq -r '.data.private_key' > conf/nginx/certs/${SUBDOMAIN}.pki.infra.key.pem

.PHONY: nginx-restart
nginx-restart: ## 				Retart nginx and site
	@docker-compose restart nginx

.PHONY: vault-ca-root-delete
vault-ca-root-delete: ## 			Delete CA root cert
	@VAULT_TOKEN=$(shell $(MAKE) show-root-token) vault delete my-project__pki/root

.PHONY: vault-intermediate-list-certificates
vault-intermediate-list-certificates: ## 	List issued certificates
	@VAULT_TOKEN=$(shell $(MAKE) show-root-token) vault list -format=json my-project__pki-int/certs

.PHONY: vault-intermediate-revoke-certificate
SERIAL ?= ""
vault-intermediate-revoke-certificate: ## 	Revoke certificate by serial
	@VAULT_TOKEN=$(shell $(MAKE) show-root-token) vault write my-project__pki-int/revoke serial_number=${SERIAL}

.PHONY: vault-intermediate-read-certificate
SERIAL ?= ""
vault-intermediate-read-certificate: ## 	Read certificate by serial
	@VAULT_TOKEN=$(shell $(MAKE) show-root-token) vault read -field=certificate my-project__pki-int/cert/${SERIAL}

.PHONY: vault-intermediate-tidy
vault-intermediate-tidy: ## 			Revoke old certificates
	@VAULT_TOKEN=$(shell $(MAKE) show-root-token) vault write my-project__pki-int/tidy tidy_cert_store=true tidy_revoked_certs=true
