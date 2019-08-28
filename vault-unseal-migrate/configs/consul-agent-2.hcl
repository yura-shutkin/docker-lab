acl = {
  enabled = false
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

data_dir = "/consul/data"
bind_addr = "0.0.0.0"
retry_join = [
  "consul-server-1",
]
node_name = "consul-agent-2"
datacenter = "vault-storage-local"
server = false
ui = true
log_level = "info"
