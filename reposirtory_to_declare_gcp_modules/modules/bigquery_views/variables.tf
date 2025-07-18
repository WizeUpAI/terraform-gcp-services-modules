// Input variables for this service
variable "project_id" {
  type = string
}

variable "views" {
  type = list(object({
    dataset_id = string
    view_id    = string
    query_file = string  # relative path to .sql
  }))
}
