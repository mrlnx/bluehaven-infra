# database url
resource "google_secret_manager_secret" "database_url" {
  project   = var.project_id
  provider  = google
  secret_id = "${var.name_prefix}-database-url"
  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "database_url_version" {
  provider    = google
  secret      = google_secret_manager_secret.database_url.id
  secret_data = local.database_url
}

data "google_secret_manager_secret_version" "database_url_version" {
  provider = google
  secret   = google_secret_manager_secret.database_url.name
  version  = google_secret_manager_secret_version.database_url_version.version
}
