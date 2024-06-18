variable "github_ssh_key" {

}

variable "name_prefix" {
  description = "Prefix name of the cloud build resource"
  type        = string
}

variable "project_service" {

}

variable "project_id" {
  description = "Google Cloud project ID"
  type        = string
}

variable "project_number" {
  description = "Project number"
  type        = string
}

variable "cloudbuild_service_roles_list" {
  description = "List of all roles to be assigned to the cloudbuild account"

  default = [
    "roles/secretmanager.secretAccessor",
    "roles/logging.logWriter",
    "roles/storage.admin",
    "roles/cloudbuild.builds.builder",
    "roles/serviceusage.serviceUsageConsumer",
    "roles/iam.serviceAccountUser",
    "roles/run.developer",
    "roles/vpcaccess.user",
    "roles/run.admin",
    "roles/artifactregistry.admin",
    "roles/cloudsql.client",
  ]
}
