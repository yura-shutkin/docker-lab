#!/usr/bin/env bash

VAULT_SERVERS="192.168.4.6 192.168.4.7 192.168.4.8"
VAULT_PORT="8200"
VAULT_KEY=$(cat ./vault-key)

for vault_srv in $VAULT_SERVERS; do
  curl -X PUT --data '{ "key": "'"$VAULT_KEY"'" }' http://"$vault_srv":"$VAULT_PORT"/v1/sys/unseal
done
