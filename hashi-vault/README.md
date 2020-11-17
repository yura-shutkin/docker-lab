## Hashi vault demo

In this demo you can see how to grub ssh password from Vault via ansible hashi_vault module and use it to connect into ssh server

### Recuirements

* Infrastructure
  * docker and docker-compose

  or

  * Hashicorp Vault client

* Python requirements described at [requirements.txt](requirements.txt)

* sshpass (at least on Ubuntu 20.04)

### How to setup environment

* Start Hashicorp Vault
  * via docker
    ```
    docker-compose up -d
    ```

  * via cmd
    ```
    vault server -dev -dev-root-token-id=12345
    ```

* Login into [Vault](http://127.0.0.1:8200)

* Enable approle auth backend via Web UI

* Create policy via Web UI from [secret-rw.hcl](secret-rw.hcl)

* Create role of approle auth backend
  ```
  write auth/approle/role/ansible-helper policies=secret-rw token_ttl=24h token_max_ttl=24h
  ```
* Get role creds via Vault Web UI cli 
  ```
  read auth/approle/role/ansible-helper/role-id
  write -force auth/approle/role/ansible-helper/secret-id
  ```

* Store password to [Vault](http://127.0.0.1:8200/ui/vault/secrets/secret/show/dev) into field pass

* Check connection to host
```
ansible -i environments/dev -m setup all -e ansible_host_dev=<REDACTED> -e role_id=2afd439e-d072-9f20-b8bd-fd3f0c5e2eb0 -e secret_id=8a7ef703-3d5d-0f72-e730-ed909d091f1e -u <REDACTED>
```

