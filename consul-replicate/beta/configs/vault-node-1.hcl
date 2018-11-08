storage "consul" {
  address         = "b-agent-1:8500"
  path            = "vault-test/"
  scheme          = "http"
  token           = "1c83fb9d-4410-5925-f338-78bec763b941"
  service_tags    = "vault-test"
  service_address = "b-vault-node-1"
}

listener "tcp" {
  tls_disable     = "true"
  address         = "192.168.4.75:8200"
  cluster_address = "192.168.4.75:8201"
}

listener "tcp" {
  tls_disable = "true"
  address     = "127.0.0.1:8200"
}

ui = "true"

api_addr     = "http://b-vault-node-1:8200"
cluster_addr = "https://b-vault-node-1:8201"
