variable "service_accounts" {
  description = "Map of service accounts to create"
  type = map(object({
    display_name = string
    description  = string
    roles        = list(string)
  }))
}

variable "project_id" {
  description = "The GCP project ID"
  type        = string
}
