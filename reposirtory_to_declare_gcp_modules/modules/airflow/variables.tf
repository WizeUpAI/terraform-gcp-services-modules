// Input variables for this service
variable "composer_environments" {
  description = "List of Cloud Composer environments to create"
  type = list(object({
    name                  = string
    project               = string
    location              = string
    node_count            = optional(number, 3)
    machine_type          = optional(string, "n1-standard-1")
    disk_size_gb          = optional(number, 20)
    airflow_version       = optional(string, "composer-2.0.30-airflow-2.2.3")
    web_server_network_access_control = optional(object({
      allowed_ip_ranges = optional(list(object({
        value       = string
        description = optional(string)
      })), [])
    }), null)
    labels                = optional(map(string), {})
    environment_variables = optional(map(string), {})
  }))
}
