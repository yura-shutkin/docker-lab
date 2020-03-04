SHELL := /bin/bash
DEFAULT_GOAL := help

.PHONY: help
help: ## 	Show this help.
	@sed -e '/__hidethis__/d; /##/!d; s/:.\+## /\t/g' $(MAKEFILE_LIST)

.PHONY: up
up: ## Launch or update project
	@docker-compose up -d
	@echo "Check http://192.168.9.2:8200"

.PHONY: up-attach
up-attach: ## Launch or update project but not detach
	@docker-compose up

.PHONY: down
down: ## Stop project and remove containers
	@docker-compose down

.PHONY: cleanup
cleanup: ## Stop project and remove volumes and orphans as well
	@docker-compose down --volumes --remove-orphans
	@sudo rm -Rfv data/* !\(".keep"\)
