storage "consul" {
  address = "127.0.0.1:8500"
  path = "vault/"
  scheme = "http"
  token = "d565f7b1-a1ac-f91a-eaa5-820ca3f03124"
  service_tags = "vault-dev"
  service_address = "vault-client-2"
}

listener "tcp" {
  address     = "192.168.4.7:8200"
  tls_disable = "true"
  cluster_address = "192.168.4.7:8201"
  proxy_protocol_behavior = "allow_authorized"
  proxy_protocol_authorized_addrs = "192.168.4.5"
  x_forwarded_for_authorized_addrs = "192.168.4.5/32"
  x_forwarded_for_reject_not_authorized = "true"
  x_forwarded_for_reject_not_present = "true"
}

listener "tcp" {
  address     = "127.0.0.1:8200"
  tls_disable = "true"
}

telemetry {
  statsite_address = "statsd-exporter:9125"
  disable_hostname = true
}

ui = "true"

api_addr = "http://vault-client-2:8200"
cluster_addr = "https://vault-client-2:8201"
