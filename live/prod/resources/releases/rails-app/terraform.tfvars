# Module metadata

terragrunt = {
  terraform {
    source = "/exekube-modules//helm-release"
  }

  dependencies {
    paths = [
      "../../cluster",
      "../ingress-controller",
      "../cert-manager",
    ]
  }

  include = {
    path = "${find_in_parent_folders()}"
  }
}

# Module configuration

release_spec = {
  enabled      = false
  release_name = "rails-app"

  chart_repo = "exekube"
  chart_name = "rails-app"

  domain_name = "prod.rails-app.flexeption.pw"
}
