resource "google_compute_network" "vpc_network" {
  name                    = "${var.name_prefix}-vpc-network"
  project                 = var.project_id
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "vpc_subnet" {
  name          = "${var.name_prefix}-subnet"
  project       = var.project_id
  region        = var.region
  ip_cidr_range = var.ip_cidr_range
  network       = google_compute_network.vpc_network.id
}
