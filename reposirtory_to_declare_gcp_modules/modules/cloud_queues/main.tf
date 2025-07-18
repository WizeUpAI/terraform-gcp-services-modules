// Terraform resources for this service
provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_cloud_tasks_queue" "queues" {
  for_each = { for q in var.queues : q.name => q }

  name     = each.value.name
  location = var.region

  retry_config {
    max_attempts = lookup(each.value, "max_attempts", 5)
  }

  rate_limits {
    max_dispatches_per_second = lookup(each.value, "max_dispatches_per_second", 10)
    max_burst_size            = lookup(each.value, "max_burst_size", 5)
  }

  dynamic "stackdriver_logging_config" {
    for_each = each.value.type == "push" ? [1] : []
    content {
      sampling_ratio = 1.0
    }
  }

  dynamic "app_engine_routing_override" {
    for_each = each.value.type == "push" && contains(each.value.push_endpoint, "appspot.com") ? [1] : []
    content {
      service  = "default"
    }
  }

  dynamic "http_target" {
    for_each = each.value.type == "push" && can(each.value.push_endpoint) ? [1] : []
    content {
      uri_override {
        uri = each.value.push_endpoint
      }
      http_method = "POST"
    }
  }

  # Pull queue requires no targets
}
