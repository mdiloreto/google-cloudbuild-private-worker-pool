terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "~>5.0.0"
    }
  }
    backend "gcs" {
        bucket  = "mc-terraform-tfstate2"
        prefix  = "terraform/state"
        
    }
}