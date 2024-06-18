terraform {
  required_version = "1.8.5"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.29.1"
    }

    google-beta = {
      source  = "hashicorp/google-beta"
      version = "~>4"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.6.2"
    }
  }
}
