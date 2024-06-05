variable "project_id" {
  description = "Google Cloud project ID"
  type        = string
}

variable "name_prefix" {
  description = "Prefix of the name"

  type = string
}

variable "domains" {
  type = list(string)
}
