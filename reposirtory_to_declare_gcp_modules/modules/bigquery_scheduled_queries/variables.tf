variable "project_id" {
  type = string
}

variable "location" {
  type    = string
  default = "US"
}

variable "scheduled_queries" {
  type = list(object({
    display_name      = string
    destination_table = string
    query_file        = string
    schedule          = string
    start_time        = string
  }))
}
