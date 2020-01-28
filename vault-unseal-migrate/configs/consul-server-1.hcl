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
node_name = "consul-server-1"
datacenter = "vault-storage-local"
server = true
ui = true
log_level = "info"
bootstrap_expect = 1
bootstrap = true
