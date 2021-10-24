/**
 * Copyright 2019 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

variable "prefix" {
  description = "The string used to prefix resources within this folder. Considered to be the cost owner of all resources in said folder."
  type        = string
}

variable "project" {
  description = "The ID of the project in which the resource will be created. Considered the owner of the resources."
  type        = string
}

variable "env" {
  description = "The environment the resource is in"
  type        = string
}

variable "description" {
  description = "What the resource is for. Backend, frontend, etc"
  type        = string
}

variable "labels" {
  description = "Labels (in addition to the defaults)"
  type        = map(string)
  default     = {}
}

variable "region" {
  type = string
  description = "The region"
}

# DataProc cluster configuration
variable "staging_bucket" {
  type = string
  description = "The bucket to be used for staging"
}

variable "cluster_version" {
  type = string
  description = "The image version of DataProc to be used"
  default = ""
  #7) todo/provide the cluster_version
}

variable "master_instance_type" {
  type = string
  description = "The instance type of the master node"
  default = ""
  #8) todo/provide the master_instance_type
}

variable "master_disk_type" {
  type = string
  description = "The disk type of the primary disk attached to each master node. One of 'pd-ssd' or 'pd-standard'."
  default = ""
    #9) todo/provide the master_disk_type
}

variable "master_disk_size" {
  type = number
  description = "Size of the primary disk attached to each master node, specified in GB. The primary disk contains the boot volume and system libraries, and the smallest allowed disk size is 10GB. GCP will default to a predetermined computed value if not set (currently 500GB). Note: If SSDs are not attached, it also contains the HDFS data blocks and Hadoop working directories."
  default = 100
  #10) todo/provide the master_disk_size
}

variable "master_local_ssd" {
  type = number
  description = "The amount of local SSD disks that will be attached to each master cluster node."
  default = 0
   #11) todo/provide the master_local_ssd
}

variable "master_ha" {
  type = bool
  description = "Set to 'true' to enable 3 master nodes (HA) or 'false' for only 1 master node"
  default = false
   #12) todo/provide the master_ha (default is false)
}

variable "worker_instance_type" {
  type = string
  description = "The instance type of the worker nodes"
  default = ""
    #13) todo/provide the worker_instance_type

}

variable "primary_worker_min_instances" {
  type = number
  description = "The minimum number of primary worker instances"
  default = 2
  

}

variable "primary_worker_max_instances" {
  type = number
  description = "The maximum number of primary worker instances"
  default = 10
}

variable "preemptible_worker_instance_type" {
  type = string
  description = "The instance type of the secondary worker nodes"
  default = ""
  #14) todo/provide the primary_worker_min_instances
}

variable "preemptible_worker_min_instances" {
  type = number
  description = "The minimum number of secondary worker instances"
  default = 2
}

variable "preemptible_worker_max_instances" {
  type = number
  description = "The maximum number of secondary worker instances"
  default = 10
}

variable "worker_disk_type" {
  type = string
  description = "The disk type of the primary disk attached to each worker node. One of 'pd-ssd' or 'pd-standard'."
  default = ""
    #15) todo/provide the worker_disk_type
}

variable "worker_disk_size" {
  type = number
  description = "Size of the primary disk attached to each worker node, specified in GB. The primary disk contains the boot volume and system libraries, and the smallest allowed disk size is 10GB. GCP will default to a predetermined computed value if not set (currently 500GB). Note: If SSDs are not attached, it also contains the HDFS data blocks and Hadoop working directories."
  default = 100
}

variable "worker_accelerator" {
  type = list(object({
    count = number
    type = string
  }))
  description = "The number and type of the accelerator cards exposed to this instance. "
  default = []
}

variable "worker_local_ssd" {
  type = number
  description = "The amount of local SSD disks that will be attached to each worker cluster node."
  default = 0
}

variable "network" {
  type = string
  description = "The name or self_link of the Google Compute Engine network to the cluster will be part of. Conflicts with subnetwork. If neither is specified, this defaults to the 'default' network."
 default = {}
}

variable "service_account" {
  type = string
  description = "The service account for the cluster"
  #7) todo/provide ps designates service account
}

variable "zone" {
  type = string
  description = "The GCP zone where your data is stored and used"
  #8) todo/change inline with ps available zone standard
}

variable "scale_up_factor" {
  type = number
  description = "Fraction of average pending memory in the last cooldown period for which to add workers. A scale-up factor of 1.0 will result in scaling up so that there is no pending memory remaining after the update (more aggressive scaling). A scale-up factor closer to 0 will result in a smaller magnitude of scaling up (less aggressive scaling). Bounds: [0.0, 1.0]."
  default = 0.5
}

variable "scale_up_min_worker_fraction" {
  type = number
  description = " Minimum scale-up threshold as a fraction of total cluster size before scaling occurs. For example, in a 20-worker cluster, a threshold of 0.1 means the autoscaler must recommend at least a 2-worker scale-up for the cluster to scale. A threshold of 0 means the autoscaler will scale up on any recommended change. Bounds: [0.0, 1.0]"
  default = 0.0
}

variable "scale_down_factor" {
  type = number
  description = "Fraction of average pending memory in the last cooldown period for which to remove workers. A scale-down factor of 1 will result in scaling down so that there is no available memory remaining after the update (more aggressive scaling). A scale-down factor of 0 disables removing workers, which can be beneficial for autoscaling a single job. Bounds: [0.0, 1.0]."
  default = 1.0
}

variable "scale_down_min_worker_fraction" {
  type = number
  description = "Minimum scale-down threshold as a fraction of total cluster size before scaling occurs. For example, in a 20-worker cluster, a threshold of 0.1 means the autoscaler must recommend at least a 2 worker scale-down for the cluster to scale. A threshold of 0 means the autoscaler will scale down on any recommended change. Bounds: [0.0, 1.0]."
  default = 0.0
}

variable "cooldown_period" {
  type = string
  description = "Duration between scaling events. A scaling period starts after the update operation from the previous event has completed. Bounds: [2m, 1d]."
  default = "120s"
}

variable "graceful_decommission_timeout" {
  type = string
  description = "Timeout for YARN graceful decommissioning of Node Managers. Specifies the duration to wait for jobs to complete before forcefully removing workers (and potentially interrupting jobs). Only applicable to downscaling operations. Bounds: [0s, 1d]."
  default = "300s"
}

variable "conda_packages" {
  type = string
  description = "A space separated list of conda packages to be installed"
  default = ""
}

variable "pip_packages" {
  type = string
  description = "A space separated list of pip packages to be installed"
  default = ""
}

variable "conda_initialization_script" {
  type = string
  description = "Location of script in GS used to install conda packages (https://github.com/GoogleCloudPlatform/dataproc-initialization-actions)"
  default = "gs://dataproc-initialization-actions/python/conda-install.sh"
}

variable "pip_initialization_script" {
  type = string
  description = "Location of script in GS used to install pip packages (https://github.com/GoogleCloudPlatform/dataproc-initialization-actions)"
  default = "gs://dataproc-initialization-actions/python/pip-install.sh"
}

variable "initialization_script" {
  type = list(string)
  description = "List of additional initialization scripts"
  default = []
}

variable "initialization_timeout_sec" {
  type = number
  description = "The maximum duration (in seconds) which script is allowed to take to execute its action."
  default = 300
}

