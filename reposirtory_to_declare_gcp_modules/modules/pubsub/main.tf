// Terraform resources for this service
resource "google_pubsub_topic" "topics" {
  for_each = { for t in var.pubsub_topics : t.name => t }

  name    = each.value.name
  project = each.value.project
  labels  = each.value.labels

  dynamic "message_storage_policy" {
    for_each = each.value.message_storage_policy == null ? [] : [each.value.message_storage_policy]
    content {
      allowed_persistence_regions = message_storage_policy.value.allowed_persistence_regions
    }
  }
}

resource "google_pubsub_subscription" "subscriptions" {
  for_each = {
    for t in var.pubsub_topics : 
    t.subscriptions != null ? 
      { for s in t.subscriptions : "${t.name}_${s.name}" => {
          topic = t.name
          subscription = s
          project = t.project
        }
      } : {}
  } |> merge(...)

  name  = each.value.subscription.name
  project = each.value.project
  topic = google_pubsub_topic.topics[each.value.topic].name

  ack_deadline_seconds     = lookup(each.value.subscription, "ack_deadline_seconds", 10)
  retain_acked_messages    = lookup(each.value.subscription, "retain_acked_messages", false)
  message_retention_duration = lookup(each.value.subscription, "message_retention_duration", null)
  labels = lookup(each.value.subscription, "labels", {})
}
