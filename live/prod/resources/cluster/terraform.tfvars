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

network_name = "prod-internal-ops-network"
