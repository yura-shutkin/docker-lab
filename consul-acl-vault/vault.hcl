storage "consul" {
  address = "consul-agent:8500"
  path = "vault/"
  token = ""
  scheme = "http"
  service = "vault"
  service_tags = "vault-local"
  service_address = "vault-local-node"
}

telemetry {
  disable_hostname = true
  prometheus_retention_time = "1h"
}

log_level = "Info"
