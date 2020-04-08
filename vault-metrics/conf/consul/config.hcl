log_level = "INFO"
enable_syslog = false
enable_debug = false
node_name = "consul-1"
data_dir = "/consul/data"
datacenter = "test-cluster"

server = true
ui = true

ports = {
  http = 8500
}
addresses = {
  http = "0.0.0.0"
}

bind_addr = "192.168.10.2"
bootstrap_expect = 1
leave_on_terminate = true
skip_leave_on_interrupt = true
rejoin_after_leave = true
