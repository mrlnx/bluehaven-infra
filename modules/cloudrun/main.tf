# create cloud run service
resource "google_cloud_run_service" "default" {
  name     = "${var.name_prefix}-cloudrun"
  location = var.region
  project  = var.project_id

  metadata {
    annotations = {
      "run.googleapis.com/ingress" = "internal-and-cloud-load-balancing"
    }
  }

  template {
    metadata {
      annotations = merge(
        {
          "run.googleapis.com/vpc-access-connector" = module.vpc_connector.id
          "run.googleapis.com/vpc-access-egress"    = "all-traffic"
        },
        var.max_scale != null ? { "autoscaling.knative.dev/maxScale" = var.max_scale } : {},
        var.cloud_sql_instance_connection_name != null ? { "run.googleapis.com/cloudsql-instances" = var.cloud_sql_instance_connection_name } : {}
      )
    }

    spec {
      service_account_name = var.service_account_email

      containers {
        # image = "${var.region}-docker.pkg.dev/${var.project_id}/api-services/backend-service:1.0"
        image = var.image

        resources {
          limits = var.resource_limits
        }

        dynamic "env" {
          for_each = var.env_variables
          content {
            name = env.value.name

            # Use value for non-secret environment variables
            value = lookup(env.value, "value", null)

            # Use value_from for secret environment variables
            dynamic "value_from" {
              for_each = env.value.secret_key_ref != null ? [env.value.secret_key_ref] : []
              content {
                secret_key_ref {
                  name = value_from.value.name
                  key  = value_from.value.key
                }
              }
            }
          }
        }
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}


module "vpc_connector" {
  source        = "../vpc_connector"
  name_prefix   = var.name_prefix
  region        = var.region
  ip_cidr_range = var.ip_range_vpc_connector
  network       = var.vpc_network
  project_id    = var.project_id
}
