# Consul ACL Vault

## Documentation
* [how setup ACL on consul](https://learn.hashicorp.com/consul/security-networking/production-acls)
* [consul storage backend for vault](https://www.vaultproject.io/docs/configuration/storage/consul.html)
* [consul acl tutorial](https://learn.hashicorp.com/consul/security-networking/production-acls)

## Start instructions
* `docker-compose up -d consul-server`
* `consul acl bootstrap`
* `export CONSUL_HTTP_TOKEN=<your-SecretID>`
* `consul acl policy create -name "vault-node" -description "Policy for vault with kv vault" -datacenter "vault-storage-local" -valid-datacenter "vault-storage-local" -rules @vault-node-policy.hcl`
* `consul acl policy create -name "consul-agent" -description "Policy for consul-agent node" -datacenter "vault-storage-local" -valid-datacenter "vault-storage-local" -rules @consul-agent-policy.hcl`
* `consul acl token create --description "consul-agent agent" -policy-name "consul-agent"`
* `consul acl token create --description "vault node" -policy-name "vault-node"`
