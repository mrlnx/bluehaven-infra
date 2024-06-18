variable "project_id" {
  description = "Google Cloud project ID"
  type        = string
}

variable "region" {
  description = "The region where the frontend service will be created"
  type        = string
}
variable "name_prefix" {
  description = "Prefix of the name"
  type        = string
}

variable "tier" {
  description = "Database tier"

  type = string
}

variable "vpc_network" {
  description = "The VPC network the connector belongs to"
}

variable "instance_name" {
  description = "Name of the Cloud SQL instance"
  type        = string
}

variable "users" {
  description = "Map of database users and passwords"
  type        = map(string)
  default     = {}
}

variable "backend_db_roles_list" {
  description = "List of all roles to be assigned to the backend database service account"
  type        = list(string)
  default = [
    "roles/cloudsql.admin",
    "roles/cloudsql.instanceUser"
  ]
}

variable "project_number" {
  description = "Project number"
  type        = string
}

variable "project_service" {

}

variable "ip_range_vpc_connector" {
  description = "The IP CIDR range for the VPC connector."
}

variable "vpc_subnet" {

}

