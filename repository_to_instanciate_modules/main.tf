module "vpc" {
  source  = "git::https://gitlab.com/yourgroup/terraform-gcp-services-modules.git//modules/vpc?ref=main"
  project_id = local.project_id
  region     = local.region
}

module "cloud_run" {
  source  = "git::https://gitlab.com/yourgroup/terraform-gcp-services-modules.git//modules/cloud_run?ref=main"
  project_id = local.project_id
  region     = local.region
}

module "airflow" {
  source  = "git::https://gitlab.com/yourgroup/terraform-gcp-services-modules.git//modules/airflow?ref=main"
  project_id = local.project_id
  region     = local.region
}