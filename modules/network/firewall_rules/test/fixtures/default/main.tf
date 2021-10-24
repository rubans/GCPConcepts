module "firewall" {
  source = "../../.."

  project             = var.project_id
  network             = google_compute_network.main.self_link
  prefix              = var.prefix
  tenant_name         = var.tenant_name
  env                 = var.env
  log_metadata_config = var.log_metadata_config
  allow_ingress       = var.allow_ingress
  deny_ingress        = var.deny_ingress
  allow_egress        = var.allow_egress
  deny_egress         = var.deny_egress
}
