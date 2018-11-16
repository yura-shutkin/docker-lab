#!/usr/bin/env bash

VAULT_SERVERS="vault-client-1 vault-client-2 vault-client-3"
VAULT_PORT="443"
VAULT_KEY=$(cat ./vault-key)

for vault_srv in $VAULT_SERVERS; do
  docker exec -ti $vault_srv vault operator unseal -address=http://127.0.0.1:8200 "$VAULT_KEY"
done
