# Google IAM User Account

This module allows simple management of Google IAM User Account

## Usage

Basic usage of this module is as follows:

```hcl
module "account_owners" {
  source = "git::ssh://git@github.com/ps-gcp-foundation/modules//iam/user_account"

  project = "project"
  role    = "roles/owner"
  members = ["owners"]
}
```

## Requirements

These sections describe requirements for using this module.

### Software

The following dependencies must be available:

- Terraform >=v0.12
- Terraform Provider for GCP plugin >=v2.0

## Inputs

| Name    | Description                                 | Type           | Default | Required |
|---------|---------------------------------------------|----------------|---------|----------|
| members | The list of members to be assigned the role | `list(string)` | n/a     | yes      |
| project | The project to add members to               | `any`          | n/a     | yes      |
| role    | The role members should be assigned         | `string`       | n/a     | yes      |

## Outputs

No output.

