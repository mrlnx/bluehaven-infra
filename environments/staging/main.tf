provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}


resource "google_cloud_run_service" "default" {
  name     = "cloudrun-fe-service"
  location = var.region

  metadata {
    namespace = "ikhebgeencadeau_fe"
  }

  template {

    metadata {
      annotations = {
        "run.googleapis.com/vpc-access-egress" = "all-traffic"
      }
    }

    spec {
      containers {
        image = "us-docker.pkg.dev/cloudrun/container/hello"
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}

resource "google_cloud_run_domain_mapping" "default" {
  location = var.region
  name     = "ikhebgeencadeau.nl"

  metadata {
    namespace = "ikhebgeencadeau_fe"
  }

  spec {
    route_name = google_cloud_run_service.default.name
  }
}

resource "google_cloud_run_service_iam_member" "default_all_users" {
  service  = google_cloud_run_service.default.name
  location = google_cloud_run_service.default.location
  role     = "roles/run.invoker"
  member   = "allUsers"
}
