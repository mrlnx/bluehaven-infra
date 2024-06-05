provider "google" {
  project                     = var.project_id
  region                      = var.region
  zone                        = var.zone
  impersonate_service_account = var.tf_service_account
}

resource "google_project_service" "service" {
  for_each           = toset(var.gcp_service_list)
  project            = var.project_id
  service            = each.value
  disable_on_destroy = false
}
