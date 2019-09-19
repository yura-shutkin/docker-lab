## Consul metrics sandbox

### Preparation

Make sure you have:
* docker
* docker-compose
* you can use Makefile
* you have this record in `/etc/hosts`
 ```
 127.0.1.1       vault.local consul.local grafana.local prometheus.local
```

### How to start
* make up
* go to one of the links
  * [grafana](https://grafana.local)
  * [prometheus](https://prometheus.local)
  * [consul](https://consul.local)
  
  use `ccc5a4d0-30fb-e889-d56c-628506c66af2` as ACL token

### How to cleanup
* make down
