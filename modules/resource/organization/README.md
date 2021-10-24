# Resource organization

This module enables an existing organisation to be imported into the terraform stack. This provides access to the various organisation identifiers and enables organisation level IAM groups to be assigned roles. 


## Usage

Basic usage of this module is as follows:

```hcl
module "organization" {
  source = "git::ssh://git@github.com/ps-gcp-foundation/modules//resource/organization"
  domain = "example.com"
  iam_method    = "POLICY|BINDINGS|MEMBERS"
  iam_bindings  = { group : "gcp-organization-admins@example.com", roles : var.group_roles["gcp-organization-admins"] }
  audit_configs = {
    "allServices" = ["ADMIN_READ", "DATA_READ", "DATA_WRITE"]
  }
}
```

## Requirements

To use this module

### Software

The following dependencies must be available:

- Terraform >=v0.13
- Terraform Provider for GCP plugin >=v2.0

## Inputs

| Name          | Description                              | Type                | Default | Required |
|---------------|------------------------------------------|---------------------|---------|----------|
| domain        | The domain for the organisation          | `string`            | n/a     | yes      |
| iam_method    | Method to apply IAM bindings to resources| `string`            | MEMBER  | no       |
| iam_bindings  | Set of IAM bindings to apply             | `map(list(string))` | null    | no       |
| audit_configs | Management of audit config for an org    | `map(list(string))` | null    | no       |


## Outputs

| Name                  | Description                                           |
|-----------------------|-------------------------------------------------------|
| org_id                | The organisation identifier                           |
| name                  | The organisation name (organizations/{org_id})        |
| directory_customer_id | The google for work customer Id of the organisation   |
| create_time           | The timestamp when the organization was created       |
| lifecycle_state       | The organisations lifecycle state                     | 

