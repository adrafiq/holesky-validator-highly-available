output "enabled_apis" {
  description = "List of APIs that were enabled"
  value       = [for api in google_project_service.gcp_services : api.service]
}