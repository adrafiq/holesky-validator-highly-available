# environments/dev/backend.tf
terraform {
  backend "gcs" {
    bucket  = "ha-validator-cluster"
    prefix  = "terraform/state"
  }
}

