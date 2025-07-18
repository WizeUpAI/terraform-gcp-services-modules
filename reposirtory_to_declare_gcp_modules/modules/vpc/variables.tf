// Input variables for this service
variable "vpcs" {
  description = "List of VPC networks to create"
  type = list(object({
    name                  = string
    project               = string
    auto_create_subnetworks = optional(bool, false)
    description           = optional(string, null)
    routing_mode          = optional(string, "GLOBAL")  # or "REGIONAL"
  }))
}
