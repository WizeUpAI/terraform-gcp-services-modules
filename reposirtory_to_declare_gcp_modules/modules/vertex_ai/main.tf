// Terraform resources for this service
resource "google_vertex_ai_endpoint" "endpoints" {
  for_each = { for ep in var.vertex_ai_endpoints : ep.name => ep }

  name        = each.value.name
  project     = each.value.project
  location    = each.value.location
  description = lookup(each.value, "description", null)
  labels      = lookup(each.value, "labels", {})
}
