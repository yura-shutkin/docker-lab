storage "consul" {
  address = "127.0.0.1:8500"
  path = "vault/"
  scheme = "http"
  token = "d565f7b1-a1ac-f91a-eaa5-820ca3f03124"
}

listener "tcp" {
  address     = "192.168.4.6:8200"
  tls_disable = "true"
  cluster_address = "192.168.4.6:8201"
}

ui = "true"

# api_addr = "http://192.168.4.5:8200"
# cluster_addr = "https://192.168.4.5:8200"