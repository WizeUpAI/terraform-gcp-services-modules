resource "google_service_account" "accounts" {
  for_each = { for sa in var.service_accounts : sa.name => sa }

  account_id   = each.value.name
  project      = each.value.project
  display_name = lookup(each.value, "display_name", null)
}

resource "google_project_iam_member" "service_account_bindings" {
  for_each = {
    for sa in var.service_accounts :
    "${sa.project}-${sa.name}" => {
      project = sa.project
      sa_email = "${sa.name}@${sa.project}.iam.gserviceaccount.com"
      roles = sa.roles
    }
  }

  project = each.value.project
  role    = each.value.roles[0]   # assign first role only, see note below
  member  = "serviceAccount:${each.value.sa_email}"
}

resource "google_project_iam_member" "service_account_bindings" {
  for_each = {
    for sa in var.service_accounts : 
    # create one entry per role per service account
    for role in sa.roles : 
    "${sa.project}-${sa.name}-${replace(role, "roles/", "")}" => {
      project = sa.project
      sa_email = "${sa.name}@${sa.project}.iam.gserviceaccount.com"
      role = role
    }
  }

  project = each.value.project
  role    = each.value.role
  member  = "serviceAccount:${each.value.sa_email}"
}
