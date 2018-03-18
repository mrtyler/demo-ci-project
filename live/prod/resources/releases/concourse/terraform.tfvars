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
  enabled      = false
  release_name = "concourse"

  chart_repo    = "stable"
  chart_name    = "concourse"
  chart_version = "1.0.4"

  domain_name = "ci.swarm.pw"
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
