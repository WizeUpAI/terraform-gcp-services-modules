// Terraform resources for this service
provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_storage_bucket" "function_buckets" {
  for_each = {
    for fn in var.cloud_functions :
    fn.name => fn if fn.trigger_bucket != null
  }

  name     = "${each.value.name}-trigger-bucket"
  location = var.region
}

resource "google_cloudfunctions_function" "functions" {
  for_each = { for fn in var.cloud_functions : fn.name => fn }

  name        = each.value.name
  description = "Function ${each.value.name}"
  runtime     = each.value.runtime
  entry_point = each.value.entry_point
  region      = var.region
  available_memory_mb = each.value.available_memory_mb

  source_directory = each.value.source_dir

  dynamic "event_trigger" {
    for_each = each.value.trigger_bucket != null ? [1] : []
    content {
      event_type = "google.storage.object.finalize"
      resource   = google_storage_bucket.function_buckets[each.key].name
    }
  }

  dynamic "https_trigger" {
    for_each = each.value.trigger_http ? [1] : []
    content {}
  }
}
