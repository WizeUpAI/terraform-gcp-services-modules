// Input variables for this service
variable "vertex_ai_endpoints" {
  description = "List of Vertex AI endpoints to create"
  type = list(object({
    name        = string
    project     = string
    location    = string
    description = optional(string)
    labels      = optional(map(string), {})
  }))
}
