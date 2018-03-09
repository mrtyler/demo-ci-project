# Module metadata

terragrunt = {
  terraform {
    source = "/exekube-modules//helm-release"
  }

  dependencies {
    paths = [
      "../../cluster",
      "../ingress-controller",
    ]
  }

  include = {
    path = "${find_in_parent_folders()}"
  }
}

# Module configuration

release_spec = {
  enabled      = true
  release_name = "kube-lego"

  chart_repo    = "stable"
  chart_name    = "kube-lego"
  chart_version = "0.4.0"

  # release_values = "values.yaml"
}
