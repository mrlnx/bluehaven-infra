terraform {
  backend "gcs" {
    bucket                      = "bluehaven-new-infra-8-tf-state"
    prefix                      = "static.tfstate.d/acc"
    impersonate_service_account = "bluehaven-new-infra-8-tf-sa@bluehaven-new-infra-8.iam.gserviceaccount.com"
  }
}
