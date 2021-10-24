# Google Cloud Armor Module
This module allows simple management of Google Armor
NB: When CloudArmor is enabled by default, it already comes with a set of preconfigured rules => https://cloud.google.com/armor/docs/rule-tuning#preconfigured_rules
```bash
gcloud compute security-policies list-preconfigured-expression-sets
```

## Requirements
These sections describe requirements for using this module.
### Software
The following dependencies must be available:
- Terraform >=v0.12
- Terraform Provider for GCP plugin >=v2.0
## Example
Basic usage of this module is as follows:  
```hcl
module "cloud_armor" {
  source      = "git::ssh://git@github.com/ps-gcp-foundation/modules//network/cloudarmor"
  project_id  = module.project.project.project_id
  cloud_armor = {
    "gcplb-all-allow-default-deny" = {
      "description" = "Allow all the communication with default deny"
      "versioned_expr" = [
        {
          "action"              = "allow"
          "priority"            = "1000"
          "rule_description"    = "Rule to allow all IP Range"
          "src_ip_ranges"       = ["*", ]
          "versioned_expr_name" = "SRC_IPS_V1"
        },
        {
          "action"              = "deny(403)"
          "priority"            = "2147483647"
          "rule_description"    = "Rule to Deny all IP Range"
          "src_ip_ranges"       = ["*", ]
          "versioned_expr_name" = "SRC_IPS_V1"
        }
      ]
      "expr" = []
    }
```
## Inputs
| Name         | Description                                | Type     | Default | Required|
|--------------|--------------------------------------------|----------|---------|---------|
| cloud\_armor | Cloud armor   policy coinfugation          | `map`    | n/a     | yes     |
| project\_id  | The project ID to create the resources in. | `string` | n/a     | yes     |
## Outputs
| Name                   | Description                 |
|------------------------|-----------------------------|
| cloud\_armor\_policies | Map of cloud armor policies |