storage "consul" {
  address = "http://127.0.0.1:8500"
  path = "vault/"
  service_address = "client-2"
}

telemetry {
  disable_hostname = true
  prometheus_retention_time = "720h"
}

listener "tcp" {
  # just in case we don't want to bother with tokens
  telemetry {
    unauthenticated_metrics_access = true
  }
  tls_disable = false
  tls_cert_file = "certs/cert.pem"
  tls_key_file = "certs/privkey.pem"
  address = "192.168.10.6:443"
}

log_level = "err"
api_addr = "https://192.168.10.6:8200"
ui = true
