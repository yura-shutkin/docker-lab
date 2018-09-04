FROM alpine:3.7

RUN addgroup hashicorp && adduser -S -G hashicorp hashicorp \
    && mkdir -p /consul/config /consul/data /vault/config /vault/data

COPY client-srv-startup.sh /startup.sh

COPY consul vault /bin/

ENTRYPOINT ["/startup.sh"]

