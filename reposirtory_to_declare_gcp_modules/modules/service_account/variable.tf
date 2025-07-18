variable "service_accounts" {
  description = "List of service accounts to create with roles"
  type = list(object({
    name        = string          # service account ID (without domain)
    project     = string
    display_name = optional(string)
    roles       = list(string)    # list of IAM roles to assign
  }))
}
