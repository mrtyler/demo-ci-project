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
  enabled        = true
  release_name   = "concourse"
  release_values = "values.yaml"

  chart_repo    = "stable"
  chart_name    = "concourse"
  chart_version = "1.0.0"

  domain_name = "ci.swarm.pw"
}

pre_hook = {
  command = <<-EOF
            kubectl create secret generic concourse-concourse \
            --from-file=$XK_LIVE_DIR/secrets/concourse/ || true
            EOF
}

post_hook = {
  command = "kubectl apply -f $XK_LIVE_DIR/secrets/ci/"
}
