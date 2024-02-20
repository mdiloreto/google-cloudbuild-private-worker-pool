output "private_key_secret_id" {
  value = google_secret_manager_secret.private-key-secret.id
  description = "The ID of the private key secret"
}
