#!/usr/bin/env bash

CONSUL_TOKEN=$(curl -fs -X PUT http://192.168.4.2:8500/v1/acl/bootstrap | sed -e 's/.*:"//g' -e 's/".*//g')
if [ -z $CONSUL_TOKEN ]; then
  CONSUL_TOKEN=$(cat ./consul-bootstrap-key)
fi

docker exec -ti consul-cluster-node-1 consul snapshot restore -http-addr=192.168.4.2:8500 --token=$CONSUL_TOKEN consul.snap
