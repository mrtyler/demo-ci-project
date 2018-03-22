# Module metadata

terragrunt = {
  terraform {
    source = "/exekube-modules//helm-tiller"
  }

  dependencies {
    paths = [
      "../../cluster",
    ]
  }

  include = {
    path = "${find_in_parent_folders()}"
  }
}

# Module configuration variables

custom_tls_dir = "system"
