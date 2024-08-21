# modules/network/outputs.tf

output "vpc_id" {
  description = "The ID of the VPC"
  value       = google_compute_network.vpc.id
}

output "vpc_name" {
  description = "The name of the VPC"
  value       = google_compute_network.vpc.name
}

output "vpc_self_link" {
  description = "The URI of the VPC"
  value       = google_compute_network.vpc.self_link
}

output "subnet_id" {
  description = "The ID of the private subnet"
  value       = google_compute_subnetwork.private_subnet.id
}

output "subnet_name" {
  description = "The name of the private subnet"
  value       = google_compute_subnetwork.private_subnet.name
}

output "subnet_self_link" {
  description = "The URI of the private subnet"
  value       = google_compute_subnetwork.private_subnet.self_link
}

output "subnet_cidr" {
  description = "The cidr range of the private subnet"
  value       = google_compute_subnetwork.private_subnet.ip_cidr_range
}


output "router_name" {
  description = "The name of the router"
  value       = google_compute_router.router.name
}

output "nat_name" {
  description = "The name of the NAT"
  value       = google_compute_router_nat.nat.name
}