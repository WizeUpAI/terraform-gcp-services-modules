bootstrap_project = "my-bootstrap-project-id"
billing_account_id = "XXXXXX-XXXXXX-XXXXXX"
customer_id = "C0123456"

folders = [
  {
    display_name = "engineering"
    parent       = "organizations/123456789012"
  }
]

projects = [
  {
    name       = "Eng Dev"
    project_id = "eng-dev"
    parent     = "folders/engineering-id"
  }
]

iam_bindings = [
  {
    project_id = "eng-dev"
    role       = "roles/viewer"
    member     = "group:eng-team@example.com"
  }
]

service_accounts = [
  {
    project_id    = "eng-dev"
    account_id    = "eng-service"
    display_name  = "Engineering Service Account"
  }
]

iam_groups = [
  {
    display_name = "Engineering Team"
    email        = "eng-team@example.com"
  }
]