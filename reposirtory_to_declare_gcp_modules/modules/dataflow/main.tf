// Terraform resources for this service
resource "google_dataflow_job" "jobs" {
  for_each = { for job in var.dataflow_jobs : job.name => job }

  name       = each.value.name
  region     = each.value.region
  template_gcs_path = each.value.template_gcs_path

  parameters = each.value.parameters

  max_workers = lookup(each.value, "max_workers", 5)
  zone        = lookup(each.value, "zone", null)

  lifecycle {
    ignore_changes = [current_state]
  }
}
