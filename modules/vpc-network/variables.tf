variable "region" {
  description = "The region where the subnet will be created"
  type        = string
}

variable "name_prefix" {
  description = "Prefix of the name"
  type        = string
}

variable "ip_cidr_range" {
  description = "The CIDR range for the subnet"
  type        = string
}

variable "project_id" {
  description = "Google Cloud project ID"
  type        = string
}
