# Google IAM Service Account

This module allows simple management of Google IAM Service Account

## Usage

Basic usage of this module is as follows:

```hcl
module "gcp_database" {
  source  = "git::ssh://git@github.com/ps-gcp-foundation/modules//iam/service_account"
  
  account_id = "service_account"
  description = "details of service account"
  display_name = "NAME"
  project = "PROJECT"
  Roles = ["role1", "role2"]
}
```

## Requirements

These sections describe requirements for using this module.

### Software

The following dependencies must be available:

- Terraform >=v0.12
- Terraform Provider for GCP plugin >=v2.0

## Inputs

| Name          | Description                                                        | Type           | Default | Required |
|---------------|--------------------------------------------------------------------|----------------|---------|----------|
| account\_id   | The name of the service account                                    | `string`       | n/a     | yes      |
| description   | A description of the service account                               | `string`       | n/a     | yes      |
| display\_name | The display name for the service account                           | `string`       | n/a     | yes      |
| keys          | Generate keys?                                                     | `bool`         | `false` | no       |
| project       | The project to create the service account in                       | `any`          | n/a     | yes      |
| roles         | A list of the roles the service account should have in the project | `list(string)` | n/a     | yes      |

## Outputs

| Name    | Description |
|---------|-------------|
| account | n/a         |
| keys    | n/a         |
