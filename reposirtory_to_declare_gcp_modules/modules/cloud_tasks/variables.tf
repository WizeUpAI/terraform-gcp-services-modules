// Input variables for this service
variable "project_id" {
  type = string
}

variable "tasks" {
  type = list(object({
    name       = string
    queue      = string
    location   = string
    http_url   = optional(string)
    method     = optional(string, "POST")
    body       = optional(string)
    headers    = optional(map(string))
    pull       = optional(bool, false)
  }))
}
