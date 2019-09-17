acl = {
  enabled = true
  default_policy = "deny"
  enable_token_persistence = true
  tokens = {
    master = "ccc5a4d0-30fb-e889-d56c-628506c66af2"
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

ports = {
  http = 8500
  grpc = 8502
  serf_lan = 8301
  server = 8300
}

encrypt = "n1WMEbisM5Jx9jQWvgyciw=="
data_dir = "/consul/data"
bind_addr = "0.0.0.0"
node_name = "consul-server"
datacenter = "vault-storage-local"
server = true
ui = true
log_level = "info"
bootstrap_expect = 2
//bootstrap = true
retry_join = [
  "consul-server:8301",
  "consul-server-standby-1:8301",
  "consul-server-standby-2:8301"
]
