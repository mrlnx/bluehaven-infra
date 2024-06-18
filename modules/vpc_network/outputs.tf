output "id" {
  value = google_compute_network.vpc_network.id
}

output "vpc_subnet" {
  value = google_compute_subnetwork.vpc_subnet
}
