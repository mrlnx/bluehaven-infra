variable "name_prefix" {
  description = "Prefix name of the cloud run contrainer"
  type        = string
}


variable "project_id" {
  description = "Google Cloud project ID"
  type        = string
}

variable "base_ip_policy" {
  type = list(string)
}
