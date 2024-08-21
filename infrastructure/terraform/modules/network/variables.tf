# modules/network/variables.tf

variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "The GCP region"
  type        = string
}

variable "environment" {
  description = "The environment (e.g., 'test', 'prod')"
  type        = string
}

variable "subnet_cidr" {
  description = "CIDR range for the private subnet"
  type        = string
  default     = "10.0.0.0/24"
}

variable "subnet_flow_logs" {
  description = "Whether to enable flow logs for the subnet"
  type        = bool
  default     = false
}

variable "labels" {
  description = "A map of labels to add to all resources"
  type        = map(string)
  default     = {}
}