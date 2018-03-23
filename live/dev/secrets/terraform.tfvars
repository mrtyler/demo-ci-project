# ↓ Module metadata

terragrunt = {
  terraform {
    source = "/exekube-modules//gcp-kms-secret-mgmt"
  }

  include = {
    path = "${find_in_parent_folders()}"
  }
}

# ↓ Module configuration (empty means all default)

keys = [
  "kube-system",
  "default",
]
