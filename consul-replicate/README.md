### Consul replicate example and tips

---

#### Initial setup:

```
docker-compose up -d
curl -X PUT http://192.168.4.66:8500/v1/acl/bootstrap
curl -X PUT http://192.168.4.69:8500/v1/acl/bootstrap
```

##### Alpha management ACL:

`payload.json`
```
{
  "ID": "b339711c-ce89-b2ca-4fd7-02492e2f5d0f",
  "Name": "manager",
  "Type": "management",
  "Rules": ""
}
```
```
curl -H "X-Consul-Token: <token>" --data @payload.json -X PUT http://192.168.4.66:8500/v1/acl/create
```

##### Alpha replication ACL:

`payload.json`
```
{
  "ID": "9503fa51-cefd-9ba6-7ea8-728e65f95e79",
  "Name": "replication",
  "Type": "client",
  "Rules": "key \"vault-test\" { policy = \"read\" }"
}
```
```
curl -H "X-Consul-Token: <token>" --data @payload.json -X PUT http://192.168.4.66:8500/v1/acl/create
```

##### Alpha add Beta encryption key:

`payload.json`
```
{
  "Key": "SUyymEPna7XA69Kz0yga3A=="
}
```

```
curl -X POST --data @payload.json http://192.168.4.66:8500/v1/operator/keyring
```



##### Beta management ACL:

`payload.json`
```
{
  "ID": "1c83fb9d-4410-5925-f338-78bec763b941",
  "Name": "manager",
  "Type": "management",
  "Rules": ""
}
```
```
curl -H "X-Consul-Token: <token>" --data @payload.json -X PUT http://192.168.4.69:8500/v1/acl/create
```

##### Beta replication ACL:

`payload.json`
```
{
  "ID": "9503fa51-cefd-9ba6-7ea8-728e65f95e79",
  "Name": "replication",
  "Type": "client",
  "Rules": "key \"vault-test\" { policy = \"write\" } key \"service\" { policy = \"write\" }"
}
```
```
curl -H "X-Consul-Token: <token>" --data @payload.json -X PUT http://192.168.4.69:8500/v1/acl/create
```

##### Beta add Alpha encryption key:

`payload.json`
```
{
  "Key": "ltSuNxdFRZxtp5SuT5XtzA=="
}
```

```
curl -X POST --data @payload.json http://192.168.4.69:8500/v1/operator/keyring
```

#### Launch:

```
consul-replicate -config=consul-replicate.hcl
```

---

#### Tips:

---

    * Exclude source should not be empty or no one kv will be replicated

    * You should start replication at DC where to replicate, not from
