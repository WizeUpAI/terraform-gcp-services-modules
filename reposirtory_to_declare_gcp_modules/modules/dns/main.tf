// Terraform resources for this service
resource "google_dns_record_set" "records" {
  for_each = { for rec in var.dns_records : "${rec.managed_zone}_${rec.name}_${rec.type}" => rec }

  name         = each.value.name
  type         = each.value.type
  ttl          = each.value.ttl
  rrdatas      = each.value.rrdatas
  managed_zone = each.value.managed_zone
}