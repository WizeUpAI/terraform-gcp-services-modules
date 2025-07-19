variable "bootstrap_project" {
  type = string
}

variable "billing_account_id" {
  type = string
}

variable "customer_id" {
  type = string
}

variable "folders" {
  type = list(object({
    display_name = string
    parent       = string
    labels       = optional(map(string))
  }))
}

variable "projects" {
  type = list(object({
    name       = string
    project_id = string
    parent     = string
    labels     = optional(map(string))
  }))
}

variable "iam_bindings" {
  type = list(object({
    project_id = string
    role       = string
    member     = string
  }))
}

variable "service_accounts" {
  type = list(object({
    project_id    = string
    account_id    = string
    display_name  = string
  }))
}

variable "iam_groups" {
  type = list(object({
    display_name = string
    email        = string
  }))
}