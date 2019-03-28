storage "consul" {
  address            = "192.168.10.2:8500"
  path               = "vault_cluster"
  scheme             = "http"
  service_tags       = "vault-cluster"
  service_address    = "vault_third"
}

listener "tcp" {
  address            = "192.168.10.5:8200"
  cluster_address    = "192.168.10.5:8201"
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
api_addr             = "http://vault_third:8200"
cluster_addr         = "https://vault_third:8201"
