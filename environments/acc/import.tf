import {
  id = "projects/bluehaven-infra-env/global/addresses/cloud-private-ip-address"
  to = module.backend_service_db.google_compute_global_address.private_postgres_ip_address
}

import {
  id = "projects/bluehaven-infra-env/global/networks/acc-vpc-network:servicenetworking.googleapis.com:cloud-private-ip-address"
  to = module.backend_service_db.google_service_networking_connection.private_postgres_vpc_connection
}

import {
  id = "projects/bluehaven-infra-env/instances/cloud-postgres-instance"
  to = module.backend_service_db.google_sql_database_instance.cloud_postgres_instance
}

