// Terraform resources for this service
# Flatten backend services for easier for_each management
locals {
  backend_services_flat = flatten([
    for lb in var.load_balancers : [
      for bs in lb.backend_services : merge(bs, { lb_name = lb.name, project = lb.project })
    ]
  ])

  forwarding_rules_flat = flatten([
    for lb in var.load_balancers : [
      for fr in lb.forwarding_rules : merge(fr, { lb_name = lb.name, project = lb.project })
    ]
  ])
}

resource "google_compute_backend_service" "backend_services" {
  for_each = { for bs in local.backend_services_flat : "${bs.lb_name}_${bs.name}" => bs }

  name            = each.value.name
  project         = each.value.project
  protocol        = each.value.protocol
  health_checks   = each.value.health_checks

  dynamic "backend" {
    for_each = each.value.backends
    content {
      group = backend.value.group
    }
  }
}

resource "google_compute_target_http_proxy" "http_proxies" {
  for_each = { for lb in var.load_balancers : lb.name => lb }

  name    = "${each.value.name}-http-proxy"
  project = each.value.project

  url_map = google_compute_url_map.url_maps[each.value.name].self_link
}

resource "google_compute_url_map" "url_maps" {
  for_each = { for lb in var.load_balancers : lb.name => lb }

  name    = "${each.value.name}-url-map"
  project = each.value.project

  default_service = google_compute_backend_service.backend_services["${each.value.name}_${each.value.backend_services[0].name}"].self_link
}

resource "google_compute_global_forwarding_rule" "forwarding_rules" {
  for_each = { for fr in local.forwarding_rules_flat : fr.name => fr }

  name                = each.value.name
  project             = each.value.project
  ip_address          = each.value.ip_address
  ip_protocol         = each.value.ip_protocol
  port_range          = each.value.port_range
  target              = google_compute_target_http_proxy.http_proxies[each.value.lb_name].self_link
  load_balancing_scheme = lookup(each.value, "load_balancing_scheme", "EXTERNAL")
}
