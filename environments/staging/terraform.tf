terraform {
  required_version = "1.8.3"
  backend "gcs" {}
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.29.1"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.6.2"
    }
  }
}
