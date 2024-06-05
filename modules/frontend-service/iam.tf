# Create service account for frontend application
resource "google_service_account" "frontend_service_sa" {
  project      = var.project_number
  account_id   = "${var.name_prefix}-sa"
  display_name = "${var.name_prefix}-frontend-service account"
  description  = "Service Account for ${var.name_prefix}-frontend-service Terraform on Cloud Run"
}

# Assign frontend application roles to service account
resource "google_project_iam_member" "frontend_service_invoke_cloud_run" {
  for_each   = toset(var.frontend_service_roles_list)
  project    = data.google_project.project.number
  role       = each.value
  member     = "serviceAccount:${google_service_account.frontend_service_sa.email}"
  depends_on = [var.project_service]
}

# Allow public access for the frontend service
resource "google_cloud_run_service_iam_member" "frontend_service_public_access" {
  project  = var.project_id
  service  = module.frontend_service.name
  location = var.region

  role   = "roles/run.invoker"
  member = "allUsers"
}
