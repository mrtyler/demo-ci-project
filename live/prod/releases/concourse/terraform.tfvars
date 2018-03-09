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

release_spec = {
  enabled      = true
  release_name = "concourse"

  chart_repo    = "stable"
  chart_name    = "concourse"
  chart_version = "1.0.0"

  domain_name = "ci.swarm.pw"

  # release_values = "values.yaml"
}

pre_hook = {
  command = <<-EOF
            kubectl create secret generic concourse-concourse \
            --from-file=$TF_VAR_xk_live_dir/secrets/concourse/ || true
            EOF
}

post_hook = {
  command = "kubectl apply -f $TF_VAR_xk_live_dir/secrets/ci/"
}
