storage "file" {
  path = "vault/file/"
}

telemetry {
  disable_hostname = true
  prometheus_retention_time = "720h"
}

log_level = "trace"
disable_mlock = true
ui = true
