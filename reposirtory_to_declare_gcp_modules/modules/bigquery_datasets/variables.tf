variable "project_id" {
  type = string
}

variable "datasets" {
  type = list(object({
    dataset_id  = string
    location    = string
    description = optional(string)
    labels      = optional(map(string))
  }))
}