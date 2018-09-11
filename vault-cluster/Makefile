SHELL := /bin/bash
DEFAULT_GOAL := help

-include vars.mk

CWD := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

export

.PHONY: help
help: ## Show this help.
	@sed -e '/__hidethis__/d; /##/!d; s/:.\+## /\t/g' $(MAKEFILE_LIST)

.PHONY: cleanup
cleanup: ## stop project and remove data
	docker-compose --project-name=vault-cluster down
	sudo rm -rfv data/*

.PHONY: startup
startup: ## launch project
	docker-compose --project-name=vault-cluster up -d

.PHONY: restart
restart: ## restart project
	docker-compose --project-name=vault-cluster restart

.PHONY: consul-restore
consul-restore: ## Restore consul snapshot
	scripts/consul_restore.sh

.PHONY: vault-unseal
vault-unseal: ## Outputs all ssh keys in authorized_keys style
	scripts/unseal_vault.sh
