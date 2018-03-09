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
  enabled     = true
  domain_name = "registry.swarm.pw"

  release_name = "docker-registry"

  chart_repo    = "stable"
  chart_name    = "docker-registry"
  chart_version = "1.0.2"

  # release_values = "values.yaml"
}

ingress_basic_auth = {
  # This Kubernetes secret is used in values.yaml
  secret_name = "registry-htpasswd"
  username    = "docker-registry/basic-auth-username"
  password    = "docker-registry/basic-auth-password"
}
