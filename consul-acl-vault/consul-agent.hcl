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

addresses = {
  http = "0.0.0.0"
  https = "0.0.0.0"
  grpc = "0.0.0.0"
}

encrypt = "n1WMEbisM5Jx9jQWvgyciw=="
data_dir = "/consul/data"
bind_addr = "0.0.0.0"
retry_join = [
  "consul-server",
]
node_name = "consul-agent"
datacenter = "vault-storage-local"
server = false
ui = true
log_level = "debug"
