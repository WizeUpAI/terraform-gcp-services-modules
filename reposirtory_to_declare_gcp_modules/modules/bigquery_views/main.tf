// Terraform resources for this service
provider "google" {
  project = var.project_id
}

resource "google_bigquery_table" "views" {
  for_each = {
    for v in var.views : "${v.dataset_id}.${v.view_id}" => v
  }

  project    = var.project_id
  dataset_id = each.value.dataset_id
  table_id   = each.value.view_id
  
  view {             # query_file : "sql/user_view.sql"
    query          = file(each.value.query_file)
    use_legacy_sql = false
  }
}
