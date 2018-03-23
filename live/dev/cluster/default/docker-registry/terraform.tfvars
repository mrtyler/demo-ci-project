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
