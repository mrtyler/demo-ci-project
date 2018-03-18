# Module metadata

terragrunt = {
  terraform {
    source = "/exekube-modules//gke-cluster"
  }

  include = {
    path = "${find_in_parent_folders()}"
  }
}

# Module configuration

project_id = "prod-internal-ops-0aea2b77"

network_name = "prod-internal-ops-network"
