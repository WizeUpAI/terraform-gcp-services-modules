# Variable values

project_id              = "my-gcp-project"
service_accounts = [
  {
    name         = "my-sa-1"
    project      = "my-gcp-project"
    display_name = "My Service Account 1"
    roles        = ["roles/storage.admin", "roles/pubsub.editor"]
  },
  {
    name         = "my-sa-2"
    project      = "my-gcp-project"
    display_name = "My Service Account 2"
    roles        = ["roles/viewer"]
  }
]

composer_environments = [
  {
    name            = "composer-env-1"
    project         = "my-gcp-project"
    location        = "us-central1"
    node_count      = 3
    machine_type    = "n1-standard-1"
    disk_size_gb    = 30
    airflow_version = "composer-2.0.30-airflow-2.2.3"
    labels          = {
      env = "prod"
    }
    environment_variables = {
      ENV = "production"
    }
    web_server_network_access_control = {
      allowed_ip_ranges = [
        {
          value       = "0.0.0.0/0"
          description = "Allow all"
        }
      ]
    }
  },
  {
    name         = "composer-env-2"
    project      = "my-gcp-project"
    location     = "us-east1"
  }
]

app_engine_services = [
  {
    service_name = "default"
    project      = "my-gcp-project"
    runtime      = "python39"
    env_variables = {
      ENV = "prod"
    }
    entrypoint = "gunicorn -b :$PORT main:app"
  },
  {
    service_name = "api"
    project      = "my-gcp-project"
    runtime      = "nodejs16"
    env_variables = {
      NODE_ENV = "production"
    }
  }
]

tables = [
  {
    table_id = "users"
    schema   = "schemas/users.json"
  },
  {
    table_id = "events"
    schema   = "schemas/events.json"
  },
  {
    table_id = "products"
    schema   = "schemas/products.json"
  }
]

scheduled_queries = [
  {
    display_name      = "Daily Events Summary"
    destination_table = "daily_events"
    query_file        = "sql/daily_events.sql"
    schedule          = "every 24 hours"
    start_time        = "2025-07-20T06:00:00Z"
  },
  {
    display_name      = "Weekly Users Summary"
    destination_table = "weekly_users"
    query_file        = "sql/weekly_users.sql"
    schedule          = "every monday 05:00"
    start_time        = "2025-07-21T05:00:00Z"
  }
]

datasets = [
  {
    dataset_id  = "analytics_data"
    location    = "US"
    description = "Stores analytics and event data"
    labels = {
      env = "prod"
      team = "data"
    }
  },
  {
    dataset_id  = "test_dataset"
    location    = "EU"
    description = "For testing purposes"
    labels = {
      env = "dev"
    }
  }
]

views = [
  {
    dataset_id = "analytics"
    view_id    = "user_view"
    query_file = "sql/user_view.sql"
  },
  {
    dataset_id = "sales"
    view_id    = "sales_summary"
    query_file = "sql/sales_summary.sql"
  }
]

cloud_functions = [
  {
    name        = "helloWorld"
    source_dir  = "functions/hello_world"
    entry_point = "hello_world"
    runtime     = "python310"
    trigger_http = true
  },
  {
    name        = "fileProcessor"
    source_dir  = "functions/process_file"
    entry_point = "process_file"
    runtime     = "python310"
    trigger_bucket = "auto"
    available_memory_mb = 512
  }
]

queues = [
  {
    name       = "email-queue"
    type       = "push"
    push_endpoint = "https://example.com/send-email"
    max_attempts = 3
  },
  {
    name       = "async-tasks"
    type       = "pull"
    max_attempts = 5
    max_dispatches_per_second = 20
  }
]

cloud_run_services = [
  {
    name      = "api-backend"
    image     = "gcr.io/my-gcp-project/backend:latest"
    region    = "us-central1"
    cpu       = 1
    memory    = "512Mi"
    env_vars  = {
      ENV = "prod"
    }
    allow_unauthenticated = true
  },
  {
    name      = "worker"
    image     = "gcr.io/my-gcp-project/worker:latest"
    region    = "europe-west1"
    cpu       = 1
    memory    = "256Mi"
    allow_unauthenticated = false
  }
]

