resource "google_container_cluster" "primary" {
  name     = "${var.environment}-gke-cluster"
  location = var.region
  deletion_protection = false ## TODO Remove this
  remove_default_node_pool = true
  initial_node_count       = 1

  network    = var.network
  subnetwork = var.subnetwork

  # Enable Workload Identity
  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }

  # Enable network policy (Calico)
  network_policy {
    enabled = true
    provider = "CALICO"
  }

  # Enable private cluster
  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = false
    master_ipv4_cidr_block  = var.master_ipv4_cidr_block
  }

  # Configure master authorized networks
  master_authorized_networks_config { ## TODO, Fix
    cidr_blocks {
      cidr_block   = var.authorized_ipv4_cidr_block
      display_name = "Authorized Network"
    }
  }

  # Enable shielded nodes
  enable_shielded_nodes = true

  # Network policy
  addons_config {
    network_policy_config {
      disabled = false
    }
  }

  # Enable Binary Authorization 
  # Note: Requires Binary Authorization API, Good Practice. Skipping
  # binary_authorization {
    # evaluation_mode = "PROJECT_SINGLETON_POLICY_ENFORCE"
  # }

  # Add labels
  resource_labels = merge(var.labels, {
    environment = var.environment
    managed-by  = "terraform"
  })
}

resource "google_container_node_pool" "node_pools" {
  for_each = { for np in var.node_pools : np.name => np }

  name       = each.value.name
  location   = var.region
  cluster    = google_container_cluster.primary.name
  
  node_locations = each.value.node_locations

  node_count = each.value.node_count

  node_config {
    machine_type = each.value.machine_type
    image_type   = each.value.image_type

    disk_size_gb = each.value.disk_size_gb
    disk_type    = each.value.disk_type

    local_ssd_count = each.value.local_ssd_count

    labels = merge(var.labels, each.value.labels)

    dynamic "taint" {
      for_each = each.value.taints
      content {
        key    = taint.value.key
        value  = taint.value.value
        effect = taint.value.effect
      }
    }

    service_account = var.node_sa_email
    oauth_scopes    = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]

    workload_metadata_config {
      mode = "GKE_METADATA"
    }

    shielded_instance_config {
      enable_secure_boot = true
    }
  }

  management {
    auto_repair  = each.value.auto_repair
    auto_upgrade = each.value.auto_upgrade
  }

  autoscaling {
    min_node_count = each.value.min_node_count
    max_node_count = each.value.max_node_count
  }
}
