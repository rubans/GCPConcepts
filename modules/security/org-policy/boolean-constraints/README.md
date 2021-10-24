# Google Org-Policy for Boolean Constrainst

This module allows simple management of Google Org-Policy for Boolean Constraints.

## Requirements

These sections describe requirements for using this module.

### Software

The following dependencies must be available:

- Terraform >=v0.12
- Terraform Provider for GCP plugin >=v2.0

## Example

Basic usage of this module is as follows:

```hcl
module "org_policy" {
  source      = "git::ssh://git@github.com/ps-gcp-foundation/modules//org-policy/boolean-constraints"
  constraint  = "contraint"
  org_id      = "organization id"
}
```

## Inputs

| Name       | Description                | Type     | Default | Required |
|------------|----------------------------|----------|---------|----------|
| constraint | Boolean constraint details | `string` | n/a     | yes      |
| org\_id    | organization id            | `string` | n/a     | yes      |

## Outputs

No output.

