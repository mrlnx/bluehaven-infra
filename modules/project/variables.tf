# list of api's to be enabled
variable "gcp_service_list" {
  description = "List of GCP services to deploy"
  type        = list(string)
  default = ["cloudapis.googleapis.com",
    "compute.googleapis.com",
    "run.googleapis.com",
    "vpcaccess.googleapis.com",
    "servicenetworking.googleapis.com",
    "artifactregistry.googleapis.com",
    "secretmanager.googleapis.com",
    "cloudbuild.googleapis.com",
    "sql-component.googleapis.com",
    "sqladmin.googleapis.com",
    "storage.googleapis.com",
    "iam.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "logging.googleapis.com",
    "iap.googleapis.com",
  ]
}

variable "project_id" {
  description = "Google Cloud project ID"
  type        = string
}

variable "zone" {
  type    = string
  default = "europe-west4-a" # TODO remove and place into tfvars
}

variable "tf_service_account" {
  type = string
}

variable "region" {
  description = "The region where the production environment will be created"
  type        = string
  default     = "europe-west4"
}

variable "project_number" {
  description = "Project number"
  type        = string
}

variable "name_prefix" {
  description = "Prefix name of the api service"
  type        = string
}
