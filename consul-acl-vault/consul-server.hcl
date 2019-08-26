acl = {
  enabled = true
  default_policy = "deny"
  enable_token_persistence = true
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
node_name = "consul-server"
datacenter = "vault-storage-local"
server = true
ui = true
log_level = "info"
bootstrap_expect = 1
bootstrap = true
