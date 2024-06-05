locals {
  managed_domains = var.domains
}

resource "random_id" "certificate" {
  byte_length = 4
  prefix      = "issue6147-cert-"

  keepers = {
    domains = join(",", local.managed_domains)
  }
}

resource "google_compute_managed_ssl_certificate" "ssl_cert" {
  name    = "${random_id.certificate.hex}-ssl-cert"
  project = var.project_id

  lifecycle {
    create_before_destroy = true
  }

  managed {
    domains = local.managed_domains
  }
}

