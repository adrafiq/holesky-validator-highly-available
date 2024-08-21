resource "google_service_account" "sa" {
  for_each     = var.service_accounts
  account_id   = each.key
  display_name = each.value.display_name
  description  = each.value.description
}

resource "google_project_iam_member" "sa_roles" {
  for_each = {
    for sa_role in flatten([
      for sa_name, sa in var.service_accounts : [
        for role in sa.roles : {
          sa_name = sa_name
          role    = role
        }
      ]
    ]) : "${sa_role.sa_name}-${sa_role.role}" => sa_role
  }

  project = var.project_id
  role    = each.value.role
  member  = "serviceAccount:${google_service_account.sa[each.value.sa_name].email}"
}