variable "region" {
  description = "The region where the production environment will be created"
  type        = string
  default     = "europe-west4"
}

variable "zone" {
  type    = string
  default = "europe-west4-a"
}

variable "project_id" {
  description = "Google Cloud project ID"
  type        = string
}

variable "environment" {
  description = "Environment"
  default     = "prod"
}

variable "project_number" {
  description = "Project number"
  type        = string
}

variable "tf_service_account" {
  type = string
}

variable "next_public_firebase_api_key" {
  description = "Firebase api key"
}

variable "next_public_firebase_auth_domain" {
  description = "Firebase auth domain"
}

variable "next_public_firebase_project_id" {
  description = "Firebase project id"
}

variable "next_public_firebase_messaging_sender_id" {
  description = "Firebase messaging sender id"
}

variable "next_public_firebase_storage_bucket" {
  description = "Firebase storage bucket"
}

variable "next_public_firebase_app_id" {
  description = "Firebase app id"
}

variable "use_secure_cookies" {
  description = "Use secure cookies"
  default     = "true" # TODO remove and place into tfvars
}

variable "github_ssh_key" {
  description = "Github ssh key for terraform"
}

variable "firebase_admin_client_email" {
  description = "Firebase admin client email"
}

variable "firebase_admin_private_key" {
  description = "Firebase admin private key"
  default     = null
}

variable "auth_cookie_name" {
  description = "Firebase auth cookie name"
}
variable "auth_cookie_signature_key_current" {
  description = "Firebase auth cookie signature key current"
}

variable "auth_cookie_signature_key_previous" {
  description = "Firebase auth cookie signature key previous"
}

variable "owner_client_id" {
  description = "Owner client id"
}

variable "owner_private_key" {
  description = "Owner private key"
}

variable "backend_api_key" {
  description = "Backend api key"
}
