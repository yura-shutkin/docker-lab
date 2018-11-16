ARG ALPINE_VERSION=3.8

FROM alpine:$ALPINE_VERSION

ARG STATSD_EXPORTER_VERSION=0.8.0

RUN wget https://github.com/prometheus/statsd_exporter/releases/download/v$STATSD_EXPORTER_VERSION/statsd_exporter-$STATSD_EXPORTER_VERSION.linux-amd64.tar.gz && \
    tar xzfv statsd_exporter-$STATSD_EXPORTER_VERSION.linux-amd64.tar.gz && \
    mv statsd_exporter-$STATSD_EXPORTER_VERSION.linux-amd64/statsd_exporter /usr/bin/ && \
    rm -Rfv statsd_exporter-$STATSD_EXPORTER_VERSION.linux-amd64*

CMD ["/usr/bin/statsd_exporter"]
