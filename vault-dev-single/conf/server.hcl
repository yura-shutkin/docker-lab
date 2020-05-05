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
  address = "192.168.9.2:8200"
}

log_level = "trace"
log_format = "json"
disable_mlock = true
ui = true
