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
  release_name = "chartmuseum"

  chart_repo    = "incubator"
  chart_name    = "chartmuseum"
  chart_version = "0.3.5"
  domain_name   = "charts.swarm.pw"

  # release_values = "values.yaml"
}

post_hook = {
  command = "sleep 10"
}

ingress_basic_auth = {
  # This Kubernetes secret is used in values.yaml
  secret_name = "chartrepo-htpasswd"
  username    = "chartmuseum/basic-auth-username"
  password    = "charetmuseum/basic-auth-password"
}
