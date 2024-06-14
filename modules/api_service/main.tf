module "artifact_repository" {
  source      = "../artifacts"
  name_prefix = var.name_prefix
  project_id  = var.project_id
  region      = var.region
}

module "api_service" {
  # recourse data
  source      = "../cloudrun"
  region      = var.region
  project_id  = var.project_id
  name_prefix = var.name_prefix

  # template metadata annotations
  max_scale                          = var.max_scale                     # optional
  cloud_sql_instance_connection_name = var.db_connection.connection_name # optional

  # service accounts
  service_account_email = google_service_account.api_service_sa.email

  # container data
  image = var.image

  resource_limits = {
    cpu    = var.resource_cpu
    memory = var.resource_memory
  }

  # environmental variables
  env_variables = [
    {
      name  = "NODE_ENV"
      value = var.environment
    },
    {
      name  = "FRONTEND_GATEWAY_URL"
      value = "https://levenscirkels.nl"
    },
    {
      name  = "API_GATEWAY_URL"
      value = "https://localhost:8443"
    },
    {
      name  = "PRISMA_SCHEMA"
      value = "./src/prisma/schema.prisma"
    },
    {
      name  = "ENVIRONMENT"
      value = var.environment
    },
    {
      name  = "PROJECT_ID"
      value = var.project_id
    },
    {
      name = "DATABASE_URL"
      secret_key_ref = {
        name = google_secret_manager_secret.database_url.secret_id
        key  = google_secret_manager_secret_version.database_url_version.version
      }
    },
  ]

  # VPC connector
  ip_range_vpc_connector = var.ip_range_vpc_connector
  vpc_network            = var.vpc_network
}
