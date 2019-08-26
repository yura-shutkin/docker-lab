agent_prefix "" {
  policy = "read"
}

agent "consul-agent" {
  policy = "write"
}

service_prefix "" {
  policy = "write"
}

node_prefix "" {
  policy = "write"
}
