# Create the Cloud SQL instance
data "google_sql_database_instance" "existing" {
  count   = var.create_instance ? 1 : 0
  name    = google_sql_database_instance.cloud_postgres_instance[0].name
  project = var.project_id
}
# Create a VPC network peering connection
resource "google_compute_global_address" "private_postgres_ip_address" {
  name          = "cloud-private-ip-address"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  project       = var.project_id
  prefix_length = 16
  network       = var.vpc_network.id
  count         = var.create_instance ? 1 : 0
}

resource "google_service_networking_connection" "private_postgres_vpc_connection" {
  network                 = var.vpc_network.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_postgres_ip_address[0].name]
  count                   = var.create_instance ? 1 : 0
}

# Create a Cloud SQL instance
resource "google_sql_database_instance" "cloud_postgres_instance" {
  name             = var.instance_name
  region           = var.region
  database_version = "POSTGRES_14"
  project          = var.project_id

  settings {
    tier = var.tier

    ip_configuration {
      private_network = var.vpc_network.id
      ipv4_enabled    = true
      # authorized_networks {
      #   name  = "Marlon"
      #   value = "89.99.38.119/32"
      # }
    }
  }

  deletion_protection = false
  depends_on          = [google_service_networking_connection.private_postgres_vpc_connection]
  count               = var.create_instance ? 1 : 0
}

# Create a database for the API service
resource "google_sql_database" "api_service_db" {
  name     = var.database
  instance = var.instance_name
  project  = var.project_id
}

# Create a user for the API service database
resource "google_sql_user" "api_service_db_user" {
  name     = "${var.name_prefix}-admin"
  project  = var.project_id
  password = data.google_secret_manager_secret_version_access.db_admin_password_access.secret_data
  instance = var.instance_name

  lifecycle {
    ignore_changes = [password]
  }
}

resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}
