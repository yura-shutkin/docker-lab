# Vault metrics playground

### Requirements
* docker
* docker-compose

## How to launch
* Copy .env.example to .env `cp .env.example .env`
* Validate .env `vim .env`
* Start very basic consul server `make up-consul`
* Start vault node `make up-vault`
* Copy unseal key from output
* Start prometheus `make up-prometheus`

## How to cleanup
* Run `make cleanup`

## How to restart service
* Restart consul: `docker-compose restart consul-1`
* Restart vault: `docker-compose restart client-1`
* Restart prometheus: `docker-compose restart prometheus`
