# Module metadata

terragrunt = {
  terraform {
    source = "/exekube-modules//gke-cluster"
  }

  include = {
    path = "${find_in_parent_folders()}"
  }
}

# Module metadata
# Module inputs and defaults:
# https://github.com/exekube/exekube/blob/develop/modules/gke-cluster/inputs.tf
