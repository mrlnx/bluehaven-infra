resource "google_service_account" "cloudbuild_service_sa" {
  project      = var.project_number
  account_id   = "${var.name_prefix}-cb-sa"
  display_name = "${var.name_prefix}-cloudbuild-service account"
  description  = "Service Account for ${var.name_prefix}-cloud-build-service Terraform on Cloud Run"

  lifecycle {
    ignore_changes = [
      project,
    ]
  }
}

# Assign backend database roles to service account
resource "google_project_iam_member" "cloudbuild_service_invoke_cloud_run" {
  for_each   = toset(var.cloudbuild_service_roles_list)
  project    = var.project_id
  role       = each.value
  member     = "serviceAccount:${google_service_account.cloudbuild_service_sa.email}"
  depends_on = [var.project_service]
}
