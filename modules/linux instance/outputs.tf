output "ipv4-addresses" {
  value = [for instance in google_compute_instance.default : instance.network_interface[0].network_ip]
}