tasks = [
  {
    name       = "send-welcome-email"
    queue      = "email-queue"
    location   = "us-central1"
    http_url   = "https://example.com/send"
    method     = "POST"
    body       = jsonencode({ user_id = "abc123" })
    headers    = {
      "Content-Type" = "application/json"
    }
  },
  {
    name     = "process-invoice"
    queue    = "billing-queue"
    location = "us-central1"
    pull     = true
  }
]

workflows = [
  {
    name        = "workflow-one"
    description = "First example workflow"
    region      = "us-central1"
    source      = <<-EOT
      main:
        steps:
          - init:
              assign:
                - message: "Hello from workflow one!"
    EOT
  },
  {
    name        = "workflow-two"
    description = "Second example workflow"
    region      = "us-central1"
    source      = <<-EOT
      main:
        steps:
          - init:
              assign:
                - message: "Hello from workflow two!"
    EOT
  }
]


cron_jobs = [
  {
    name        = "job-1"
    description = "First cron job"
    schedule    = "*/5 * * * *"          # every 5 minutes
    time_zone   = "UTC"
    http_target = {
      uri         = "https://example.com/api/endpoint1"
      http_method = "POST"
      body        = "{\"message\": \"hello from job 1\"}"
      headers     = {
        "Content-Type" = "application/json"
        "X-Custom"     = "value1"
      }
    }
  },
  {
    name        = "job-2"
    description = "Second cron job"
    schedule    = "0 9 * * *"            # every day at 9:00 UTC
    time_zone   = "UTC"
    http_target = {
      uri         = "https://example.com/api/endpoint2"
      http_method = "GET"
    }
  }
]


dataflow_jobs = [
  {
    name              = "job-1"
    region            = "us-central1"
    template_gcs_path = "gs://my-bucket/templates/my-dataflow-template"
    parameters = {
      inputFile  = "gs://my-bucket/input/file1.txt"
      outputPath = "gs://my-bucket/output/job1/"
    }
    max_workers = 10
    zone        = "us-central1-a"
  },
  {
    name              = "job-2"
    region            = "us-central1"
    template_gcs_path = "gs://my-bucket/templates/my-dataflow-template"
    parameters = {
      inputFile  = "gs://my-bucket/input/file2.txt"
      outputPath = "gs://my-bucket/output/job2/"
    }
  }
]


dataproc_clusters = [
  {
    name   = "cluster-1"
    region = "us-central1"
    zone   = "us-central1-a"
    cluster_config = {
      master_config = {
        num_instances = 1
        machine_type  = "n1-standard-4"
      }
      worker_config = {
        num_instances = 2
        machine_type  = "n1-standard-4"
      }
      software_config = {
        image_version       = "2.0-debian10"
        optional_components = ["ANACONDA", "JUPYTER"]
      }
      initialization_actions = [
        {
          executable_file = "gs://my-bucket/scripts/init.sh"
          timeout_sec     = 300
        }
      ]
    }
  },
  {
    name   = "cluster-2"
    region = "europe-west1"
    cluster_config = {
      master_config = {
        num_instances = 1
        machine_type  = "n1-standard-2"
      }
      worker_config = {
        num_instances = 3
        machine_type  = "n1-standard-2"
      }
    }
  }
]


dns_records = [
  {
    name         = "www.example.com."
    type         = "A"
    ttl          = 300
    rrdatas      = ["192.0.2.1"]
    managed_zone = "example-zone"
  },
  {
    name         = "mail.example.com."
    type         = "CNAME"
    ttl          = 300
    rrdatas      = ["ghs.googlehosted.com."]
    managed_zone = "example-zone"
  },
  {
    name         = "_acme-challenge.example.com."
    type         = "TXT"
    ttl          = 300
    rrdatas      = ["\"some-challenge-token\""]
    managed_zone = "example-zone"
  }
]

