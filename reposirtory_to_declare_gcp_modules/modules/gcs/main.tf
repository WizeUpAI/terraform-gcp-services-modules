// Terraform resources for this service
resource "google_storage_bucket" "buckets" {
  for_each = { for b in var.gcs_buckets : b.name => b }

  name     = each.value.name
  location = each.value.location
  storage_class = each.value.storage_class
  force_destroy = lookup(each.value, "force_destroy", false)

  uniform_bucket_level_access = lookup(each.value, "uniform_bucket_level_access", true)

  versioning {
    enabled = lookup(each.value, "versioning_enabled", false)
  }

  dynamic "lifecycle_rule" {
    for_each = lookup(each.value, "lifecycle_rule", [])
    content {
      action {
        type          = lifecycle_rule.value.action.type
        storage_class = lookup(lifecycle_rule.value.action, "storage_class", null)
      }
      condition {
        age                = lookup(lifecycle_rule.value.condition, "age", null)
        created_before     = lookup(lifecycle_rule.value.condition, "created_before", null)
        with_state         = lookup(lifecycle_rule.value.condition, "with_state", null)
        num_newer_versions = lookup(lifecycle_rule.value.condition, "num_newer_versions", null)
      }
    }
  }
}
