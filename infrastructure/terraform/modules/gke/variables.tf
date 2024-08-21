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

variable "network" {
  description = "The VPC network"
  type        = string
}

variable "subnetwork" {
  description = "The subnetwork"
  type        = string
}

variable "master_ipv4_cidr_block" {
  description = "The IP range in CIDR notation to use for the hosted master network"
  type        = string
  default     = "192.168.1.0/28"
}

variable "authorized_ipv4_cidr_block" {
  description = "The IP range in CIDR notation to use for the authorized network"
  type        = string
}

variable "node_count" {
  description = "Number of nodes in the node pool"
  type        = number
  default     = 3
}

variable "min_node_count" {
  description = "Minimum number of nodes in the node pool"
  type        = number
  default     = 1
}

variable "max_node_count" {
  description = "Maximum number of nodes in the node pool"
  type        = number
  default     = 5
}

variable "machine_type" {
  description = "The machine type for the nodes"
  type        = string
  default     = "e2-medium"
}

variable "node_sa_email" {
  description = "The email of the service account for nodes"
  type        = string
}

variable "labels" {
  description = "A map of labels to add to all resources"
  type        = map(string)
  default     = {}
}

variable "node_pools" {
  description = "List of node pool configurations"
  type = list(object({
    name                = string
    machine_type        = string
    node_locations      = list(string)
    node_count          = number
    local_ssd_count     = number
    disk_size_gb        = number
    disk_type           = string
    image_type          = string
    auto_repair         = bool
    auto_upgrade        = bool
    preemptible         = bool
    initial_node_count  = number
    min_node_count      = number
    max_node_count      = number

    # Specify any additional node-specific options here
    labels              = map(string)
    taints = list(object({
      key    = string
      value  = string
      effect = string
    }))
  }))
}
