# Google storage for Redis

This module allows simple management of Google storage for Redis

## Requirements

These sections describe requirements for using this module.

### Software

The following dependencies must be available:

- Terraform >=v0.12
- Terraform Provider for GCP plugin >=v2.0

## Providers

| Name   | Version |
|--------|---------|
| google | n/a     |


## Inputs

| Name           | Description | Type     | Default | Required |
|----------------|-------------|----------|---------|----------|
| name           | n/a         | `string` | n/a     | yes      |
| network        | n/a         | `any`    | n/a     | yes      |
| project        | n/a         | `any`    | n/a     | yes      |
| redis\_configs | n/a         | `any`    | n/a     | yes      |
| region         | n/a         | `string` | n/a     | yes      |

## Outputs

No output.

