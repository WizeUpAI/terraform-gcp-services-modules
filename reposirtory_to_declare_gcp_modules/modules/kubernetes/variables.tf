// Input variables for this service
variable "k8s_deployments" {
  description = "List of Kubernetes deployments to create"
  type = list(object({
    name      = string
    namespace = string
    replicas  = number
    labels    = map(string)
    container = object({
      name  = string
      image = string
      ports = list(number)
    })
  }))
}
