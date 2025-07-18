// Input variables for this service
variable "workflows" {
  description = "List of workflows to create"
  type = list(object({
    name        = string
    description = string
    region      = string
    source      = string  # The YAML or JSON workflow definition as a string
  }))
}
