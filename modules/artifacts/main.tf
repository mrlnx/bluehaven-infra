
# create docker repository for api services
resource "google_artifact_registry_repository" "registery_repository" {
  location      = var.region
  repository_id = "${var.name_prefix}-api-services"
  project       = var.project_id
  description   = "Docker repository ${var.name_prefix}-api-services"
  format        = "DOCKER"
}
