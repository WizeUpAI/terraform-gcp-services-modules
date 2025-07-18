// Input variables for this service
variable "subnets" {
  description = "List of subnets to create"
  type = list(object({
    name          = string
    project       = string
    region        = string
    network       = string
    ip_cidr_range = string
    description   = optional(string, null)
    private_ip_google_access = optional(bool, false)
  }))
}
