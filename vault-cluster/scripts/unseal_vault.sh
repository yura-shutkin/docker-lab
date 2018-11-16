#!/usr/bin/env bash

VAULT_SERVERS="vault-node-1.local vault-node-2.local vault-node-3.local"
VAULT_PORT="443"
VAULT_KEY=$(cat ./vault-key)

for vault_srv in $VAULT_SERVERS; do
  curl -X PUT --data '{ "key": "'"$VAULT_KEY"'" }' --connect-timeout 2 -k https://"$vault_srv":"$VAULT_PORT"/v1/sys/unseal
done
