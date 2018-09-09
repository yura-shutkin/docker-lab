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

.PHONY: startup
restart: ## restart project
	docker-compose --project-name=vault-cluster restart

.PHONY: restore-snap
restore-snap: ## Restore consul snapshot
	curl -s -X PUT http://127.0.0.1:18500/v1/acl/bootstrap | sed -e 's/.*:"//g' -e 's/".*//g'
	consul snapshot restore -http-addr=127.0.0.1:18500 --token=$CONSUL_BOOTSTRAP consul.snap

.PHONY: vault-unseal
vault-unseal: ## Outputs all ssh keys in authorized_keys style
	VAULT_KEY=$(cat vault-key)
	for SRV in 192.168.4.{6..8}; do vault operator unseal -address=http://$SRV:8200 $VAULT_KEY; done
