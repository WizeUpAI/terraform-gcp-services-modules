provider "google" {
  project = var.project_id
}

resource "google_bigquery_data_transfer_config" "scheduled_queries" {
  for_each = { for sq in var.scheduled_queries : sq.display_name => sq }

  display_name  = each.value.display_name
  data_source_id = "scheduled_query"
  project        = var.project_id
  location       = var.location

  schedule = each.value.schedule

  schedule_options {
    start_time = each.value.start_time
  }

  params = {
    query                            = file(each.value.query_file)
    destination_table_name_template = each.value.destination_table
    write_disposition               = "WRITE_TRUNCATE"
  }
}
