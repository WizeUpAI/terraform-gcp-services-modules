// Terraform resources for this service
resource "google_compute_network" "vpcs" {
  for_each = { for vpc in var.vpcs : vpc.name => vpc }

  name                    = each.value.name
  project                 = each.value.project
  auto_create_subnetworks = each.value.auto_create_subnetworks
  description             = each.value.description
  routing_mode            = each.value.routing_mode
}
