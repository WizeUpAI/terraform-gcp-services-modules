// Input variables for this service
variable "app_engine_services" {
  description = "List of App Engine services to create"
  type = list(object({
    service_name = string
    project      = string
    runtime      = string
    env_variables = optional(map(string), {})
    entrypoint  = optional(string, null)
  }))
}