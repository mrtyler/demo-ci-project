# Module metadata

terragrunt = {
  terraform {
    source = "/exekube-modules//gcp-kms-secret-mgmt"
  }

  include = {
    path = "${find_in_parent_folders()}"
  }
}

# Module configuration
# ---
# Module inputs and defaults:
# https://github.com/exekube/exekube/blob/develop/modules/gcp-kms-secret-mgmt/variables.tf

keyring_admins = [
  "user:ilya@sotkov.com",
]

keyring_users = []

crypto_keys = {
  "team1" = "user:ilya@sotkov.com"
  "team2" = "user:ilya@sotkov.com"
}
