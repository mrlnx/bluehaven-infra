variable "region" {
  description = "The region where the api service will be created"

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
  description = "Prefix name of the api service"
  type        = string
}

variable "vpc_network" {
  description = "The VPC network the connector belongs to"
}

variable "ip_range_vpc_connector" {
  description = "The IP CIDR range for the VPC connector."

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

variable "environment" {
  description = "Environment"
  type        = string
}

locals {
  description  = "URL of the backend database"
  database_url = "postgres://${var.db_connection.user}:${var.db_connection.password}@${var.db_connection.private_ip_address}/${var.db_connection.service_name}?sslaccept=strict&connect_timeout=300&host=/cloudsql/${var.project_id}:${var.region}:${var.db_connection.instance_name}"
}

variable "backend_roles_list" {
  description = "List of all roles to be assigned to the backend service account"
  type        = list(string)
  default = [
    "roles/run.invoker",
    "roles/secretmanager.secretAccessor",
    "roles/cloudsql.client",
    "roles/cloudsql.instanceUser",
    "roles/cloudsql.viewer",
    "roles/cloudsql.admin"
  ]
}

variable "project_number" {
  description = "Project number"
  type        = string
}

variable "project_service" {

}

variable "db_connection" {}
