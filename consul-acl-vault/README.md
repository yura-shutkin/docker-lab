# Consul ACL Vault

## Documentation
* [how setup ACL on consul](https://learn.hashicorp.com/consul/security-networking/production-acls)
* [consul storage backend for vault](https://www.vaultproject.io/docs/configuration/storage/consul.html)

## Start instructions
* `docker-compose up -d consul-server`
* `consul acl bootstrap`
* `export CONSUL_HTTP_TOKEN=<your-SecretID>`
* `consul acl policy create -name "vault-node" -description "Policy for vault with kv vault" -datacenter "vault-storage-local" -rules @vault-node-policy.hcl`
