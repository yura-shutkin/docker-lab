storage "consul" {
  address            = "192.168.10.2:8500"
  path               = "vault_cluster"
  scheme             = "http"
  service_tags       = "vault-cluster"
  service_address    = "vault_second"
}

listener "tcp" {
  address            = "192.168.10.4:8200"
  cluster_address    = "192.168.10.4:8201"
  tls_disable        = "true"
}

seal "transit" {
  address            = "http://192.168.10.6:8200"
  token              = "s.uXxcNBQ0p4klswhz5bIaPw5n"
  disable_renewal    = "false"

  // Key configuration
  key_name           = "vault_cluster"
  mount_path         = "transit/"
  namespace          = "root/"

  // TLS Configuration
  tls_skip_verify    = "true"
}

ui                   = true
api_addr             = "http://vault_second:8200"
cluster_addr         = "https://vault_second:8201"