gcs_buckets = [
  {
    name          = "my-bucket-1"
    location      = "US"
    storage_class = "STANDARD"
    force_destroy = true
    versioning_enabled = true
    lifecycle_rule = [
      {
        action = {
          type = "Delete"
        }
        condition = {
          age = 30
        }
      }
    ]
  },
  {
    name          = "my-bucket-2"
    location      = "EU"
    storage_class = "NEARLINE"
  }
]


iap_bindings = [
  {
    project         = "my-gcp-project"
    backend_service = "my-backend-service-1"
    role            = "roles/iap.httpsResourceAccessor"
    members         = [
      "user:alice@example.com",
      "group:dev-team@example.com"
    ]
  },
  {
    project         = "my-gcp-project"
    backend_service = "my-backend-service-2"
    role            = "roles/iap.httpsResourceAccessor"
    members         = [
      "user:bob@example.com"
    ]
  }
]


k8s_deployments = [
  {
    name      = "app1"
    namespace = "default"
    replicas  = 3
    labels    = {
      app = "app1"
    }
    container = {
      name  = "app1-container"
      image = "nginx:1.23"
      ports = [80]
    }
  },
  {
    name      = "app2"
    namespace = "default"
    replicas  = 2
    labels    = {
      app = "app2"
    }
    container = {
      name  = "app2-container"
      image = "nginx:1.23"
      ports = [8080, 9090]
    }
  }
]


load_balancers = [
  {
    name    = "lb1"
    project = "my-gcp-project"

    backend_services = [
      {
        name           = "backend1"
        protocol       = "HTTP"
        backends       = [
          { group = "projects/my-gcp-project/zones/us-central1-a/instanceGroups/instance-group-1" }
        ]
        health_checks  = ["projects/my-gcp-project/global/healthChecks/health-check-1"]
      }
    ]

    forwarding_rules = [
      {
        name               = "fr-lb1"
        ip_address         = "34.68.194.64"
        ip_protocol        = "TCP"
        port_range         = "80"
        target_proxy       = "lb1-http-proxy" # automatically generated name; you can adjust logic
        load_balancing_scheme = "EXTERNAL"
      }
    ]
  }
]

pubsub_topics = [
  {
    name    = "topic-1"
    project = "my-gcp-project"
    labels  = {
      env = "prod"
    }
    message_storage_policy = {
      allowed_persistence_regions = ["us-central1", "us-east1"]
    }
    subscriptions = [
      {
        name = "sub-1"
        ack_deadline_seconds = 20
        retain_acked_messages = true
        message_retention_duration = "604800s" # 7 days
        labels = {
          team = "analytics"
        }
      }
    ]
  },
  {
    name    = "topic-2"
    project = "my-gcp-project"
  }
]

subnets = [
  {
    name          = "subnet-1"
    project       = "my-gcp-project"
    region        = "us-central1"
    network       = "default"
    ip_cidr_range = "10.0.1.0/24"
    description   = "First subnet"
    private_ip_google_access = true
  },
  {
    name          = "subnet-2"
    project       = "my-gcp-project"
    region        = "us-central1"
    network       = "default"
    ip_cidr_range = "10.0.2.0/24"
  }
]

vertex_ai_endpoints = [
  {
    name     = "endpoint-1"
    project  = "my-gcp-project"
    location = "us-central1"
    description = "First Vertex AI endpoint"
    labels   = {
      env = "prod"
    }
  },
  {
    name     = "endpoint-2"
    project  = "my-gcp-project"
    location = "us-central1"
  }
]

vpcs = [
  {
    name                  = "vpc-1"
    project               = "my-gcp-project"
    auto_create_subnetworks = false
    description           = "Main VPC network"
    routing_mode          = "GLOBAL"
  },
  {
    name                  = "vpc-2"
    project               = "my-gcp-project"
    auto_create_subnetworks = true
    description           = "Secondary VPC network with auto subnetworks"
    routing_mode          = "REGIONAL"
  }
]
