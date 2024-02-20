resource "google_compute_firewall" "default" {
  name    = var.rule_name
  network = var.network_name

  allow {
    protocol = var.protocol
    ports    = var.ports
  }
  source_ranges = var.source_ranges
  destination_ranges = var.destination_ranges
  source_tags = var.source_tags
}