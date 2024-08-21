# modules/network/main.tf

locals {
  vpc_name = "${var.project_id}-${var.environment}-vpc"
}

resource "google_compute_network" "vpc" {
  name                    = local.vpc_name
  auto_create_subnetworks = false

}

resource "google_compute_subnetwork" "private_subnet" {
  name          = "${local.vpc_name}-private-subnet"
  ip_cidr_range = var.subnet_cidr
  region        = var.region
  network       = google_compute_network.vpc.self_link

  private_ip_google_access = true

  dynamic "log_config" {
    for_each = var.subnet_flow_logs ? [{
      aggregation_interval = "INTERVAL_5_SEC"
      flow_sampling        = 0.5
      metadata             = "INCLUDE_ALL_METADATA"
    }] : []
    content {
      aggregation_interval = log_config.value["aggregation_interval"]
      flow_sampling        = log_config.value["flow_sampling"]
      metadata             = log_config.value["metadata"]
    }
  }
}

resource "google_compute_router" "router" {
  name    = "${local.vpc_name}-router"
  region  = var.region
  network = google_compute_network.vpc.self_link
}

resource "google_compute_router_nat" "nat" {
  name                               = "${local.vpc_name}-nat"
  router                             = google_compute_router.router.name
  region                             = var.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}

resource "google_compute_firewall" "allow_http_https" {
  name    = "${local.vpc_name}-allow-http-https"
  network = google_compute_network.vpc.self_link

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["load-balancer"]
}