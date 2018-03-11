# Module metadata

terragrunt = {
  terraform {
    source = "/exekube-modules//helm-release"
  }

  dependencies {
    paths = [
      "../../cluster",
      "../ingress-controller",
      "../kube-lego",
    ]
  }

  include = {
    path = "${find_in_parent_folders()}"
  }
}

# Module configuration
# ---
# Module inputs and defaults:
# https://github.com/exekube/exekube/blob/develop/modules/helm-release/inputs.tf

release_spec = {
  enabled      = true
  release_name = "rails-app"

  chart_repo = "exekube"
  chart_name = "rails-app"

  domain_name = "staging.rails.swarm.pw"
}
