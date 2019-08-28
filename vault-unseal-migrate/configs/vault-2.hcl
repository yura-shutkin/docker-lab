storage "consul" {
  address = "consul-agent-2:8500"
  path = "vault-main-cluster/"
  scheme = "http"
  service = "vault"
  service_tags = "vault-main-cluster"
  service_address = "vault-2"
}

telemetry {
  disable_hostname = true
  prometheus_retention_time = "1h"
}

listener "tcp" {
  address = "172.18.1.13:8200"
  cluster_address = "172.18.1.13:8201"
  tls_disable = true
}

log_level = "info"
disable_mlock = true
api_addr = "http://172.18.1.13:8200"
cluster_addr = "http://172.18.1.13:8201"
ui = true
