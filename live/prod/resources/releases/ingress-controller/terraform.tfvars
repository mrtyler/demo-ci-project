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
  chart_version = "0.11.1"
}

post_hook = {
  command = <<-EOF
    kubectl apply -f $TF_VAR_secrets_dir/team1/dashboard-rbac.yaml \
    && kubectl apply -f $TF_VAR_secrets_dir/team1/tls-certs.yaml
    EOF
}
