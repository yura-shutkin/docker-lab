SHELL := /bin/bash# __hidethis__
DEFAULT_GOAL := help# __hidethis__

################################################################################
### Grafana Keycaloak integration ##############################################
################################################################################

.PHONY: help
help: ## 			Show this help.
	@sed -e '/__hidethis__/d; /^\.PHONY.*/d; /[A-Z0-9#]?*/!d; /^\t/d; s/:.##/\t/g; s/^####.*//; s/#/-/g; s/^\([A-Z0-9_]*=.*\)/| \1/g; s/^\([a-zA-Z0-9]\)/* \1/g; s/^| \(.*\)/\1/' $(MAKEFILE_LIST)

.PHONY: create-data-dirs
create-data-dirs: # __hidethis__
	-@if [ ! -d data/grafana ]; then mkdir -p data/grafana; fi
	-@if [ ! -d data/pgsql ]; then mkdir -p data/pgsql; fi

.PHONY: rm-data-dirs
rm-data-dirs: # __hidethis__
	-@if [ -d data/grafana ]; then rm -rf data/grafana; fi
	-@if [ -d data/pgsql ]; then rm -rf data/pgsql; fi

################################################################################
### Docker #####################################################################
################################################################################

.PHONY: docker-svc-start
docker-svc-start: # __hidethis__
	@docker-compose up -d ${SVC}

.PHONY: docker-svc-stop
docker-svc-stop: # __hidethis__
	@docker-compose stop ${SVC}

.PHONY: docker-svc-restart
docker-svc-restart: # __hidethis__
	@$(MAKE) docker-svc-stop
	@$(MAKE) docker-svc-start

.PHONY: docker-svc-logs
docker-svc-logs: # __hidethis__
	@docker-compose logs ${SVC}

.PHONY: docker-svc-logs-tail
docker-svc-logs-tail: # __hidethis__
	@docker-compose logs -f ${SVC}

.PHONY: docker-svc-recreate
docker-svc-recreate: ## 	Cleanup service's DB and restart it
	@$(MAKE) docker-svc-stop SVC=${SVC}
	# Sleep 1 second to be sure everything is stopped
	@sleep 1
	@rm -rf data/${SVC}/*
	@$(MAKE) create-data-dirs
	@$(MAKE) docker-svc-start SVC=${SVC}

.PHONY: docker-env-start
docker-env-start: ## 	Launch or update project
	@$(MAKE) create-data-dirs
	@docker-compose up -d

.PHONY: docker-env-stop
docker-env-stop: ## 	Launch or update project
	@docker-compose stop

.PHONY: docker-env-ps
docker-env-ps: ## 		Show containers in docker env
	@docker-compose ps -a

.PHONY: docker-env-logs
docker-env-logs: ## 	Show logs from docker env
	@docker-compose logs

.PHONY: docker-env-tail
docker-env-tail: ## 	Tail logs from docker env
	@docker-compose logs -f

.PHONY: docker-env-destroy
docker-env-destroy: ## 	Stop project and remove containers
	@docker-compose down

.PHONY: docker-env-cleanup
docker-env-cleanup: ## 	Stop project and remove volumes and orphans as well
	-docker-compose down --volumes --remove-orphans
	@$(MAKE) rm-data-dirs

.PHONY: docker-compose-validate
docker-compose-validate: ##Check if docker-compose valid
	@echo "Profiles:"
	@echo -en "\r\t"; docker-compose config --profiles
	@echo "Services:"
	@echo -en "\r\t"; docker-compose config --services --volumes --images
	@echo "Volumes:"
	@echo -en "\r\t"; docker-compose config --volumes
	@echo "Images:"
	@echo -en "\r\t"; docker-compose config --images

.PHONY: docker-compose-pull
docker-compose-pull: ##	Pull images
	@docker-compose pull

################################################################################
### Terraform ##################################################################
################################################################################

.PHONY: tf-init
tf-init: # __hidethis__
	@terraform -chdir=terraform/${SVC} init

.PHONY: tf-apply
tf-apply: # __hidethis__
	@terraform -chdir=terraform/${SVC} apply -auto-approve

.PHONY: tf-plan
tf-plan: # __hidethis__
	@terraform -chdir=terraform/${SVC} plan

.PHONY: tf-validate
tf-validate: # __hidethis__
	@terraform -chdir=terraform/${SVC} validate

.PHONY: tf-state-list
tf-state-list: # __hidethis__
	@terraform -chdir=terraform/${SVC} state list

.PHONY: tf-state-rm
tf-state-rm: # __hidethis__
	@terraform -chdir=terraform/${SVC} state rm "${TARGETS}"

.PHONY: tf-state-recreate
tf-state-recreate: # __hidethis__
	@rm -rf terraform/${SVC}/.terraform
	@rm -f terraform/${SVC}/terraform.tfstate*
	@$(MAKE) tf-init

################################################################################
### Grafana ####################################################################
################################################################################

################################################################################
### Keycloak ###################################################################
################################################################################
