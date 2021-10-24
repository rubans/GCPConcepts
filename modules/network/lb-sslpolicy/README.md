# Google LB-SSL Policy

This module allows simple management of Google LB-SSL Policy

## Requirements

These sections describe requirements for using this module.

### Software

The following dependencies must be available:

- Terraform >=v0.12
- Terraform Provider for GCP plugin >=v2.0

## Example

Basic usage of this module is as follows:

```hcl
module "lb-sslpolicy-webapp" {
  source     = "git::ssh://git@github.com/ps-gcp-foundation/modules//network/lb-sslpolicy"
  name       = "${var.app_name}-${var.ssl_policy_name_suffix}"
  project_id = module.project.project.project_id
}
```

## Inputs

| Name              | Description                                                                                                                                                                                          | Type           | Default     | Required |
|-------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------|-------------|----------|
| custom\_features  | specifies the set of SSL features that can be used by the load balancer when negotiating SSL with clients                                                                                            | `list(string)` | `[]`        | no       |
| min\_tls\_version | The minimum version of SSL protocol                                                                                                                                                                  | `string`       | `"TLS_1_2"` | no       |
| name              | Name of the SSL policy                                                                                                                                                                               | `string`       | n/a         | yes      |
| profile           | specifies the set of SSL features that can be used by the load balancer when negotiating SSL with clients.If using CUSTOM, the set of SSL features to enable must be specified in the customFeatures | `string`       | `"MODERN"`  | no       |
| project\_id       | id of the project                                                                                                                                                                                    | `string`       | n/a         | yes      |

## Outputs

| Name | Description        |
|------|--------------------|
| id   | Name of SSL Policy |
| name | Name of SSL Policy |

