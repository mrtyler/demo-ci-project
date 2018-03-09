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
# Module inputs and defaults:
# https://github.com/exekube/exekube/blob/develop/modules/helm-release/inputs.tf

release_spec = {
  enabled       = true
  release_name  = "ingress-controller"
  chart_repo    = "stable"
  chart_name    = "nginx-ingress"
  chart_version = "0.9.4"
}

post_hook = {
  command = <<-EOF
  kubectl apply -f $TF_VAR_xk_live_dir/secrets/letsencrypt.yaml \
  && kubectl apply -f $TF_VAR_xk_live_dir/secrets/dashboard-rbac.yaml
  EOF
}
