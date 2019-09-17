SHELL := /bin/bash
DEFAULT_GOAL := help

CONTAINERS := $(shell docker-compose config --services)
project_env := $(shell grep COMPOSE_PROJECT_NAME .env | sed 's/.*=//')

.PHONY: help
help: ## Show this help
	@sed -e '/__hidethis__/d; /##/!d; s/:.\+## /\t/g' $(MAKEFILE_LIST)

.PHONY: up
up: ## Start project
	@if [ ! -f .env ]; then cp .env.example .env; echo "No .env file found. New created. Please try again"; exit 1 ; fi
	@docker-compose up -d
	@sleep 5
	@$(MAKE) get_ips

.PHONY: down
down: ## Stop project and cleanup with volumes
	@docker-compose down -v

.PHONY: get_ips
get_ips: ## Show containers IP
	@for container in $(CONTAINERS); do \
		printf "%-30s %-15s" "$$container" "$$IP"; \
		docker inspect "$(project_env)_$$container"_1 | jq '.[0].NetworkSettings.Networks' | grep IPAddress | sed -e 's/",.*//' -e 's/.*"//g'; \
	done
