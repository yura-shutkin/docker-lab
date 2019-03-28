### Vault auto unseal display stand

This small lab shows how auto unseal works with transit

```
It is not possible circular cluster unseal.
You can not unseal cluster with cluster which has seal type Transit
```

### How to start

* Validate docker-compose config
```
docker-compose config
```

* Launch cluster
```
docker-compose up -d
```

* Restore backup
```
consul snapshot restore -http-addr=http://192.168.10.2:8500 backup.snap
```

* Unseal second vault instance. Use unseal keys from [creds.yml](creds.yml)
```
export VAULT_ADDR=http://192.168.10.6:8200
vault unseal
```

* Authenticate to vault_second. You can use root token from [creds.yml](creds.yml)
```
vault login
```

* Get vault_first_transit role-id
```
ROLE_ID=$(vault read -field=role_id auth/approle/role/vault_cluster_transit/role-id)
```

* Get vault_first_transit secret-id
```
SECRET_ID=$(vault write -force -field=secret_id auth/approle/role/vault_cluster_transit/secret-id)
```

* Get vault_first_transit token
```
vault write -field=token auth/approle/login role_id="$ROLE_ID" secret_id="$SECRET_ID"
```

* Update token at vault_first [config](config/first.hcl)

* Update token at vault_second [config](config/second.hcl)

* Update token at vault_third [config](config/third.hcl)

* Restart vault_first if necessary
```
docker-compose restart vault_first
```

* Check vault_cluster

[vault_first](http://192.168.10.3:8200)

[vault_second](http://192.168.10.4:8200)

[vault_third](http://192.168.10.5:8200)


### How to stop

* To stop containers and wipe network interface of display stand execute
```
docker-compose down
```
