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
