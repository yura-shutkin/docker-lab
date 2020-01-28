storage "file" {
  path = "/vault/file/data"
}

telemetry {
  disable_hostname = true
  prometheus_retention_time = "1h"
}

listener "tcp" {
  address = "172.18.1.12:8200"
  cluster_address = "172.18.1.12:8201"
  tls_disable = true
}

log_level = "info"
disable_mlock = true
ui = true
