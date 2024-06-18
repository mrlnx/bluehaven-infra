
variable "resource_limits" {
  description = "Resource limits for the container"
  type        = map(string)
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


variable "max_scale" {
  description = "Maximum number of instances for autoscaling"
  type        = string
  default     = null
}

variable "cloud_sql_instance_connection_name" {
  description = "Cloud SQL instance connection name"
  type        = string
  default     = null
}

variable "name_prefix" {
  description = "Prefix name of the cloud run contrainer"
  type        = string
}

variable "region" {
  description = "The region where the cloud run container will be created"
  type        = string
}


variable "project_id" {
  description = "Google Cloud project ID"
  type        = string
}

variable "service_account_email" {
  description = "Service account email for the Cloud Run service"
  type        = string
}

variable "image" {
  description = "Container image for the Cloud Run service"
  type        = string
}

variable "ip_range_vpc_connector" {
  description = "The IP CIDR range for the VPC connector."
  type        = string
}

variable "vpc_network" {
  description = "The VPC network the cloudrun container belongs to"
}

variable "ingress" {
  description = "Annotation for ignress"
  default     = "internal-and-cloud-load-balancing"
}
