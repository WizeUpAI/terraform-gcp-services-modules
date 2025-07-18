// Terraform resources for this service
resource "google_composer_environment" "environments" {
  for_each = { for env in var.composer_environments : env.name => env }

  provider = google-beta

  name     = each.value.name
  project  = each.value.project
  location = each.value.location

  config {
    node_count   = each.value.node_count
    software_config {
      image_version          = each.value.airflow_version
      env_variables          = each.value.environment_variables
    }
    node_config {
      machine_type = each.value.machine_type
      disk_size_gb = each.value.disk_size_gb
    }

    dynamic "web_server_network_access_control" {
      for_each = each.value.web_server_network_access_control == null ? [] : [each.value.web_server_network_access_control]
      content {
        dynamic "allowed_ip_range" {
          for_each = web_server_network_access_control.value.allowed_ip_ranges
          content {
            value       = allowed_ip_range.value.value
            description = lookup(allowed_ip_range.value, "description", null)
          }
        }
      }
    }
  }

  labels = each.value.labels
}
