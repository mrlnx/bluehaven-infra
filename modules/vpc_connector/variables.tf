variable "region" {
  description = "The region where the vpc connector will be created"
  type        = string
}

variable "name_prefix" {
  description = "Prefix of the the VPC connector"
  type        = string
}

variable "ip_cidr_range" {
  description = "The CIDR range for the VPC connector"
  type        = string
}

variable "network" {
  description = "The VPC network the connector belongs to"
}

variable "project_id" {
  description = "Google Cloud project ID"
  type        = string
}
