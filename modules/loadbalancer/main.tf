resource "google_compute_global_address" "load_balancer" {
  name         = "${var.name_prefix}-loadbalancer"
  project      = var.project_id
  address_type = "EXTERNAL" # check if we can add a fixed ip
  # count        = var.environment == "prod" ? 1 : 0
}

resource "google_compute_url_map" "load_balancer_http" {
  name    = "${var.name_prefix}-http"
  project = var.project_id
  # count   = var.environment == "prod" ? 1 : 0


  default_url_redirect {
    https_redirect = true
    strip_query    = true
    path_redirect  = "/"
  }
}
resource "google_compute_url_map" "load_balancer_https" {
  name    = "${var.name_prefix}-https"
  project = var.project_id
  # count   = var.environment == "prod" ? 1 : 0

  default_service = google_compute_backend_service.load_balancer.self_link
}

resource "google_compute_target_http_proxy" "http_proxy" {
  name    = "${var.name_prefix}-http-proxy"
  project = var.project_id
  # count   = var.environment == "prod" ? 1 : 0

  # url_map = google_compute_url_map.load_balancer_http[count.index]
  url_map = google_compute_url_map.load_balancer_http.self_link
}

resource "google_compute_global_forwarding_rule" "load_balancer_http" {
  name    = "${var.name_prefix}-forwarding-http"
  project = var.project_id
  # count   = var.environment == "prod" ? 1 : 0

  target     = google_compute_target_http_proxy.http_proxy.self_link
  port_range = "80"
  ip_address = google_compute_global_address.load_balancer.self_link
}

resource "google_compute_target_https_proxy" "https_proxy" {
  name    = "${var.name_prefix}-https-proxy"
  project = var.project_id
  # count   = var.environment == "prod" ? 1 : 0

  ssl_certificates = [var.ssl_certificates]

  url_map = google_compute_url_map.load_balancer_https.self_link
}

resource "google_compute_global_forwarding_rule" "load_balancer_https" {
  name    = "${var.name_prefix}-forwarding-https"
  project = var.project_id
  # count   = var.environment == "prod" ? 1 : 0

  target     = google_compute_target_https_proxy.https_proxy.self_link
  port_range = "443"
  ip_address = google_compute_global_address.load_balancer.self_link
}

resource "google_compute_backend_service" "load_balancer" {
  name     = "${var.name_prefix}-backend"
  project  = var.project_id
  protocol = "HTTP2"
  # count    = var.environment == "prod" ? 1 : 0

  security_policy = length(var.security) > 0 ? var.security.name : null

  backend {
    group = google_compute_region_network_endpoint_group.frontend_neg.self_link
  }
}

resource "google_compute_region_network_endpoint_group" "frontend_neg" {
  name                  = "${var.name_prefix}-run-neg"
  project               = var.project_id
  network_endpoint_type = "SERVERLESS"
  region                = var.region
  # count                 = var.environment == "prod" ? 1 : 0

  cloud_run {
    service = var.service.name
  }

  lifecycle {
    create_before_destroy = true
  }
}
