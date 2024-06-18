variable "region" {
  description = "The region where the frontend service will be created"
  type        = string
}

variable "project_id" {
  description = "Google Cloud project ID"
  type        = string
}

variable "env_variables" {
  description = "List of environment variables for the container"
  type = list(object({
    name  = string
    value = optional(string)
    secret_key_ref = optional(object({
      name = string
      key  = string
    }))
  }))
  default = []
}

variable "name_prefix" {
  description = "Prefix name of the frontend service"
}

# variable "service_account_email" {
#   description = "Service account email for the Cloud Run service"

# }

variable "vpc_network" {
  description = "The VPC network the connector belongs to"
}

variable "ip_range_vpc_connector" {
  description = "The IP CIDR range for the VPC connector."
}

variable "cloud_sql_instance_connection_name" {
  description = "Cloud SQL instance connection name"
  default     = null
}

variable "max_scale" {
  description = "Maximum number of instances for autoscaling"
  default     = null
}

variable "image" {
  description = "Container image for the Cloud Run service"
  default     = "us-docker.pkg.dev/cloudrun/container/hello:latest"
}

variable "resource_cpu" {
  description = "CPU resource limits for the container"
  default     = "1000m"
}

variable "resource_memory" {
  description = "Memory resource limits for the container"
  default     = "512Mi"
}

# list of roles to be assigned to the backend service account
variable "frontend_service_roles_list" {
  description = "List of all roles to be assigned to the frontend service account"
  type        = list(string)
  default = [
    "roles/run.invoker",
    "roles/secretmanager.secretAccessor",
  ]
}

variable "project_service" {}

data "google_project" "project" {
  project_id = var.project_id
}



variable "next_public_firebase_api_key" {
  description = "Firebase api key"
  default     = null
}

variable "next_public_firebase_auth_domain" {
  description = "Firebase auth domain"
  default     = null
}

variable "next_public_firebase_project_id" {
  description = "Firebase project id"
  default     = null
}

variable "next_public_firebase_messaging_sender_id" {
  description = "Firebase messaging sender id"
  default     = null
}

variable "next_public_firebase_storage_bucket" {
  description = "Firebase storage bucket"
  default     = null
}

variable "next_public_firebase_app_id" {
  description = "Firebase app id"
  default     = null
}

variable "use_secure_cookies" {
  description = "Use secure cookies"
  default     = "true" # TODO remove and place into tfvars
}

variable "github_ssh_key" {
  description = "Github ssh key for terraform"
  default     = null
}

variable "firebase_admin_client_email" {
  description = "Firebase admin client email"
  default     = null
}

variable "firebase_admin_private_key" {
  description = "Firebase admin private key"
  default     = null
}

variable "auth_cookie_name" {
  description = "Firebase auth cookie name"
  default     = null
}
variable "auth_cookie_signature_key_current" {
  description = "Firebase auth cookie signature key current"
  default     = null
}

variable "auth_cookie_signature_key_previous" {
  description = "Firebase auth cookie signature key previous"
  default     = null
}

variable "owner_client_id" {
  description = "Owner client id"
  default     = null
}

variable "owner_private_key" {
  description = "Owner private key"
  default     = null
}

variable "backend_api_key" {
  description = "Backend api key"
  default     = null
}

variable "environment" {
  description = "Environment"
  type        = string
}

variable "project_number" {
  description = "Project number"
  type        = string
}

variable "domain" {
  type = string

}

variable "ingress_control" {
  description = "Annotation for ignress"
  default     = "internal-and-cloud-load-balancing"
}

variable "base_ip_policy" {
  type = list(string)
}
