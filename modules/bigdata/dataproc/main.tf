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

resource "random_id" "suffix" {
  byte_length = 2
}

module "location" {
  source   = "../../utils/naming_convention/location"
  location = var.region
}

locals {
  location_abbr = module.location.abbr
  resource_abbr = "dpc"
  name          = lower("${var.prefix}-${var.project}-${var.env}-${var.description}-${local.location_abbr}-${local.resource_abbr}-${random_id.suffix.hex}")
  default_labels = {
    prefix             = var.prefix
    project            = var.project
    env                = var.env
    description        = var.description
    location           = local.location_abbr
  }
  labels = merge(local.default_labels, var.labels)
}

resource "google_dataproc_cluster" main {
  name   = local.name
  region = var.region

  labels = local.labels

  cluster_config {
    staging_bucket = var.staging_bucket
    software_config {
      image_version = var.cluster_version
    }

    gce_cluster_config {
      network = var.network
      service_account = var.service_account
      tags = [var.name]
      zone = var.zone
      metadata = {
        CONDA_PACKAGES = var.conda_packages
        PIP_PACKAGES = var.pip_packages
      }
    }
    master_config {
      num_instances = var.master_ha ? 3 : 1
      machine_type = var.master_instance_type
      disk_config {
        boot_disk_type = var.master_disk_type
        boot_disk_size_gb = var.master_disk_size
        num_local_ssds = var.master_local_ssd
      }
    }

    worker_config {
      machine_type = var.worker_instance_type
      disk_config {
        boot_disk_type = var.worker_disk_type
        boot_disk_size_gb = var.worker_disk_size
        num_local_ssds = var.worker_local_ssd
      }
      dynamic "accelerators" {
        for_each = var.worker_accelerator
        content {
          accelerator_count = accelerators.value.worker_accelerator.count
          accelerator_type = accelerators.value.worker_accelerator.type
        }
      }
    }
    preemptible_worker_config {
      num_instances = var.preemptible_worker_min_instances
    }
    autoscaling_config {
      policy_uri = google_dataproc_autoscaling_policy.asp.name
    }
  }
}


resource "google_dataproc_autoscaling_policy" "asp" {
  policy_id = "${local.name}-policy"
  location = var.region


  worker_config {
    min_instances = var.primary_worker_min_instances
    max_instances = var.primary_worker_max_instances
    weight = 1
  }

  secondary_worker_config {
    min_instances = var.preemptible_worker_min_instances
    max_instances = var.preemptible_worker_max_instances
    weight = 3
  }

  basic_algorithm {
    cooldown_period = var.cooldown_period
    yarn_config {
      graceful_decommission_timeout = var.graceful_decommission_timeout

      scale_up_factor   = var.scale_up_factor
      scale_up_min_worker_fraction = var.scale_up_min_worker_fraction
      scale_down_factor = var.scale_down_factor
      scale_down_min_worker_fraction = var.scale_down_min_worker_fraction
    }
  }
}
