output "network" {
  value = google_compute_network.vpc
}

output "id" {
  value = google_compute_network.vpc.id
}
