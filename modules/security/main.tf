# set security policy for loadbalancer = staging
resource "google_compute_security_policy" "frontend_ip_policy" {
  # count = local.create_security_policy ? 1 : 0

  project = var.project_id
  name    = "${var.name_prefix}-frontend-ip-policy"

  rule {
    description = "Default rule"
    action      = "deny(403)"
    priority    = 2147483647
    match {
      versioned_expr = "SRC_IPS_V1"
      config {
        src_ip_ranges = ["*"]
      }
    }
  }

  dynamic "rule" {
    for_each = var.base_ip_policy

    content {
      action      = "allow"
      description = rule.key
      priority    = 1000 + index(keys(var.base_ip_policy), rule.key)
      match {
        versioned_expr = "SRC_IPS_V1"
        config {
          src_ip_ranges = rule.value
        }
      }
    }
  }
}
