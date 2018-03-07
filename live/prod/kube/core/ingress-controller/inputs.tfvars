release_spec = {
  enabled        = true
  release_name   = "ingress-controller"
  release_values = "values.yaml"

  chart_repo    = "stable"
  chart_name    = "nginx-ingress"
  chart_version = "0.9.4"
}

post_hook = {
  command = <<-EOF
  kubectl apply -f $XK_LIVE_DIR/secrets/letsencrypt.yaml \
  && kubectl apply -f $XK_LIVE_DIR/secrets/dashboard-rbac.yaml
  EOF
}
