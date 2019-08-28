SHELL := /bin/bash
DEFAULT_GOAL := help

VAULT_SKIP_VERIFY := 1
CONSUL_SERVERS := consul-server-1
CONSUL_AGENTS := consul-agent-1 consul-agent-2
UNSEAL_CLUSTER_NODES := vault-unseal
MAIN_CLUSTER_NODES := vault-1 vault-2
UNSEAL_CLUSTER_ADDR := http://172.18.1.12:8200
MAIN_CLUSTER_ADDR := http://172.18.1.14:8200

.PHONY: help
help: ## Show this help
	@sed -e '/__hidethis__/d; /##/!d; s/:.\+## /\t/g' $(MAKEFILE_LIST)

.PHONY: run
run: ## run containers project
	if [ ! -f .env ]; then cp -v .env.example .env; fi
	docker-compose up -d $(CONSUL_SERVERS)
	docker-compose up -d $(CONSUL_AGENTS)
	docker-compose up -d $(UNSEAL_CLUSTER_NODES)
	docker-compose up -d $(MAIN_CLUSTER_NODES)
	sleep 5
	$(MAKE) init-unseal-cluster
	$(MAKE) unseal-unseal-cluster
	$(MAKE) seed-unseal-cluster
	$(MAKE) get-unseal-main-cluster-creds
	$(MAKE) init-main-cluster
	$(MAKE) unseal-main-cluster
	$(MAKE) check-if-main-cluster-sealed
	$(MAKE) setup-seal-type
	docker-compose restart vault-1
	$(MAKE) check-if-main-cluster-sealed
	$(MAKE) unseal-migrate-main-cluster
	$(MAKE) check-if-main-cluster-sealed

.PHONY: wipe
wipe: ## wipe project
	docker-compose down
	docker volume prune -f
	rm -v *.json

.PHONY: init-unseal-cluster
init-unseal-cluster: ## init unseal-cluster
	$(eval export VAULT_ADDR=$(UNSEAL_CLUSTER_ADDR))
	vault operator init -key-shares=1 -key-threshold=1 -format=json > unseal_cluster_creds.json

.PHONY: unseal-unseal-cluster
unseal-unseal-cluster: ## unseal unseal-cluster
	$(eval export VAULT_ADDR=$(UNSEAL_CLUSTER_ADDR))
	$(eval UNSEAL_KEY=$(shell cat unseal_cluster_creds.json | jq -r '.unseal_keys_b64[0]'))
	vault operator unseal $(UNSEAL_KEY)

.PHONY: seed-unseal-cluster
seed-unseal-cluster: ## seed unseal-cluster
	$(eval export VAULT_ADDR=$(UNSEAL_CLUSTER_ADDR))
	$(eval export VAULT_TOKEN=$(shell cat unseal_cluster_creds.json | jq -r '.root_token'))
	vault secrets enable -path=unseal-keys transit
	vault write unseal-keys/keys/vault-main-cluster type=aes256-gcm96
	vault policy write unseal-main-cluster policies/vault-main-unseal.hcl
	vault auth enable approle
	vault write auth/approle/role/unseal-main-cluster token_ttl=1h token_max_ttl=1h period=1h policies=default,unseal-main-cluster

.PHONY: get-unseal-main-cluster-creds
get-unseal-main-cluster-creds: ## get unseal-main-cluster approle's creds
	$(eval export VAULT_ADDR=$(UNSEAL_CLUSTER_ADDR))
	$(eval export VAULT_TOKEN=$(shell cat unseal_cluster_creds.json | jq -r '.root_token'))
	$(eval ROLE_ID=$(shell export VAULT_TOKEN=$(VAULT_TOKEN); vault read -field=role_id auth/approle/role/unseal-main-cluster/role-id))
	$(eval SECRET_ID=$(shell export VAULT_TOKEN=$(VAULT_TOKEN); vault write -f -field=secret_id auth/approle/role/unseal-main-cluster/secret-id))
	echo '{}' | jq ".role_id += \"$(ROLE_ID)\" | .secret_id += \"$(SECRET_ID)\"" > unseal-main-cluster-creds.json

.PHONY: init-main-cluster
init-main-cluster: ## init main-cluster
	$(eval export VAULT_ADDR=$(MAIN_CLUSTER_ADDR))
	vault operator init -key-shares=1 -key-threshold=1 -format=json > main_cluster_creds.json

.PHONY: unseal-main-cluster
unseal-main-cluster: ## unseal main-cluster
	$(eval export VAULT_ADDR=$(MAIN_CLUSTER_ADDR))
	$(eval UNSEAL_KEY=$(shell cat main_cluster_creds.json | jq -r '.unseal_keys_b64[0]'))
	vault operator unseal $(UNSEAL_KEY)

.PHONY: unseal-migrate-main-cluster
unseal-migrate-main-cluster: ## unseal main-cluster
	$(eval export VAULT_ADDR=$(MAIN_CLUSTER_ADDR))
	$(eval UNSEAL_KEY=$(shell cat main_cluster_creds.json | jq -r '.unseal_keys_b64[0]'))
	vault operator unseal -migrate $(UNSEAL_KEY)

.PHONY: setup-seal-type
setup-seal-type: ## Add seal transit block to vault configs
	$(eval export VAULT_ADDR=$(UNSEAL_CLUSTER_ADDR))
	$(eval APPROLE_TOKEN=$(shell curl -sk -X POST -d @unseal-main-cluster-creds.json $(UNSEAL_CLUSTER_ADDR)/v1/auth/approle/login | jq -r '.auth.client_token'))
	echo '' >> configs/vault-1.hcl
	cat seal_template.hcl | sed "s|UNSEAL_TOKEN|$(APPROLE_TOKEN)|" >> configs/vault-1.hcl
	echo '' >> configs/vault-2.hcl
	cat seal_template.hcl | sed "s|UNSEAL_TOKEN|$(APPROLE_TOKEN)|" >> configs/vault-2.hcl

.PHONY: remove-transit-seal-type
remove-transit-seal-type: ## remove seal transit block from vault configs
	cp configs/vault-1.hcl config.tmp.hcl
	cat config.tmp.hcl | head -n -9 > configs/vault-1.hcl
	rm config.tmp.hcl
	cp configs/vault-2.hcl config.tmp.hcl
	cat config.tmp.hcl | head -n -9 > configs/vault-2.hcl
	rm config.tmp.hcl

.PHONY: check-if-main-cluster-sealed
check-if-main-cluster-sealed: ## check if main cluster sealed
	$(eval export VAULT_ADDR=$(UNSEAL_CLUSTER_ADDR))
	if [ $(shell vault status -format=json | jq '.sealed') == 'true' ]; then exit 1; fi

.PHONY: restart-main-cluster
restart-main-cluster: ## restart main-cluster
	docker restart $(MAIN_CLUSTER_NODES)
