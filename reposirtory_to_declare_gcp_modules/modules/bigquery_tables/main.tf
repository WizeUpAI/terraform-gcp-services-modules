// Terraform resources for this service
provider "google" {
  project = var.project_id
}

resource "google_bigquery_table" "tables" {
  for_each = { for t in var.tables : t.table_id => t }

  dataset_id = google_bigquery_dataset.dataset.dataset_id
  table_id   = each.value.table_id
  schema     = file(each.value.schema)
}
