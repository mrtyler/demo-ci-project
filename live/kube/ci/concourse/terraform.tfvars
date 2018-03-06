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
      "../../core/ingress-controller",
      "../../core/kube-lego",
    ]
  }

  include = {
    path = "${find_in_parent_folders()}"
  }
}
