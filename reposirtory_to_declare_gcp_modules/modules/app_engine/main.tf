// Terraform resources for this service


resource "google_app_engine_application" "app" {
  for_each = { for s in var.app_engine_services : s.project => s.project }

  project     = each.key
  location_id = "us-central"  # Set your region
}

resource "google_app_engine_version" "versions" {
  for_each = { for s in var.app_engine_services : "${s.project}-${s.service_name}" => s }

  project      = each.value.project
  service      = each.value.service_name
  runtime      = each.value.runtime

  entrypoint {
    shell = each.value.entrypoint
  }

  env_variables = each.value.env_variables
}
