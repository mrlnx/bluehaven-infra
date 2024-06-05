# resource which assigns roles to the build service account
resource "google_project_iam_member" "all_build" {
  for_each   = toset(var.build_roles_list)
  project    = var.project_number
  role       = each.value
  member     = "serviceAccount:${local.sabuild}"
  depends_on = [google_project_service.service]
}
