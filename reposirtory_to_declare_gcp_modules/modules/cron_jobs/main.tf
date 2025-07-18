// Terraform resources for this service
resource "google_cloud_scheduler_job" "cron_jobs" {
  for_each = { for job in var.cron_jobs : job.name => job }

  name        = each.value.name
  description = each.value.description
  schedule    = each.value.schedule
  time_zone   = each.value.time_zone

  http_target {
    uri          = each.value.http_target.uri
    http_method  = each.value.http_target.http_method

    dynamic "headers" {
      for_each = lookup(each.value.http_target, "headers", {})
      content {
        key   = headers.key
        value = headers.value
      }
    }

    body = lookup(each.value.http_target, "body", null) != null ? base64encode(each.value.http_target.body) : null
  }
}
