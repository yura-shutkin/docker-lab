SHELL := /bin/bash
DEFAULT_GOAL := help

-include vars.mk

CWD := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

export

.PHONY: help
help: ## 	Show this help.
	@sed -e '/__hidethis__/d; /##/!d; s/:.\+## /\t/g' $(MAKEFILE_LIST)

.PHONY: cleanup
cleanup: ## 	Stop project and remove data
	docker-compose --project-name=vault-cluster down
	sudo rm -rfv data/*

.PHONY: startup
startup: ## 	Launch containers
	docker-compose --project-name=vault-cluster up -d

.PHONY: shutdown
shutdown: ## Stop containers
	docker-compose --project-name=vault-cluster down

.PHONY: restart
restart: ## 	Restart containers
	docker-compose --project-name=vault-cluster restart

.PHONY: consul-restore
consul-restore: ## Restore consul snapshot
	scripts/consul_restore.sh

.PHONY: vault-unseal
vault-unseal: ## Unseal vault
	scripts/unseal_vault.sh

.PHONY: vault-create-symlink-syslog
vault-create-symlink-syslog: ## Create symlink for syslog usage
	scripts/create_symlink_syslog.sh

.PHONY: mount-tmpfs
mount-tmpds: ## Mount tmpfs for consul with 512M size
	test -d data || mkdir data
	sudo mount -t tmpfs -o size=512M tmpfs data

.PHONY: unmount-tmpfs
unmount-tmpds: ## Unmount tmpfs for consul with 512M size
	sudo umount data

.PHONY: bootstrap
bootstrap: ## Launch project and unseal after kv restore
	make startup
	sleep 10
	make consul-restore
	make vault-unseal
