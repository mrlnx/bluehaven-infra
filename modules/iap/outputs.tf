output "cloud_run_service_url" {
  value = var.service.default.status[0].url
}
