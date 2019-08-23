acl = {
  enabled = true
  tokens = {
    agent = "<consul-agent_agent_token>"
  }
}

telemetry {
  disable_hostname = true
  prometheus_retention_time = "1h"
}

bind_addr = "0.0.0.0"
retry_join = [
  "consul-server",
]
node_name = "consul-agent"
datacenter = "vault-storage-local"
server = false
ui = false
