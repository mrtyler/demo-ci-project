# Module metadata

terragrunt = {
  terraform {
    source = "/exekube-modules//helm-release"
  }

  dependencies {
    paths = [
      "../../cluster",
      "../../system/ingress-controller",
      "../../system/kube-lego",
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

  domain_name = "ci.flexeption.pw"
}

pre_hook = {
  command = "kubectl apply -f $TF_VAR_secrets_dir/team1/concourse/concourse.yaml"
}

post_hook = {
  command = "kubectl apply -f $TF_VAR_secrets_dir/team1/ci/"
}
