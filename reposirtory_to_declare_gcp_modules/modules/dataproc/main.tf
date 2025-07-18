// Terraform resources for this service
resource "google_dataproc_cluster" "clusters" {
  for_each = { for c in var.dataproc_clusters : c.name => c }

  name   = each.value.name
  region = each.value.region
  zone   = lookup(each.value, "zone", null)

  cluster_config {
    master_config {
      num_instances = each.value.cluster_config.master_config.num_instances
      machine_type  = each.value.cluster_config.master_config.machine_type
    }

    worker_config {
      num_instances = each.value.cluster_config.worker_config.num_instances
      machine_type  = each.value.cluster_config.worker_config.machine_type
    }

    dynamic "software_config" {
      for_each = lookup(each.value.cluster_config, "software_config", []) != [] ? [each.value.cluster_config.software_config] : []
      content {
        image_version       = software_config.value.image_version
        optional_components = software_config.value.optional_components
      }
    }

    dynamic "initialization_action" {
      for_each = lookup(each.value.cluster_config, "initialization_actions", [])
      content {
        executable_file = initialization_action.value.executable_file
        timeout_sec     = lookup(initialization_action.value, "timeout_sec", null)
      }
    }
  }
}
