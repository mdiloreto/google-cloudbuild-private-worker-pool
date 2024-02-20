######## Secrets & Permissions configuration

resource "google_secret_manager_secret" "private-key-secret" {
  secret_id = var.secret-name

  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "private-key-secret-version" {
  secret = google_secret_manager_secret.private-key-secret.id
  secret_data = file(var.private_key_file)
}