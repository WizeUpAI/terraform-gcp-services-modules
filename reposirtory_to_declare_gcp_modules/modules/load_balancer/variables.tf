// Input variables for this service
variable "load_balancers" {
  description = "List of HTTP(S) load balancers to create"
  type = list(object({
    name                = string
    project             = string
    backend_services    = list(object({
      name             = string
      protocol         = string
      backends         = list(object({
        group          = string  # Instance group URL
      }))
      health_checks    = list(string)  # Health check URLs
    }))
    forwarding_rules    = list(object({
      name             = string
      ip_address        = string
      ip_protocol       = string
      port_range        = string
      target_proxy      = string  # Target proxy URL
      load_balancing_scheme = string
      network           = optional(string)
      subnetwork        = optional(string)
    }))
  }))
}
