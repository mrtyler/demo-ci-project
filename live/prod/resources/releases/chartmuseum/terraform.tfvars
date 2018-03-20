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
  release_name = "chartmuseum"

  chart_repo    = "incubator"
  chart_name    = "chartmuseum"
  chart_version = "0.4.4"
  domain_name   = "charts.flexeption.pw"
}

post_hook = {
  command = "sleep 10"
}

ingress_basic_auth = {
  secret_name = "chartrepo-htpasswd"
  username    = "team1/chartmuseum/basic-auth-username"
  password    = "team1/chartmuseum/basic-auth-password"
}
