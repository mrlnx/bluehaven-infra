resource "google_vpc_access_connector" "vpc_connector" {
  name          = "${var.name_prefix}-vc-${random_id.name.hex}"
  project       = var.project_id
  region        = var.region
  ip_cidr_range = var.ip_cidr_range
  network       = var.network.id

  lifecycle {
    create_before_destroy = true
  }
}
resource "random_id" "name" {
  byte_length = 3
}
