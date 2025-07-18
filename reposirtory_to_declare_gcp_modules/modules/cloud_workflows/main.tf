// Terraform resources for this service
resource "google_workflows_workflow" "workflows" {
  for_each = { for wf in var.workflows : wf.name => wf }

  name        = each.value.name
  description = each.value.description
  region      = each.value.region

  source_contents = each.value.source
}
