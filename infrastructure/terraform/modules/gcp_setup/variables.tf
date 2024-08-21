# modules/gcp_setup/variables.tf
variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "The GCP region"
  type        = string
}

variable "environment" {
  description = "The environment (dev or prod)"
  type        = string
}

variable "apis_to_enable" {
  description = "List of APIs to enable in the project"
  type        = list(string)
  default     = [
    "container.googleapis.com",
    "compute.googleapis.com"
  ]
}