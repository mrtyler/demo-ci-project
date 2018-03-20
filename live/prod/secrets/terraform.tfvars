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

keyring_admins = [
  "user:ilya@sotkov.com",
]

keyring_users = []

crypto_keys = [
  "team1",
  "team2",
  "system",
]

crypto_keys_users = [
  "user:ilya@sotkov.com",
  "user:ilya@sotkov.com",
  "user:ilya@sotkov.com",
]
