storage "consul" {
  address         = "a-agent-1:8500"
  path            = "vault-test/"
  scheme          = "http"
  token           = "b339711c-ce89-b2ca-4fd7-02492e2f5d0f"
  service_tags    = "vault-test"
  service_address = "a-vault-node-1"
}

listener "tcp" {
  tls_disable     = "true"
  address         = "192.168.4.74:8200"
  cluster_address = "192.168.4.74:8201"
}

listener "tcp" {
  tls_disable = "true"
  address     = "127.0.0.1:8200"
}

ui = "true"

api_addr     = "http://a-vault-node-1:8200"
cluster_addr = "https://a-vault-node-1:8201"
