ARG CONSUL_VERSION=1.7.2
ARG VAULT_VERSION=1.3.0

FROM consul:${CONSUL_VERSION} as consul-image
FROM vault:${VAULT_VERSION}

COPY --from=consul-image /consul /consul
COPY --from=consul-image /bin/consul /bin/consul

COPY startup.sh /bin/startup.sh

ENTRYPOINT ["/bin/startup.sh"]
