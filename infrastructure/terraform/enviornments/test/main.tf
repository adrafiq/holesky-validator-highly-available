# environments/dev/main.tf
provider "google" {
  project = var.project_id
  region  = var.region
  version = "5.38.0"
}

module "gcp_setup" {
  source     = "../../modules/gcp_setup"
  project_id = var.project_id
  region     = var.region
  environment = var.environment
  apis_to_enable = [
    "container.googleapis.com",
    "compute.googleapis.com",
    "iam.googleapis.com",
    "logging.googleapis.com",
    "monitoring.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "containerregistry.googleapis.com",
    "cloudbuild.googleapis.com",
    "artifactregistry.googleapis.com",
    "certificatemanager.googleapis.com",
    "dns.googleapis.com"
  ]
}

module "service_accounts" {
  source = "../../modules/iam/service_accounts"
  
  project_id = var.project_id
  service_accounts = {
    "gke-sa" = {
      display_name = "GKE Service Account"
      description  = "Service account for GKE"
      roles = [
        "roles/container.nodeServiceAccount",
        "roles/logging.logWriter",
        "roles/monitoring.metricWriter",
        "roles/monitoring.viewer",
        "roles/stackdriver.resourceMetadata.writer"
      ]
    },
    "workload-sa" = {
      display_name = "Workload Service Account"
      description  = "Service account for workloads"
      roles = [
        "roles/iam.workloadIdentityUser"
      ]
    }
  }
}

module "network" {
  source     = "../../modules/network"
  project_id = var.project_id
  region     = var.region
  environment = var.environment
  subnet_cidr = "172.16.0.0/20"
  subnet_flow_logs = true
  labels = {
    project = var.project_id
  }
}


module "gke" {
  source = "../../modules/gke"

  project_id     = var.project_id
  region         = var.region
  environment    = var.environment
  network        = module.network.vpc_name
  subnetwork     = module.network.subnet_name
  node_sa_email  = module.service_accounts.gke_sa_email

  authorized_ipv4_cidr_block = "0.0.0.0/0"  # Adjust this to your needs
    node_pools = [
    {
      name               = "validator-pool"
      machine_type       = "e2-standard-2"
      node_locations     = ["${var.region}-a", "${var.region}-b"]
      node_count         = 1
      local_ssd_count    = 1
      disk_size_gb       = 100
      disk_type          = "pd-ssd"
      image_type         = "COS_CONTAINERD"
      auto_repair        = true
      auto_upgrade       = true
      preemptible        = false
      initial_node_count = 1
      min_node_count     = 1
      max_node_count     = 3
      labels             = {
        role = "validator"
      }
      taints             = [
        {
          key    = "validator"
          value  = "true"
          effect = "NO_SCHEDULE"
        }
      ]
    },
    {
      name               = "general-pool"
      machine_type       = "e2-medium"
      node_locations     = ["${var.region}-a", "${var.region}-b"]
      node_count         = 0
      local_ssd_count    = 0
      disk_size_gb       = 100
      disk_type          = "pd-standard"
      image_type         = "COS_CONTAINERD"
      auto_repair        = true
      auto_upgrade       = true
      preemptible        = true
      initial_node_count = 0
      min_node_count     = 0
      max_node_count     = 1
      labels             = {
        role = "general"
      }
      taints             = []
    }
  ]
  labels = {
    project = var.project_id
    # Add any other labels you want to apply to all resources
  }
}
