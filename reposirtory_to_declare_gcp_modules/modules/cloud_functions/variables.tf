// Input variables for this service
variable "project_id" {
  type = string
}

variable "region" {
  type    = string
  default = "us-central1"
}

variable "cloud_functions" {
  type = list(object({
    name           = string
    source_dir     = string
    entry_point    = string
    runtime        = string
    trigger_http   = optional(bool, false)
    trigger_bucket = optional(string)
    available_memory_mb = optional(number, 256)
  }))
}
