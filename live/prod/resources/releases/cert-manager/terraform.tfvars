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
  namespace    = "kube-system"
  release_name = "cert-manager"

  chart_repo    = "stable"
  chart_name    = "cert-manager"
  chart_version = "0.2.3"
}

post_hook = {
  command = "kubectl apply -f $SECRETS_DIR/team1/staging-issuer.yaml"
}
