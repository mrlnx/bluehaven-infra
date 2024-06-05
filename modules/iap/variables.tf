variable "project_id" {
  description = "Google Cloud project ID"
  type        = string
}

variable "iap_allowed_members" {
  type    = list(string)
  default = []
}

variable "region" {
  description = "The region where the production environment will be created"
  type        = string
  default     = "europe-west4"
}

variable "service" {
}

variable "domain" {
  type = string
}

variable "environment" {
  type = string
}
