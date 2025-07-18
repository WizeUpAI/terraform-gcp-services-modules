// Input variables for this service
variable "project_id" {
  type = string
}

variable "cloud_run_services" {
  type = list(object({
    name                  = string
    image                 = string
    region                = string
    cpu                   = optional(number, 1)
    memory                = optional(string, "512Mi")
    env_vars              = optional(map(string), {})
    allow_unauthenticated = optional(bool, false)
  }))
}
