# common
variable "project" {
  description = "The project ID to create the resources in."
  type        = string
}
variable "prefix" {
  description = "Prefix attributed to client"
  type        = string
}
variable "tenant_name" {
  description = "Tenant Name usage for consumption"
  type        = string
}
variable "environment" {
	type = string
	description = "Environment type"
}
variable "job" {
  description = "Resource role functional job description"
  type        = string
  default     = ""
}
variable "region" {
  type        = string
  description = "Region to deploy this pattern into"
  default     = null
}

variable "zone" {
  type        = string
  description = "Zone to deploy this pattern into"
  default     = null
}

variable "kms_key_name" {
  type        = string
  description = "KMS key used for encryption of the data"
  default     = null
}


##GKE##
variable "private_endpoint" {
  type        = bool
  description = "Whether cluster is accessible private only"
  default     = false
}
variable "private_cluster" {
  type        = bool
  description = "Whether cluster is private"
  default     = false
}
variable "node_count" {
  type        = number
  default     = 1
  description = "Initial node count"
}

variable "master_ipv4_cidr_block" {
  type        = string
  description = "CIDR range to use for GKE masters"
  default     = "192.168.224.0/28"
}

variable "master_authorized_networks_cidr_block" {
  type        = string
  description = "CIDR range of the external networks to access the GKE masters"
  default     = "192.168.0.0/18"
}

variable "service_account" {
  type        = string
  description = "Service account id to run the GKE node pool as"
  default     = null
}

variable "machine_type" {
  type        = string
  description = "Machine type to deploy in node pools"
  default     = "n1-standard-1"
}


variable "release_channel" {
  type        = string
  default     = "STABLE"
  description = "Specify the release channel."
}

variable "min_master_version" {
  type        = string
  default     = null
  description = "Overwrite the minimum master version. Note: You cannot specify the version, only minimum version."
}

variable "pod_security_policy" {
  type        = bool
  default     = true
  description = "Enable pod security policies on the cluster"
}

variable "node_pool_auto_upgrade" {
  type        = bool
  default     = true
  description = "Automatically upgrade node pools to newer versions"
}

# Network
variable "create_default_network" {
  type        = bool
  default     = false
  description = "Automatically create network for GKE"
}

variable "network" {
  type        = string
  description = "GKE VPC self link"
  default     = null
}

variable "subnetwork" {
  type        = string
  description = "GKE Subnetwork self link"
  default     = null
}

variable "cluster_secondary_range" {
  type        = string
  description = "GKE pod secondary range"
  default     = "gkepods"
}

variable "services_secondary_range" {
  type        = string
  description = "GKE services secondary range prefix"
  default     = "gkeservices"
}

variable "node_networktags" {
  type    = list(string)
  default = null
}

variable "network_policy" {
  type        = bool
  description = "Enable network policy addon"
  default     = true
}

variable "network_policy_provider" {
  type        = string
  description = "The network policy provider."
  default     = "CALICO"
}

variable "http_load_balancing" {
	type = bool 
	description = "Whether to enable http load balancing"
	default = true
}

variable "enable_istio" {
  description = "Whether to enable the istio addon"
  type        = bool
  default     = false
}

# maintenance policy
variable "maintenance_policy" {
  type = object({
    start_time   = string
    end_time     = string
    recurrence   = string
  })
  default = null
}

# gke scaling
variable "vertical_pod_autoscaling" {
  description = "Vertical Pod Autoscaling automatically adjusts the resources of pods controlled by it."
  type        = bool
  default     = false
}

variable "horizontal_pod_autoscaling" {
  description = "Whether to enable the horizontal pod autoscaling addon"
  type        = bool
  default     = true
}


