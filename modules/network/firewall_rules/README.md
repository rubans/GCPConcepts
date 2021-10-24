# Google Cloud Firewall Rules

This module allows simple management of Google VPC firewall rules, supporting basic configurable rules for IP range-based intra-VPC and administrator ingress, tag-based SSH/HTTP/HTTPS ingress, and custom rule definitions.

The HTTP and HTTPS rules use the same network tags that are assigned to instances when the "Allow HTTP[S] traffic" checkbox is flagged in the Cloud Console. The SSH rule uses a generic ssh tag.

### Note
All IP source ranges are configurable through variable and Allowed protocols and/or ports for the intra-VPC rule are also configurable through a variable.

Custom rules are set through a map where keys are rule names, and values use this custom type:
## Requirements

These sections describe requirements for using this module.

### Software

The following dependencies must be available:

- Terraform >=v1.0.4

## Example

Basic usage of this module is as follows:

```hcl
module "firewall" {
  source = "../../../modules///network/firewall_rules"

  project     = var.project
  network     = var.network
  prefix      = var.prefix
  tenant_name = var.tenant_name

  allow_ingress = {
    backend_control = {
      description             = "Control plane between Velostrata Backend and Velostrata Manager"
      source_ranges           = null
      source_tags             = ["velostrata-backend"]
      source_service_accounts = null
      destination_ranges      = null
      target_tags             = ["velostrata-manager"]
      target_service_accounts = null
      disabled                = false
      priority                = 1000
      protocol                = "tcp"
      ports                   = null
    }
    nat_gateway = {
      description             = "Allow all ingress into nat gateway"
      source_ranges           = ["0.0.0.0/0"]
      source_tags             = null
      source_service_accounts = null
      destination_ranges      = ["10.0.0.10/32"]
      target_tags             = null
      target_service_accounts = null
      disabled                = false
      priority                = 1000
      protocol                = "tcp"
      ports                   = null
    }
  }

  deny_egress = {
    jenkins = {
      description             = "Stop the jenkins server from egressing to the nat gateway"
      source_ranges           = ["10.0.6.15/32"]
      source_tags             = ["jenkins"]
      source_service_accounts = null
      destination_ranges      = null
      target_tags             = ["nat-gateway"]
      target_service_accounts = null
      disabled                = false
      priority                = 1000
      protocol                = "tcp"
      ports                   = null
    }
  }
}
```
## Limitations

All values for each firewall rule must either be configured or set to null. This can change when optional types are no longer experimental terraform.
Source and/or target service accounts cannot be used with source and/or target tags. 
Inspec tests cannot test for denied ip ranges.
