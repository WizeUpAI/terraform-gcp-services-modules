// Terraform resources for this service
resource "google_iap_web_backend_service_iam_binding" "bindings" {
  for_each = { for b in var.iap_bindings : "${b.project}_${b.backend_service}_${b.role}" => b }

  project         = each.value.project
  backend_service = each.value.backend_service
  role            = each.value.role
  members         = each.value.members
}
