SHELL := /bin/bash
DEFAULT_GOAL := help

.PHONY: help
help: ## 	Show this help.
	@sed -e '/__hidethis__/d; /##/!d; s/:.\+## /\t/g' $(MAKEFILE_LIST)

.PHONY: up
up: ## 	Launch or update project
	@docker-compose up -d
	@curl -s -X GET http://192.168.9.2:8200/v1/sys/init | grep false && curl -s -X PUT -d '{"secret_shares": 1, "secret_threshold": 1}' -o vault_creds.json http://192.168.9.2:8200/v1/sys/init
	@echo "Check http://192.168.9.2:8200"

.PHONY: up-attach
up-attach: ## Launch or update project but not detach
	@docker-compose up

.PHONY: down
down: ## 	Stop project and remove containers
	@docker-compose down

.PHONY: cleanup
cleanup: ## 	Stop project and remove volumes and orphans as well
	-docker-compose down --volumes --remove-orphans
	-rm -v vault_creds.json
	-sudo rm -Rfv data/* !\(".keep"\)
