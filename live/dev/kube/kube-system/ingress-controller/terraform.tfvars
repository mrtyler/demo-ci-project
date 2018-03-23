# ↓ Module metadata

terragrunt = {
  terraform {
    source = "/exekube-modules//helm-release"
  }

  dependencies {
    paths = [
      "../../cluster",
      "../helm-tiller",
    ]
  }

  include = {
    path = "${find_in_parent_folders()}"
  }
}

# ↓ Module configuration (empty means all default)

release_spec = {
  enabled       = true
  namespace     = "kube-system"
  release_name  = "ingress-controller"
  chart_repo    = "stable"
  chart_name    = "nginx-ingress"
  chart_version = "0.11.1"
}

kubernetes_secrets = [
  "kube-system/rbac/dashboard.yaml",
  "kube-system/kube-lego/certs.yaml",
]
