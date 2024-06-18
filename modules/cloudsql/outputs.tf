output "connection_name" {
  value = google_sql_database_instance.cloud_postgres_instance.connection_name
}

output "password" {
  value = google_sql_user.api_service_db_user.password
}

output "user" {
  value = google_sql_user.api_service_db_user.name
}

output "private_ip_address" {
  value = google_sql_database_instance.cloud_postgres_instance.private_ip_address
}

output "instance_name" {
  value = google_sql_database_instance.cloud_postgres_instance.name
}

output "service_name" {
  value = google_sql_database.api_service_db.name
}
