# Docker lab
---

This project was started as playground for launching light weight infra, testing configuration and education

## Requirements:

* docker >= 17.05
* docker-compose >= 1.21.2
* Linux

## Current projects:

* [consul-acl-vault](/consul-acl-vault)

    Sandbox for testing work with Consul ACL and granting necessary rights to Vault instance

* [consul-metrics](/consul-metrics)

    Sandbox for testing how to grab metrics from Consul

* [consul-replicate](/consul-replicate)
  
        OLD and, probably, not working since 1.5.x of Consul
    Example how to replicate data between consul data centers

* [docker-cleanup](/docker-cleanup)

    Image for cleaning from unused containers and images

* [graylog](/graylog)

        Abandoned and, probably, not working
    Sandbox for learn how to use Graylog

* [elasticsearch-cluster](/elasticsearch-cluster)

        Abandoned and, probably, not working
    Infra for log accumulation and processing

* [minio](/minio)

    Basic MinIO server setup for development

* [prometheus](/prometheus)

    Prometheus + Grafana

* [redis-cluster](/redis-cluster)

        Very first project. Should be rewritten. It is possible to start instances of redis without specifying who is primary and who standby and use ansible for further configuring.
    Redis cluster. Nothing special

* [teamcity-vault-plugin](/teamcity-vault-plugin)

    Sandbox for testing integration of Vault into Teamcity

* [vault-autounseal](/vault-autounseal)

    Vault auto unseal cluster with transit from other Vault cluster (or instance) 

* [vault-cache](/vault-cache)

    Optimizing requests to Vault cluster

* [vault-cluster](/vault-cluster)

        Very first project and should be refactored
    Consul cluster + prometheus statsd exporter + vault cluster

* [vault-dev-single](/vault-dev-single)

    Single node of Vault with persistent storage and set of capabilities

* [vault-metrics](/vault-metrics)

    Metrics from Vault cluster to Prometheus

* [vault-pgsql](/vault-pgsql)

    Vault with PostgreSQL as storage

* [vault-unseal-migrate](/vault-unseal-migrate)

    Sandbox for testing migration from shamir to transit and back 

* [vault-wrapper](/vault-wrapper)

    Vault server + Vault agent with role of type approle and periodic token for wrapping messages wich can be grabbed much more longer than token_ttl and token_max_ttl

* [web-proxy](/web-proxy)

    Web proxy for accessing containers web UI
    
    I would like to migrate this project to traefic with auto discovery

## License:

[MIT](/LICENSE) 

## Author

Yura Shutkin (yshutkin@infra-lab.xyz)
