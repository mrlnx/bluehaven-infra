resource "google_secret_manager_secret" "db_admin_password" {
  project   = var.project_id
  provider  = google
  secret_id = "${var.name_prefix}-database-admin-password"
  replication {
    auto {}
  }
  depends_on = [var.project_service]
}
resource "google_secret_manager_secret_version" "db_admin_password_version" {
  provider    = google
  secret      = google_secret_manager_secret.db_admin_password.id
  secret_data = random_password.password.result
}

data "google_secret_manager_secret_version" "db_admin_password_version" {
  provider = google
  secret   = google_secret_manager_secret.db_admin_password.name
  version  = google_secret_manager_secret_version.db_admin_password_version.version
}

# Access the secret data
data "google_secret_manager_secret_version_access" "db_admin_password_access" {
  secret  = google_secret_manager_secret.db_admin_password.id
  version = data.google_secret_manager_secret_version.db_admin_password_version.version
}
