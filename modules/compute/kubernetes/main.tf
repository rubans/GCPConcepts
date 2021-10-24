# common naming convention based resource name related dependencies
module "validate_naming_conventions" {
  source                = "../../utils/naming_convention"
  prefix                = var.prefix         
  environment           = var.environment
  resource_type         = "google_container_cluster"
  tenant_name           = var.tenant_name
  location              = var.region
}
# kubernetes cluster
locals {
  environment_abbr          = module.validate_naming_conventions.environment_abbr
  suffix                    = module.validate_naming_conventions.suffix
  location_abbr             = module.validate_naming_conventions.location_abbr
  resource_type_abbr        = module.validate_naming_conventions.resource_type_abbr
  job_tag                   = "${var.job != "" ? concat("-",var.job) : ""}"
  location_tag              = "${local.location_abbr != "" ? "-${local.location_abbr}" : ""}"
  resource_name_template    = "${var.prefix}-${var.tenant_name}-${local.environment_abbr}-%s%s%s-${local.suffix}"
  gke_cluster_name          = format(local.resource_name_template,local.resource_type_abbr,local.location_tag,local.job_tag)
}

resource "google_container_cluster" "cluster" {
  provider = google-beta
  project  = var.project
  name     = local.gke_cluster_name
  location = "${var.zone != null ? var.zone : var.region}"
  depends_on = [resource.google_compute_network.main,resource.google_compute_subnetwork.main]
  resource_labels = {"env" = "${var.environment}"}
  release_channel {
    channel = var.release_channel
  }
  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  #Due to firewalls blocking connections outbound from the default pool use a pool of 0 nodes
  #Name is "default-pool" so provider can find it when deleting
  node_pool {
    name               = "default-pool"
    initial_node_count = 0

  }
  # maintentance policy 
  dynamic "maintenance_policy" {
    for_each = var.maintenance_policy != null ? [1] : []
    content {
      recurring_window {
          start_time = lookup(var.maintenance_policy, "start_time")
          end_time = lookup(var.maintenance_policy, "end_time")
          recurrence = lookup(var.maintenance_policy, "recurrence")
      }
    }
  }

  ## Security settings
  master_auth {
    client_certificate_config {
      issue_client_certificate = true
    }
  }

  
  pod_security_policy_config {
    enabled = var.pod_security_policy
  }

  enable_shielded_nodes = true

  # use latest version, unless a specific version requested
  min_master_version = var.min_master_version
  # private cluster config
  private_cluster_config {
    enable_private_endpoint = var.private_endpoint
    enable_private_nodes    = var.private_cluster
    master_ipv4_cidr_block  = "${var.private_cluster ? var.master_ipv4_cidr_block : null}"
  }
  dynamic "master_authorized_networks_config" {
    for_each = var.private_cluster ? [1] : []
    content {
      cidr_blocks {
        cidr_block   = var.master_authorized_networks_cidr_block
        display_name = "private network"
      }
    }
  }
  #workload identity config
  workload_identity_config {
    identity_namespace = "${var.project}.svc.id.goog"
  }

  ## Network settings
  network                     = var.network == null ? google_compute_network.main[0].name : var.network 
  subnetwork                  = var.subnetwork == null ? google_compute_subnetwork.main[0].name : var.subnetwork
  enable_intranode_visibility = true

  # use vpc-native
  ip_allocation_policy {
    cluster_secondary_range_name  = "${var.cluster_secondary_range}"
    services_secondary_range_name = "${var.services_secondary_range}"
  }
  

  network_policy {
    enabled  = var.network_policy
    provider = var.network_policy_provider
  }

  addons_config {
		http_load_balancing {
      disabled = !var.http_load_balancing
    }

    horizontal_pod_autoscaling {
      disabled = !var.horizontal_pod_autoscaling
    }

    network_policy_config {
      disabled = !var.network_policy
    }

    istio_config {
      disabled = ! var.enable_istio
    }
  }

  vertical_pod_autoscaling {
    enabled = var.vertical_pod_autoscaling
  }


  ## Required to stop incorrect rebuilding of cluster
  lifecycle {
    ignore_changes = [node_pool, initial_node_count, resource_labels]
  }

  # database encryption
  database_encryption {
    state = "${var.kms_key_name == null ?   "DECRYPTED" : "ENCRYPTED"}"
    key_name = "${var.kms_key_name == null ?   null : var.kms_key_name}"
  }
}

# node pool
resource "google_container_node_pool" "cluster" {
  name     = google_container_cluster.cluster.name
  project  = var.project
  location = google_container_cluster.cluster.location
  provider = google-beta
  
  node_count = var.node_count
  cluster    = google_container_cluster.cluster.name

  management {
    auto_repair = true
    auto_upgrade = var.node_pool_auto_upgrade
  }
  
  node_config {
    disk_size_gb = 20
    machine_type = var.machine_type
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
    service_account = var.service_account
    tags            = var.node_networktags
    image_type        = "COS"
    disk_type         = "pd-standard"
    boot_disk_kms_key = "${var.kms_key_name == null ?   null : var.kms_key_name}"
    shielded_instance_config {
      enable_secure_boot = true
      enable_integrity_monitoring = true
    }
    workload_metadata_config {
      mode = "GKE_METADATA"
    }
  }

  timeouts {
    create = "15m"
    update = "15m"
    delete = "15m"
  }

  upgrade_settings {
    max_surge       = 1
    max_unavailable = 0
  }
}