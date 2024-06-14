resource "google_service_account" "api_db_sa" {
  project      = var.project_number
  account_id   = "${var.name_prefix}-api-db-sa-${random_id.account.hex}"
  display_name = "API Service database account"
  description  = "Service Account for the backend database Terraform on Cloud Run"

  lifecycle {
    create_before_destroy = true
  }
}

# Assign backend database roles to service account
resource "google_project_iam_member" "api_db_invoke_access" {
  for_each   = toset(var.backend_db_roles_list)
  project    = var.project_id
  role       = each.value
  member     = "serviceAccount:${google_service_account.api_db_sa.email}"
  depends_on = [var.project_service]
}

resource "random_id" "account" {
  byte_length = 3
}
