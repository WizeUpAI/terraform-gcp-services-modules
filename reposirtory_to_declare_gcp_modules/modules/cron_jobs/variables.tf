// Input variables for this service
variable "cron_jobs" {
  description = "List of Cloud Scheduler jobs"
  type = list(object({
    name         = string
    description  = string
    schedule     = string  # cron expression
    time_zone    = string
    http_target  = object({
      uri        = string
      http_method= string
      body       = optional(string)
      headers    = optional(map(string))
    })
  }))
}
