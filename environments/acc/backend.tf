terraform {
  backend "gcs" {
    bucket                      = "bluehaven-infra-env-tf-state"
    prefix                      = "static.tfstate.d/acc"
    impersonate_service_account = "bluehaven-infra-env-tf-sa@bluehaven-infra-env.iam.gserviceaccount.com"
  }
}
