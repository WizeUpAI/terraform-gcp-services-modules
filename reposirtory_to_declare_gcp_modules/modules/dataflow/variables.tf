// Input variables for this service
variable "dataflow_jobs" {
  description = "List of Dataflow jobs to run"
  type = list(object({
    name             = string
    region           = string
    template_gcs_path= string  # GCS path to Dataflow template
    parameters       = map(string)  # template parameters
    max_workers      = optional(number, 5)
    zone             = optional(string)
  }))
}
