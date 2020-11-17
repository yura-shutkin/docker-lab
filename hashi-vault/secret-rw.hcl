path "secret/metadata/*" {
  capabilities = ["list", "read", "update", "delete"]
}

path "secret/data/*" {
  capabilities = ["create", "read", "update", "delete"]
}

path "secret/delete/*" {
  capabilities = ["update"]
}

path "secret/undelete/*" {
  capabilities = ["update"]
}

path "secret/destroy/*" {
  capabilities = ["update"]
}
