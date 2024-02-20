######## Secrets & Permissions configuration

resource "google_secret_manager_secret" "private-key-secret" {
  secret_id = var.bb-pk-secret

  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "private-key-secret-version" {
  secret = google_secret_manager_secret.private-key-secret.id
  secret_data = file(var.private_key_file)
}

resource "google_secret_manager_secret" "webhook-secret-secret" {
  secret_id = var.bitbucket-token-secret

  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "webhook-secret-secret-version" {
  secret = google_secret_manager_secret.webhook-secret-secret.id
  secret_data = var.webhook-secret-data
}

data "google_project_service_identity" "cloud_build" {
  project = var.project_id
  service = "cloudbuild.googleapis.com"
}

data "google_iam_policy" "p4sa-secretAccessor" {
  binding {
    role = "roles/secretmanager.secretAccessor"
    members = ["serviceAccount:${data.google_project_service_identity.cloud_build.email}"]
  }
}

resource "google_secret_manager_secret_iam_policy" "policy-pk" {
  secret_id = google_secret_manager_secret.private-key-secret.secret_id
  policy_data = data.google_iam_policy.p4sa-secretAccessor.policy_data
}

resource "google_secret_manager_secret_iam_policy" "policy-whs" {
  secret_id = google_secret_manager_secret.webhook-secret-secret.secret_id
  policy_data = data.google_iam_policy.p4sa-secretAccessor.policy_data
}

########## Connection configuration ##########

resource "google_cloudbuildv2_connection" "my-connection" {
  location = "global"
  name = var.linked_repo_name


}

########## Repository link ##################

resource "google_cloudbuildv2_repository" "my-repository" {
  location = var.location
  name = var.linked_repo_name
  parent_connection = var.connection_name
  remote_uri = var.linked_repo_uri
}