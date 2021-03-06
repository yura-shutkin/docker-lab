# Vault database playground with PostgreSQL as storage

### Requirements
* docker
* docker-compose

#```Attention```

    Field db_name of database role should be equals to connection name. 
    In example I set database/config/postgresql, so I need to use "db_name": "postgresql" except "db_name": "my_db_name" 

## Documentation
* [PostgreSQL as storage](https://www.vaultproject.io/docs/configuration/storage/postgresql)
* [Learn: Database Secret Engine](https://learn.hashicorp.com/vault/secrets-management/sm-dynamic-secrets)
* [Learn: Database Secret Engine root creds rotation](https://learn.hashicorp.com/vault/secrets-management/db-root-rotation)

## How to launch
* Copy .env.example to .env `cp .env.example .env`
* Validate .env `vim .env`
* Start project `make up`
* Mount Secret Engine `make se-mount`
* Configure Secret Engine `make se-setup`

## How to cleanup
* Run `make cleanup`
