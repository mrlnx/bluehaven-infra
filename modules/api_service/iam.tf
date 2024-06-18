# Create service account for api
resource "google_service_account" "api_service_sa" {
  project      = var.project_number
  account_id   = "${var.name_prefix}-api-sa"
  display_name = "${var.name_prefix}-api-sa service account"
  description  = "Service Account for ${var.name_prefix}-api-sa Terraform on Cloud Run"

  lifecycle {
    ignore_changes = [
      project,
    ]
  }
}


# Assign backend roles to service account
resource "google_project_iam_member" "api_service_invoke_access" {
  for_each   = toset(var.backend_roles_list)
  project    = var.project_id
  role       = each.value
  member     = "serviceAccount:${google_service_account.api_service_sa.email}"
  depends_on = [var.project_service]
}


# Allow public access for the backend
resource "google_cloud_run_service_iam_member" "api_service_public_access" {
  project  = var.project_id
  service  = module.api_service.name
  location = var.region

  role   = "roles/run.invoker"
  member = "allUsers"
}

