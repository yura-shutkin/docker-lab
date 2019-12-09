auto_auth {
  method {
    type      = "approle"

    config = {
      role_id_file_path = "/vault/data/role_id"
      secret_id_file_path = "/vault/data/secret_id"
      remove_secret_id_file_after_reading = false
    }
  }

  sink {
    type = "file"

    config = {
      path = "/vault/data/token"
    }
  }
}

listener "tcp" {
  address = "0.0.0.0:8200"
  tls_disable = true
}

vault {
  address = "http://vault-server:8200"
}
