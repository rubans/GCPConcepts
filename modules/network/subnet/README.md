# Google subnets

This module allows simple management of Google subnet

## Requirements

These sections describe requirements for using this module.

### Software

The following dependencies must be available:

- Terraform >=v0.12
- Terraform Provider for GCP plugin >=v2.0

## Example

Basic usage of this module is as follows:

```hcl
module "subnet" {
  source      = "../../../../subnet"
  project_id  = var.project_id
  env         = var.env
  prefix      = var.prefix
  tenant_name = var.tenant_name

  ip_cidr_range = "10.0.0.0/23"
  network_id    = module.vpc.network.id
  region        = "europe-west2"
  description   = "desc"

  secondary_ip_ranges_array = [
    {
      ip_cidr_range = "10.0.2.0/23"
      range_name    = "sec"
    },
    {
      ip_cidr_range = "10.0.4.0/23"
      range_name    = "sec2"
    },
  ]

  private_ip_google_access = false

  log_config_array = [
    {
      aggregation_interval = "INTERVAL_1_MIN"
      flow_sampling        = 0.5
      metadata             = "CUSTOM_METADATA"
    }
  ]
}
```
