resource "google_vpc_access_connector" "vpc_connector" {
  name          = "${var.name_prefix}-vpc-conn"
  project       = var.project_id
  region        = var.region
  ip_cidr_range = var.ip_cidr_range
  network       = var.network.id
}
