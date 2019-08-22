acl = {
  enabled = true
  default_policy = "deny"
  enable_token_persistence = true
}

telemetry {
  disable_hostname = true
  prometheus_retention_time = "1h"
}

node_name = "consul-agent"
datacenter = "vault-storage-local"
server = false
ui = false
