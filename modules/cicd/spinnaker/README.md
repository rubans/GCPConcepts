# Google platform for Spinnaker

This module allows simple management of Google platform for Spinnaker on a kubernetes cluster

## Requirements

These sections describe requirements for using this module.

### Software

The following dependencies must be available:

- Terraform >=v0.12
- Terraform Provider for GCP plugin >=v2.0

## Inputs

| Name                  | Description                                                 | Type     | Default         | Required |
|-----------------------|-------------------------------------------------------------|----------|-----------------|----------|
| namespace             | The namespace for the spinnaker deployment                  | `string` | `"spinnaker"`   | no       |
| project               | The project where the spinnaker instance is deployed        | `any`    | n/a             | yes      |
| service\_account\_key | The google service account key for this spinnaker instance  | `any`    | n/a             | yes      |
| spinnaker\_k8s\_sa    | The kubernetes service account for the spinnaker deployment | `string` | `"spinnakersa"` | no       |
| spinnaker\_version    | The version of spinnaker deployed                           | `string` | `"1.19.12"`     | no       |
| storage\_bucket       | The storage bucket for the spinnaker instance               | `any`    | n/a             | yes      |

## Outputs

No output.

