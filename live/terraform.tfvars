terragrunt = {
  # Configure Terragrunt to automatically store tfstate files in an GCS bucket
  remote_state {
    backend = "gcs"

    config {
      project     = "${get_env("TF_VAR_terraform_project", "")}"
      credentials = "${get_env("TF_VAR_terraform_credentials", "")}"
      bucket      = "${get_env("TF_VAR_terraform_remote_state", "")}"
      prefix      = "${path_relative_to_include()}"
    }
  }

  terraform {
    extra_arguments "auto_approve" {
      commands  = ["apply"]
      arguments = ["-auto-approve"]
    }

    extra_arguments "force_destroy" {
      commands  = ["destroy"]
      arguments = ["-force"]
    }
  }
}
