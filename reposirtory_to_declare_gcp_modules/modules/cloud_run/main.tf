// Terraform resources for this service
provider "google" {
  project = var.project_id
}

resource "google_cloud_run_v2_service" "services" {
  for_each = {
    for svc in var.cloud_run_services :
    "${svc.name}-${svc.region}" => svc
  }

  name     = each.value.name
  location = each.value.region
  ingress  = "INGRESS_TRAFFIC_ALL"

  template {
    containers {
      image = each.value.image
      resources {
        limits = {
          cpu    = "${each.value.cpu}"
          memory = each.value.memory
        }
      }

      env = [
        for k, v in each.value.env_vars :
        {
          name  = k
          value = v
        }
      ]
    }

    scaling {
      min_instance_count = 0
      max_instance_count = 5
    }
  }

  lifecycle {
    ignore_changes = [template[0].revision]
  }
}

resource "google_cloud_run_service_iam_member" "public_access" {
  for_each = {
    for svc in var.cloud_run_services :
    "${svc.name}-${svc.region}" => svc
    if svc.allow_unauthenticated
  }

  location = each.value.region
  project  = var.project_id
  service  = google_cloud_run_v2_service.services[each.key].name

  role   = "roles/run.invoker"
  member = "allUsers"
}
