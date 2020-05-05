SHELL := /bin/bash
DEFAULT_GOAL := help
VAULT_ADDR ?= http://192.168.4.83:8200

.PHONY: help
help: ## 		Show this help.
	@sed -e '/__hidethis__/d; /##/!d; s/:.\+## /\t/g' $(MAKEFILE_LIST)

.PHONY: create-env-file
create-env-file: ## 	Create .env file if it isn't exist
	@if [[ ! -f .env ]]; then cp .env.example .env; fi

.PHONY: up
up: ## 		Launch project
	@$(MAKE) create-env-file
	@docker-compose up -d
	@$(MAKE) vault-init
	@$(MAKE) vault-unseal

.PHONY: down
down: ## 		Stop project and remove containers
	@docker-compose down

.PHONY: vault-init
vault-init: ## 	Init vault node
	@echo "Sleep for 20 secs be cause no checker if vault alive"
	@sleep 20
	@curl -sk -X GET ${VAULT_ADDR}/v1/sys/init | grep false && curl -sk -X PUT -d '{"secret_shares": 1, "secret_threshold": 1}' -o vault_creds.json ${VAULT_ADDR}/v1/sys/init
	@echo "Check ${VAULT_ADDR}"
	@cat vault_creds.json

.PHONY: vault-unseal
vault-unseal: ## 	Try to unseal vault instances
	curl -sk -X PUT -d "{\"key\": \"$(shell cat vault_creds.json | sed -e 's/\"].*//' -e 's/.*\"//')\"}" ${VAULT_ADDR}/v1/sys/unseal

.PHONY: cleanup
cleanup: ## 		Stop project and remove volumes and orphans as well
	-@docker-compose down --volumes --remove-orphans
	-@rm -v vault_creds.json

.PHONY: se-mount
se-mount: ## 	Mount Database Secret Engine
	@curl -X POST -sk -H "X-Vault-Token: $(shell cat vault_creds.json | jq -r '.root_token')" -d @payloads/pgsql_se_mnt.json ${VAULT_ADDR}/v1/sys/mounts/database

.PHONY: se-setup
se-setup: ## 	Configure Database Secret Engine
	@curl -X POST -sk -H "X-Vault-Token: $(shell cat vault_creds.json | jq -r '.root_token')" -d @payloads/pgsql_se_cfg.json  ${VAULT_ADDR}/v1/database/config/postgresql

.PHONY: se-root-rotate
se-root-rotate: ## 	Rotate PGSQL root creds
	@curl -X POST -sk -H "X-Vault-Token: $(shell cat vault_creds.json | jq -r '.root_token')" ${VAULT_ADDR}/v1/database/rotate-root/postgresql

.PHONY: se-create-ro-role
se-create-ro-role: ## Create RO role
	@curl -X POST -sk -H "X-Vault-Token: $(shell cat vault_creds.json | jq -r '.root_token')" -d @payloads/pgsql_role_ro.json ${VAULT_ADDR}/v1/database/roles/pgsql-ro
