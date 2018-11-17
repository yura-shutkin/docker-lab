# Docker lab
---

This project was started as playground for launching light weight infra, testing configuration and education

## Requirements:

* docker >= 17.05
* docker-compose >= 1.21.2
* Linux

## Current projects:

* [Consul-replicate](/consul-replicate)
  
  Example how to replicate data between consul data centers

* [docker-cleanup](/docker-cleanup)

  Image for cleaning from unused containers and images

* [elasticsearch-cluster]

  Infra for log accumulation and processing

* [prometheus](/prometheus)

  Prometheus + Grafana

* [redis-cluster](/redis-cluster)

  Very first project. Should be rewritten. It is possible to start instances of redis without specifying who is primary and who standby and use ansible for further configuring.

* [vault](/vault)

  Just simple vault instance. Require no config for launching.

* [vault-cluste](/vault-cluster)

  Consul cluster + prometheus statsd exporter + vault cluster

* [web-proxy](/web-proxy)

  Web proxy for accessing containers web UI

## License:

[MIT](/LICENSE) 
