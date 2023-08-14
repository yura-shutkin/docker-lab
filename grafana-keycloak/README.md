# Grafana OAuth with keycloak

## Prerequisites

- `/etc/hosts`

  ```
  127.0.0.1 localhost keycloak
  ```

## Requirements

- make
- jq
- curl
- docker-compose
- sed

## How to use

- To get help execute

  ```shell
  make help
  ```

- To create start project execute

  ```shell
  make docker-env-start
  ```

- To stop and cleanup execute

  ```shell
  make docker-env-cleanup
  ```

## Keycloak users in demo

| Username | Password | Role |
|---|---|---|
| adrole | 12345 | Admin |
| rwrole | 12345 | Editor |
| rorole | 12345 | Viewer |
| norole | 12345 | No role |


## How to check token

- Run

  ```shell
  echo; curl -s -X POST -d "username=adrole" -d "password=12345" -d 'grant_type=password' -d "client_id=grafana-oauth" -d "client_secret=cRvSzCriWCznntHkOpwTUPWyLln8aX5R" -H "Content-Type: application/x-www-form-urlencoded" http://keycloak:8080/realms/myorg/protocol/openid-connect/token | jq -r '.access_token'
  ```
- Parse the result token in https://jwt.io

**Or**

- http://keycloak:8080
- realm myorg
- Clients -> grafana-oauth -> Client scopes -> Evaluate

## Export realm

- Run

  ```shell
  docker-compose exec -ti keycloak bash
  ```

- Run

  ```shell
  /opt/keycloak/bin/kc.sh export --realm myorg --file /opt/keycloak/data/import/myorg.json
  ```
