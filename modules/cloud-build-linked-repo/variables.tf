
variable "bb-pk-secret" {
  description = "Secret ID for the private key"
  type        = string
}

variable "private_key_file" {
  description = "File containing the private key"
  type        = string
}

variable "bitbucket-token-secret" {
  description = "Secret ID for the Bitbucket token"
  type        = string
}

variable "webhook-secret-data" {
  description = "Data for the webhook secret"
  type        = string
}

variable "project_id" {
  description = "Google Cloud project ID"
  type        = string
}

variable "linked_repo_name" {
  description = "Name of the linked repository"
  type        = string
}

variable "location" {
  description = "Location for the resources"
  type        = string
}

variable "connection_name" {
  description = "Name of the connection"
  type        = string
}

variable "linked_repo_uri" {
  description = "URI of the linked repository"
  type        = string
}
