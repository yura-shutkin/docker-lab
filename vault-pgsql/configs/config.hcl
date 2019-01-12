storage "postgresql" {
  max_parallel = "128"
  table = "vault_kv_store"
  connection_url = "postgres://vault:12345@vault-pgsql-db:5432/vault_db?sslmode=disable"
}

listener "tcp" {
  address     = "192.168.4.84:8200"
  tls_disable = "true"
  proxy_protocol_behavior = "allow_authorized"
  proxy_protocol_authorized_addrs = "192.168.4.83"
  x_forwarded_for_authorized_addrs = "192.168.4.83/32"
  x_forwarded_for_reject_not_authorized = "true"
  x_forwarded_for_reject_not_present = "true"
}

ui = "true"
