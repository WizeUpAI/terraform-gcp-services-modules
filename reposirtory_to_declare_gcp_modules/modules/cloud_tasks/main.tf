// Terraform resources for this service
provider "google" {
  project = var.project_id
}

resource "google_cloud_tasks_task" "tasks" {
  for_each = {
    for t in var.tasks : "${t.queue}/${t.name}" => t
  }

  name     = each.value.name
  location = each.value.location
  queue    = each.value.queue

  schedule_time = null  # run ASAP

  dynamic "http_request" {
    for_each = each.value.pull ? [] : [1]
    content {
      http_method = each.value.method
      url         = each.value.http_url
      body        = each.value.body != null ? base64encode(each.value.body) : null

      headers = each.value.headers != null ? each.value.headers : null
    }
  }

  dynamic "pull_message" {
    for_each = each.value.pull ? [1] : []
    content {
      payload = base64encode("custom-payload")
    }
  }
}
