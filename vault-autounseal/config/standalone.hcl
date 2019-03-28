storage "consul" {
  address            = "192.168.10.2:8500"
  path               = "vault_standalone"
  scheme             = "http"
  service_tags       = "vault-standalone"
  service_address    = "vault_standalone"
}

listener "tcp" {
  address            = "192.168.10.6:8200"
  tls_disable        = "true"
}

ui                   = true
log_level            = "Trace"
