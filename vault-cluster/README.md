# Vault-cluster

This project can help you launch vault HA playground with consul backend

---

## Makefile:

    help            Show this help.
    cleanup         Stop project and remove data
    startup         Launch containers
    shutdown        Stop containers
    restart         Restart containers
    consul-restore  Restore consul snapshot
    vault-unseal    Unseal vault
    bootstrap       Launch project and unseal after kv restore

## Creds:

* [consul bootstrap token](./consul-bootstrap-key) for fully access to consul use it
* [vault unseal key](./vault-key) for unsealing vault
* [vault root token](./vault-token) for login into vault

## Web proxy

Moved to [web-proxy](../web-proxy)

To access via web proxy add into your /etc/hosts

    192.168.4.5     consul.local vault.local

* https://vault.local
* https://consul.local

### Full endpoints list:

##### Consul:
* http://192.168.4.2:8500 - consul node 1
* http://192.168.4.3:8500 - consul node 2
* http://192.168.4.4:8500 - consul node 3
* http://192.168.4.9:8500 - consul node 4
* http://192.168.4.10:8500 - consul node 5

##### Vault:
* http://192.168.4.6:8200 - vault node 1
* http://192.168.4.7:8200 - vault node 2
* http://192.168.4.8:8200 - vault node 3
