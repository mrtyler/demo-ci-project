# Module metadata

terragrunt = {
  terraform {
    source = "/exekube-modules//gcp-project"
  }

  include = {
    path = "${find_in_parent_folders()}"
  }
}

# Module configuration

dns_zones = {
  "flexeption-pw" = "flexeption.pw."
  "flexeption-us" = "flexeption.us."
}

ingress_domains = {
  "flexeption-pw" = "*.flexeption.pw."
  "flexeption-us" = "*.flexeption.us."
}
