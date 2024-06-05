variable "region" {
  description = "The region where the production environment will be created"
  type        = string
  default     = "europe-west4"
}

variable "project_id" {
  description = "Google Cloud project ID"
  type        = string
}

variable "name_prefix" {
  description = "Prefix of the artifact repository"
  type        = string
}
