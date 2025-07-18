

provider "google" {
  project = var.project_id
}

resource "google_bigquery_dataset" "datasets" {
  for_each = { for ds in var.datasets : ds.dataset_id => ds }

  dataset_id  = each.value.dataset_id
  location    = each.value.location
  description = lookup(each.value, "description", null)
  labels      = lookup(each.value, "labels", {})
}

