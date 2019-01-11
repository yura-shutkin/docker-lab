#!/usr/bin/env bash

set +e

for container_name in vault-client-{1..3}; do
  echo "=================================================="
  echo "$container_name:"
  echo "=================================================="
  docker exec -ti "$container_name" ln -s /run/rsyslog/dev/log /dev/log
done
