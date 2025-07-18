// Input variables for this service
variable "pubsub_topics" {
  description = "List of Pub/Sub topics with optional subscriptions"
  type = list(object({
    name          = string
    project       = string
    labels        = optional(map(string), {})
    message_storage_policy = optional(object({
      allowed_persistence_regions = list(string)
    }), null)
    subscriptions = optional(list(object({
      name               = string
      ack_deadline_seconds = optional(number, 10)
      retain_acked_messages = optional(bool, false)
      message_retention_duration = optional(string)
      labels             = optional(map(string), {})
    })), [])
  }))
}
