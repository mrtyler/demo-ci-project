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
  enabled     = false
  domain_name = "registry.flexeption.pw"

  release_name = "docker-registry"

  chart_repo    = "stable"
  chart_name    = "docker-registry"
  chart_version = "1.0.5"
}

ingress_basic_auth = {
  secret_name = "registry-htpasswd"
  username    = "team1/docker-registry/basic-auth-username"
  password    = "team1/docker-registry/basic-auth-password"
}
