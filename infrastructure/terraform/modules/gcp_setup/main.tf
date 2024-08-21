resource "google_project_service" "gcp_services" {
  for_each = toset(var.apis_to_enable)
  project  = var.project_id
  service  = each.key

  disable_on_destroy = false
}