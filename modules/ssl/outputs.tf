output "certificate" {
  # value = google_compute_managed_ssl_certificate.ssl_cert
  value = google_compute_managed_ssl_certificate.ssl_cert.self_link
}
