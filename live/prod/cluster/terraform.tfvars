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


# Default values:
#
# gke_version = "1.8.7-gke.1"
# enable_legacy_auth = "false"
# gcp_zone = "europe-west1-d"
# cluster_name = "k8s-cluster"
# nodepool_name = "k8s-np"
