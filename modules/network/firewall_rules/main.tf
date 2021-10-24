module "naming" {
  source        = "../../utils/naming_convention"
  prefix        = var.prefix
  environment   = var.env
  resource_type = "google_compute_firewall"
  tenant_name   = var.tenant_name
}

locals {
  resource_type_abbr    = module.naming.resource_type_abbr
  environment_abbr      = module.naming.environment_abbr
  name_start            = "${var.prefix}-${var.tenant_name}-${local.environment_abbr}-${local.resource_type_abbr}"
  default_allow_ingress = {}
  default_deny_ingress = {
    default = {
      description             = "Block inbound traffic from everywhere."
      source_ranges           = ["0.0.0.0/0"]
      source_tags             = null
      source_service_accounts = null
      destination_ranges      = null
      target_tags             = null
      target_service_accounts = null
      disabled                = false
      priority                = 1000
      protocol                = "tcp"
      ports                   = null
    }
  }
  default_allow_egress = {}
  default_deny_egress = {
    default = {
      description             = "Block outbound traffic to everywhere."
      source_ranges           = null
      source_tags             = null
      source_service_accounts = null
      destination_ranges      = ["0.0.0.0/0"]
      target_tags             = null
      target_service_accounts = null
      disabled                = false
      priority                = 1000
      protocol                = "tcp"
      ports                   = null
    }
  }
  allow_ingress = merge(local.default_allow_ingress, var.allow_ingress)
  deny_ingress  = merge(local.default_deny_ingress, var.deny_ingress)
  allow_egress  = merge(local.default_allow_egress, var.allow_egress)
  deny_egress   = merge(local.default_deny_egress, var.deny_egress)
}

resource "google_compute_firewall" "allow_ingress" {
  for_each = local.allow_ingress

  name                    = lower("${local.name_start}-ai-${each.key}")
  description             = each.value.description
  direction               = "INGRESS"
  network                 = var.network
  project                 = var.project
  source_ranges           = each.value.source_ranges
  source_tags             = each.value.source_tags
  source_service_accounts = each.value.source_service_accounts
  destination_ranges      = each.value.destination_ranges
  target_tags             = each.value.target_service_accounts
  target_service_accounts = each.value.target_service_accounts
  disabled                = each.value.disabled
  priority                = each.value.priority

  log_config {
    metadata = var.log_metadata_config
  }

  allow {
    protocol = each.value.protocol
    ports    = each.value.ports
  }
}

resource "google_compute_firewall" "deny_ingress" {
  for_each = local.deny_ingress

  name                    = lower("${local.name_start}-di-${each.key}")
  description             = each.value.description
  direction               = "INGRESS"
  network                 = var.network
  project                 = var.project
  source_ranges           = each.value.source_ranges
  source_tags             = each.value.source_tags
  source_service_accounts = each.value.source_service_accounts
  destination_ranges      = each.value.destination_ranges
  target_tags             = each.value.target_service_accounts
  target_service_accounts = each.value.target_service_accounts
  disabled                = each.value.disabled
  priority                = each.value.priority

  log_config {
    metadata = var.log_metadata_config
  }

  deny {
    protocol = each.value.protocol
    ports    = each.value.ports
  }
}

resource "google_compute_firewall" "allow_egress" {
  for_each = local.allow_egress

  name                    = lower("${local.name_start}-ae-${each.key}")
  description             = each.value.description
  direction               = "EGRESS"
  network                 = var.network
  project                 = var.project
  source_ranges           = each.value.source_ranges
  source_tags             = each.value.source_tags
  source_service_accounts = each.value.source_service_accounts
  destination_ranges      = each.value.destination_ranges
  target_tags             = each.value.target_service_accounts
  target_service_accounts = each.value.target_service_accounts
  disabled                = each.value.disabled
  priority                = each.value.priority

  log_config {
    metadata = var.log_metadata_config
  }

  allow {
    protocol = each.value.protocol
    ports    = each.value.ports
  }
}

resource "google_compute_firewall" "deny_egress" {
  for_each = local.deny_egress

  name                    = lower("${local.name_start}-de-${each.key}")
  description             = each.value.description
  direction               = "EGRESS"
  network                 = var.network
  project                 = var.project
  source_ranges           = each.value.source_ranges
  source_tags             = each.value.source_tags
  source_service_accounts = each.value.source_service_accounts
  destination_ranges      = each.value.destination_ranges
  target_tags             = each.value.target_service_accounts
  target_service_accounts = each.value.target_service_accounts
  disabled                = each.value.disabled
  priority                = each.value.priority

  log_config {
    metadata = var.log_metadata_config
  }

  deny {
    protocol = each.value.protocol
    ports    = each.value.ports
  }
}
