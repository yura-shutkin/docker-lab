ARG CONSUL_VERSION=1.3.0
ARG VAULT_VERSION=0.11.3

FROM consul:${CONSUL_VERSION} as consul-image


FROM vault:${VAULT_VERSION}

COPY client-srv-startup.sh /startup.sh

COPY --from=consul-image /consul /consul
COPY --from=consul-image /bin/consul /bin/consul

RUN ln -s /run/rsyslog/dev/log /dev/log

ENTRYPOINT ["/startup.sh"]
