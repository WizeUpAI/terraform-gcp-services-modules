// Input variables for this service
variable "iap_bindings" {
  description = "List of IAP Web Backend Service IAM bindings"
  type = list(object({
    project        = string
    backend_service = string
    role           = string
    members        = list(string)
  }))
}
