// Input variables for this service
variable "gcs_buckets" {
  description = "List of GCS buckets to create"
  type = list(object({
    name                        = string
    location                    = string
    storage_class               = string
    force_destroy               = optional(bool, false)
    uniform_bucket_level_access = optional(bool, true)
    versioning_enabled          = optional(bool, false)
    lifecycle_rule = optional(list(object({
      action = object({
        type          = string
        storage_class = optional(string)
      })
      condition = object({
        age             = optional(number)
        created_before  = optional(string)
        with_state      = optional(string)
        num_newer_versions = optional(number)
      })
    })), [])
  }))
}
