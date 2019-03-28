path "transit/encrypt/vault_cluster" {
  capabilities = ["update"]
}

path "transit/decrypt/vault_cluster" {
  capabilities = ["update"]
}

path "auth/approle/role/vault_cluster_transit/role-id" {
  capabilities = ["read"]
}

path "auth/approle/role/vault_cluster_transit/secret-id" {
  capabilities = ["update"]
}
