// Input variables for this service
variable "project_id" {
  type = string
}

variable "dataset_id" {
  type = string
}

variable "location" {
  type    = string
  default = "US"
}

variable "tables" {
  type = list(object({
    table_id = string
    schema   = string  # path to schema file
  }))
}
