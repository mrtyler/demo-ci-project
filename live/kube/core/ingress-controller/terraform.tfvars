# ------------------------------------------------------------------------------
# Module metadata
# ------------------------------------------------------------------------------

terragrunt = {
  terraform {
    source = "/exekube-modules//helm-release"
  }

  dependencies {
    paths = [
      "../../../cloud/gke-cluster",
    ]
  }

  include = {
    path = "${find_in_parent_folders()}"
  }
}
