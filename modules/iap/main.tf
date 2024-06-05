
# Add IAM policy binding for IAP
resource "google_project_iam_binding" "iap_binding" {
  project = var.project_id
  role    = "roles/iap.httpsResourceAccessor"
  members = var.iap_allowed_members
}

# Create custom domain mapping
resource "null_resource" "create_custom_domain_mapping" {
  provisioner "local-exec" {
    command = <<EOT
gcloud beta run domain-mappings create --service ${var.service.name} --domain ${var.domain} --region ${var.region}
EOT
  }

  triggers = {
    service_name = var.service.name
    domain       = var.domain
  }
}
