SHELL := /bin/bash
DEFAULT_GOAL := help

.PHONY: help
help: ## 	Show this help.
	@sed -e '/__hidethis__/d; /##/!d; s/:.\+## /\t/g' $(MAKEFILE_LIST)

.PHONY: up-consul
up-consul: ## Launch or update consul server
	@docker-compose up -d consul-1
	@echo "Check http://192.168.10.2:8500"

.PHONY: up-vault
up-vault: ## Launch or update vault client node
	@docker-compose up -d client-1
	@echo "sleep for 5 seconds be cause no liveness probes set"
	@sleep 5
	@curl -sk -X GET https://192.168.10.3/v1/sys/init | grep false && curl -sk -X PUT -d '{"secret_shares": 1, "secret_threshold": 1}' -o vault_creds.json https://192.168.10.3/v1/sys/init
	@echo "Check https://192.168.10.3"
	@cat vault_creds.json

.PHONY: up-prometheus
up-prometheus: ## Launch or update prometheus
	@docker-compose up -d prometheus
	@echo "Check http://192.168.10.4:9090"

.PHONY: down
down: ## 	Stop project and remove containers
	@docker-compose down

.PHONY: cleanup
cleanup: ## 	Stop project and remove volumes and orphans as well
	-docker-compose down --volumes --remove-orphans
	-rm -v vault_creds.json