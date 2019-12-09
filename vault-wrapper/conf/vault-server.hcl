//storage "file" {
//  path = "vault/data/"
//}

storage "inmem" {}

telemetry {
  disable_hostname = true
  prometheus_retention_time = "1h"
}

listener "tcp" {
  address = "10.100.1.2:8200"
  cluster_address = "10.100.1.2:8201"
  tls_disable = true
}

log_level = "trace"
disable_mlock = true
api_addr = "http://10.100.1.2:8200"
cluster_addr = "http://10.100.1.2:8201"
ui = true
