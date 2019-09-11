cache {
  use_auto_auth_token = false
}

listener "tcp" {
  address = "0.0.0.0:8200"
  tls_disable = true
}

vault {
  address = "http://vault-server:8200"
}
