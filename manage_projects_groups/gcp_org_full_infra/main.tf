provider "google" {
  project = var.bootstrap_project
}

terraform {
  backend "gcs" {
    bucket  = "my-terraform-state-bucket"
    prefix  = "gcp/org"
  }
}

resource "google_folder" "folders" {
  for_each     = { for folder in var.folders : folder.display_name => folder }
  display_name = each.value.display_name
  parent       = each.value.parent
  labels       = lookup(each.value, "labels", {})
}

resource "google_project" "projects" {
  for_each   = { for project in var.projects : project.project_id => project }
  name       = each.value.name
  project_id = each.value.project_id
  folder_id  = can(regex("folders/.+", each.value.parent)) ? each.value.parent : null
  labels     = lookup(each.value, "labels", {})
  depends_on = [google_folder.folders]
}

resource "google_project_billing_info" "billing" {
  for_each         = google_project.projects
  project          = each.value.project_id
  billing_account  = var.billing_account_id
}

resource "google_project_iam_member" "iam_members" {
  for_each = {
    for iam in var.iam_bindings : "${iam.project_id}-${iam.role}-${iam.member}" => iam
  }
  project = each.value.project_id
  role    = each.value.role
  member  = each.value.member
}

resource "google_service_account" "service_accounts" {
  for_each     = { for sa in var.service_accounts : "${sa.project_id}-${sa.account_id}" => sa }
  account_id   = each.value.account_id
  display_name = each.value.display_name
  project      = each.value.project_id
}

resource "google_cloud_identity_group" "groups" {
  for_each = { for g in var.iam_groups : g.display_name => g }
  display_name = each.value.display_name
  parent       = "customers/${var.customer_id}"
  group_key {
    id = each.value.email
  }
}