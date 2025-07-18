// Input variables for this service
variable "dataproc_clusters" {
  description = "List of Dataproc clusters to create"
  type = list(object({
    name             = string
    region           = string
    zone             = optional(string)
    cluster_config = object({
      master_config = object({
        num_instances = number
        machine_type  = string
      })
      worker_config = object({
        num_instances = number
        machine_type  = string
      })
      software_config = optional(object({
        image_version = string
        optional_components = optional(list(string))
      }))
      initialization_actions = optional(list(object({
        executable_file = string
        timeout_sec     = optional(number)
      })))
    })
  }))
}
