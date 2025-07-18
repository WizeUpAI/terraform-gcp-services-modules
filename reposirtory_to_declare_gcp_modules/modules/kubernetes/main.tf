// Terraform resources for this service
resource "kubernetes_deployment" "deployments" {
  for_each = { for d in var.k8s_deployments : d.name => d }

  metadata {
    name      = each.value.name
    namespace = each.value.namespace
    labels    = each.value.labels
  }

  spec {
    replicas = each.value.replicas

    selector {
      match_labels = each.value.labels
    }

    template {
      metadata {
        labels = each.value.labels
      }

      spec {
        container {
          name  = each.value.container.name
          image = each.value.container.image

          dynamic "port" {
            for_each = each.value.container.ports
            content {
              container_port = port.value
            }
          }
        }
      }
    }
  }
}
