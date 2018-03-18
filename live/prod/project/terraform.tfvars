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

product_env = "prod"

dns_zones = {
  "flexeption-pw" = "flexeption.pw."
  "flexeption-us" = "flexeption.us."
}

create_static_ip_address = true

# Format: "dns_zone" = "dns.record.com"
# Pointed to the automatically created static IP address
# Only A-records are allowed
# Will be replaced by https://github.com/kubernetes-incubator/external-dns later
ingress_domains = {
  "flexeption-pw" = "*.flexeption.pw."
  "flexeption-us" = "*.flexeption.us."
}
