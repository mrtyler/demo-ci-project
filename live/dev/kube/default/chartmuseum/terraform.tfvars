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

# ↓ Module configuration (empty means all default)

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
  username    = "default/chartmuseum/basic-auth-username"
  password    = "default/chartmuseum/basic-auth-password"
}
