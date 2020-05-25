storage "file" {
  path = "vault/file/"
}

telemetry {
  disable_hostname = true
  prometheus_retention_time = "720h"
}

listener "tcp" {
  telemetry {
    unauthenticated_metrics_access = true
  }
  tls_disable = true
  address = "192.168.9.10:8200"
}

seal "shamir" {}

log_level = "trace"
log_format = "json"
disable_mlock = false
ui = true

cluster_name = "local"
api_addr = "http://192.168.9.10:8200"
