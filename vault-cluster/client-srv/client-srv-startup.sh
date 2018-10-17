#!/usr/bin/env sh

consul agent -config-dir /consul/config/ &

COUNTDOWN=30
COUNTER=0
while [ $COUNTER -le $COUNTDOWN ]
do
  if [ $COUNTER -eq $COUNTDOWN ]; then
    echo "Consul did not start in $COUNTDOWN sec"
    exit 1
  fi

  if nc -zv 127.0.0.1 8500; then
    echo "sleeping 1 sec"
    sleep 1
    COUNTER=$((COUNTER+1))
  else
    break
  fi
done

vault server --config=/vault/config/config.hcl

#COUNTDOWN=30
#COUNTER=0
#while [ $COUNTER -le $COUNTDOWN ]
#do
#  if [ $COUNTER -eq $COUNTDOWN ]; then
#    echo "Vault did not start in $COUNTDOWN sec"
#    exit 1
#  fi
#  nc -zv 127.0.0.1 8200
#  if [ $? -ne 0 ]; then
#    echo "sleeping 1 sec"
#    sleep 1
#    COUNTER=$((COUNTER+1))
#  else
#    break
#  fi
#done
