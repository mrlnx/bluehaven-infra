
# create secret github ssh key
resource "google_secret_manager_secret" "github_ssh_key" {
  provider  = google
  secret_id = "${var.name_prefix}-github-ssh-key"
  project   = var.project_id

  replication {
    auto {}
  }
  depends_on = [var.project_service]
}

resource "google_secret_manager_secret_version" "github_ssh_key_version" {
  provider    = google
  secret      = google_secret_manager_secret.github_ssh_key.id
  secret_data = var.github_ssh_key
}

data "google_secret_manager_secret_version" "github_ssh_key_version" {
  provider = google
  secret   = google_secret_manager_secret.github_ssh_key.name
  version  = google_secret_manager_secret_version.github_ssh_key_version.version
}
