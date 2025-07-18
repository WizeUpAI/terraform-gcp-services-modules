// Input variables for this service
variable "project_id" {
  type = string
}

variable "region" {
  type    = string
  default = "us-central1"
}

variable "queues" {
  type = list(object({
    name              = string
    type              = string             # "push" or "pull"
    max_attempts      = optional(number)
    max_dispatches_per_second = optional(number)
    max_burst_size    = optional(number)
    retry_interval    = optional(string)
    push_endpoint     = optional(string)   # for push queue
  }))
}
