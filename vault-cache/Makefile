SHELL := /bin/bash
DEFAULT_GOAL := help

VAULT_SKIP_VERIFY := 1
CONSUL_SERVERS := consul-server
CONSUL_AGENTS := consul-agent
VAULT_NODES := vault-server
VAULT_ADDR := http://172.18.1.21:8200
VAULT_AGENT_ADDR := http://172.18.1.20:8200

.PHONY: help
help: ## Show this help
	@sed -e '/__hidethis__/d; /##/!d; s/:.\+## /\t/g' $(MAKEFILE_LIST)

.PHONY: validate
validate: ## just symlink to docker-compose config
	@yamllint docker-compose.yml -c yamllint.yml
	@docker-compose config

.PHONY: up
up: ## Start project
	@if [ ! -f .env ]; then cp -v .env.example .env; fi
	@$(MAKE) consul-server-start
	@$(MAKE) consul-agent-start
	@$(MAKE) vault-server-start
	@ echo 'Sleep for 5 sec before init vault'
	@sleep 5
	@$(MAKE) vault-server-init
	@$(MAKE) vault-server-unseal
	@$(MAKE) vault-agent-start
	@$(MAKE) enable-kv
	@$(MAKE) kv-put-secret

.PHONY: wipe
wipe: ## wipe project. Remove containers,images,volumes,networks
	@docker-compose down -v --remove-orphans --rmi all
	@rm -v *.json

.PHONY: down
down: ## stop project. Remove containers,networks
	@docker-compose down
	@rm -v *.json

.PHONY: vault-server-init
vault-server-init: ## init vault
	@$(eval export VAULT_ADDR=$(VAULT_ADDR))
	@vault operator init -key-shares=1 -key-threshold=1 -format=json > vault_creds.json

.PHONY: vault-server-unseal
vault-server-unseal: ## unseal vault
	@$(eval export VAULT_ADDR=$(VAULT_ADDR))
	@$(eval UNSEAL_KEY=$(shell cat vault_creds.json | jq -r '.unseal_keys_b64[0]'))
	@vault operator unseal $(UNSEAL_KEY)

.PHONY: vault-server-start
vault-server-start: ## start vault server
	@docker-compose up -d vault-server

.PHONY: vault-server-stop
vault-server-stop: ## stop vault server
	@docker-compose stop vault-server

.PHONY: vault-server-restart
vault-server-restart: ## restart vault server
	@$(MAKE) vault-server-stop
	@$(MAKE) vault-server-start

.PHONY: vault-agent-start
vault-agent-start: ## start vault agent
	@docker-compose up -d vault-agent

.PHONY: vault-agent-restart
vault-agent-restart: ## restart vault servers
	@docker-compose restart vault-agent

.PHONY: consul-server-start
consul-server-start: ## start consul server
	@docker-compose up -d consul-server

.PHONY: consul-server-restart
consul-server-restart: ## start consul server
	@docker-compose restart consul-server

.PHONY: consul-agent-start
consul-agent-start: ## start consul agent
	@docker-compose up -d consul-agent

.PHONY: consul-agent-restart
consul-agent-restart: ## start consul agent
	@docker-compose restart consul-agent

.PHONY: enable-kv
enable-kv: ## enable kv engine
	@$(eval export VAULT_ADDR=$(VAULT_ADDR))
	@$(eval export VAULT_TOKEN=$(shell cat vault_creds.json | jq -r '.root_token'))
	@vault secrets enable -path=project -default-lease-ttl=1m -max-lease-ttl=5m -version=1 kv

.PHONY: kv-put-secret
kv-put-secret: ## put secret to kv
	@$(eval export VAULT_ADDR=$(VAULT_ADDR))
	@$(eval export VAULT_TOKEN=$(shell cat vault_creds.json | jq -r '.root_token'))
	@vault kv put project/root_secret password="$(shell uuidgen)"

.PHONY: proxy-kv-get-secret
proxy-kv-get-secret: ## put secret to kv
	@$(eval export VAULT_ADDR=$(VAULT_AGENT_ADDR))
	@$(eval export VAULT_TOKEN=$(shell cat vault_creds.json | jq -r '.root_token'))
	@watch -n 1 vault kv get project/root_secret
