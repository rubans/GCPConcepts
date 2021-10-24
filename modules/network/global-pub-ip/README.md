# Google Pub IP

This module allows simple management of Google Pub IP

## Requirements

These sections describe requirements for using this module.

### Software

The following dependencies must be available:

- Terraform >=v0.12
- Terraform Provider for GCP plugin >=v2.0

## Example

Basic usage of this module is as follows:

```hcl
module "global-pub-ip-webapp" {
  source  = "git::ssh://git@github.com/ps-gcp-foundation/modules//network/global-pub-ip"
  name    = "${var.app_name}-${var.global_ip_name_suffix}"
  project = var.project
}
```

## Inputs

| Name    | Description                          | Type     | Default | Required |
|---------|--------------------------------------|----------|---------|----------|
| name    | The namr of  the global public ip    | `string` | n/a     | yes      |
| project | The project for the global public ip | `string` | n/a     | yes      |


## Outputs

| Name | Description |
|------|-------------|
| id   | n/a         |
