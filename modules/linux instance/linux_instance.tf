resource "google_compute_network" "vpc_network" {
  count = var.create_network ? 1:0
  name = var.network_name

  project = var.project
  auto_create_subnetworks = var.network_subnet_auto
}

resource "google_compute_subnetwork" "network-with-private-secondary-ip-ranges" {
  count           = var.subnet_create ? 1:0
  name          = "${var.subnet_name}-${count.index}"
  ip_cidr_range = var.ip_cidr_range[count.index]  # "10.1.0.0/24"
  region        = var.region
  network       = google_compute_network.vpc_network[count.index].name
}

resource "google_service_account" "default" {
  account_id   = var.sa_account_id
  display_name = var.sa_display_name
}

resource "google_compute_instance" "default" {
  count        = var.vm_count
  name         = var.vm_name
  machine_type = var.machine_size
  zone         = var.zone

  # tags = var.vm_tags[count.index]

  boot_disk {
    initialize_params {
      image = var.vm_image
    }
  }

    # metadata = {
    # "ssh-keys" = file(var.pub_key)
    # }

  // Local SSD disk
  scratch_disk {
    interface = var.scratch_disk_interface
  }

  network_interface {
    network = var.network_name
    subnetwork = var.subnet_name
    access_config {
      // Ephemeral public IP
    }
  }

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = google_service_account.default.email
    scopes = var.vm_sa_scopes
  }
}