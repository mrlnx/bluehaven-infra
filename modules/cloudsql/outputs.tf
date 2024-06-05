output "connection_name" {
  value = length(google_sql_database_instance.cloud_postgres_instance) > 0 ? google_sql_database_instance.cloud_postgres_instance[0].connection_name : ""
}

output "password" {
  value = var.create_instance ? google_sql_user.api_service_db_user.password : ""
}

output "user" {
  value = var.create_instance ? google_sql_user.api_service_db_user.name : ""
}

output "private_ip_address" {
  value = length(google_sql_database_instance.cloud_postgres_instance) > 0 ? google_sql_database_instance.cloud_postgres_instance[0].private_ip_address : ""
}

output "instance_name" {
  value = length(google_sql_database_instance.cloud_postgres_instance) > 0 ? google_sql_database_instance.cloud_postgres_instance[0].name : ""
}

output "service_name" {
  value = google_sql_database.api_service_db.name
}
