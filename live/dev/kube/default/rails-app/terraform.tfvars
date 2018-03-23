# ↓ Module metadata

terragrunt = {
  terraform {
    source = "/exekube-modules//helm-release"
  }

  dependencies {
    paths = [
      "../../cluster",
      "../../kube-system/ingress-controller",
      "../../kube-system/kube-lego",
    ]
  }

  include = {
    path = "${find_in_parent_folders()}"
  }
}

# Module configuration

release_spec = {
  enabled          = true
  release_name     = "rails-app"
  tiller_namespace = "default"

  chart_repo = "exekube"
  chart_name = "rails-app"

  domain_name = "prod.rails-app.flexeption.pw"
}
