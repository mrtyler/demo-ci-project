# Module metadata

terragrunt = {
  terraform {
    source = "/exekube-modules//helm-release"
  }

  dependencies {
    paths = [
      "../../cluster",
    ]
  }

  include = {
    path = "${find_in_parent_folders()}"
  }
}

# Module configuration

release_spec = {
  enabled       = true
  release_name  = "ingress-controller"
  chart_repo    = "stable"
  chart_name    = "nginx-ingress"
  chart_version = "0.9.4"
}

post_hook = {
  command = "kubectl apply -f $SECRETS_DIR/team1/dashboard-rbac.yaml"
}
