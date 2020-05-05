storage "postgresql" {
  max_parallel = "128"
  table = "kv_store"
  connection_url = "postgres://r_vault:s3cr3TT@pgsql:5432/vault_db?search_path=vault&sslmode=disable"
  ha_enabled = true
  ha_table = "ha_locks"
}

listener "tcp" {
  address = "192.168.4.83:8200"
  tls_disable = true
  telemetry {
    unauthenticated_metrics_access = true
  }
  # proxy_protocol_behavior = "allow_authorized"
  # proxy_protocol_authorized_addrs = "192.168.4.83"
  # x_forwarded_for_authorized_addrs = "192.168.4.83/32"
  # x_forwarded_for_reject_not_authorized = "true"
  # x_forwarded_for_reject_not_present = "true"
}

listener "tcp" {
  address = "127.0.0.1:8200"
  tls_disable = true
}

telemetry {
  disable_hostname = true
  prometheus_retention_time = "8760h"
}

seal "shamir" {}

log_level = "err"
ui = true
