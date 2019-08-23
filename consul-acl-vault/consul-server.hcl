acl = {
  enabled = true
  default_policy = "deny"
  enable_token_persistence = true
}

telemetry {
  disable_hostname = true
  prometheus_retention_time = "1h"
}

bind_addr = "0.0.0.0"
node_name = "consul-server"
datacenter = "vault-storage-local"
server = true
ui = true
