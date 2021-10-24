#  Terraform Google Cloud Storage Module

This module makes it easy to create one or more GCS buckets, and assign basic permissions on them to arbitrary users.

The resources/services/activations/deletions that this module will create/trigger are:

- One or more GCS buckets
- Zero or more IAM bindings for those buckets

If you only wish to create a single bucket, consider using the
[simple bucket](modules/simple_bucket) submodule instead.

## Compatibility

 This module is meant for use with Terraform 0.12. If you haven't [upgraded](https://www.terraform.io/upgrade-guides/0-12.html)
  and need a Terraform 0.11.x-compatible version of this module, the last released version intended for
  Terraform 0.11.x is [0.1.0](https://registry.terraform.io/modules/terraform-google-modules/cloud-storage/google/0.1.0).

## Usage

Basic usage of this module is as follows:

```hcl
module "gcs_buckets" {
  source  = "git::ssh://git@github.com/ps-gcp-foundation/modules//storage/bucket"
  project_id  = "<PROJECT ID>"
  owner    = "itadmin"
  cost_centre     = "28838838338"
  dataclassification = "logs"
  names = ["first", "second"]
  prefix = "my-unique-prefix"
  set_admin_roles = true
  log_bucket = "LoggingBucketName"
  admins = ["group:foo-admins@example.com"]
  versioning = {
    first = true
  }
  retention_policy = {
    first = 10
  }
  bucket_admins = {
    second = "user:spam@example.com,eggs@example.com"
  }
}
```

Functional examples are included in the
[examples](./examples/) directory.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| admins | IAM-style members who will be granted roles/storage.objectAdmin on all buckets. | list(string) | `<list>` | no |
| bucket\_admins | Map of lowercase unprefixed name => comma-delimited IAM-style bucket admins. | map | `<map>` | no |
| bucket\_creators | Map of lowercase unprefixed name => comma-delimited IAM-style bucket creators. | map | `<map>` | no |
| bucket\_policy\_only | Disable ad-hoc ACLs on specified buckets. Defaults to true. Map of lowercase unprefixed name => boolean | map | `<map>` | no |
| bucket\_viewers | Map of lowercase unprefixed name => comma-delimited IAM-style bucket viewers. | map | `<map>` | no |
|owner| Mandatory owner label for the gcs bucket | string | `<string>` | yes |
|cost_centre| Mandatory cost_centre label for the gcs bucket | string | `<string>` | yes |
|dataclassification| Mandatory dataclassification label for the gcs bucket | string | `<string>` | yes |
|log_bucket| Name of logging bucket | string | `<string>` | no |
| cors | Map of maps of mixed type attributes for CORS values. See appropriate attribute types here: https://www.terraform.io/docs/providers/google/r/storage_bucket.html#cors | any | `<map>` | no |
| creators | IAM-style members who will be granted roles/storage.objectCreators on all buckets. | list(string) | `<list>` | no |
| encryption\_key\_names | Optional map of lowercase unprefixed name => string, empty strings are ignored. | map | `<map>` | no |
| folders | Map of lowercase unprefixed name => list of top level folder objects. | map | `<map>` | no |
| force\_destroy | Optional map of lowercase unprefixed name => boolean, defaults to false. | map | `<map>` | no |
| labels | Labels to be attached to the buckets | map | `<map>` | no |
| lifecycle\_rules | List of lifecycle rules to configure. Format is the same as described in provider documentation https://www.terraform.io/docs/providers/google/r/storage_bucket.html#lifecycle_rule except condition.matches_storage_class should be a comma delimited string. | object | `<list>` | no |
| location | Bucket location. | string | `"EU"` | no |
| names | Bucket name suffixes. | list(string) | n/a | yes |
| prefix | Prefix used to generate the bucket name. | string | n/a | yes |
| project\_id | Bucket project id. | string | n/a | yes |
| storage\_class | Bucket storage class. | string | `"MULTI_REGIONAL"` | no |
| versioning | Optional map of lowercase unprefixed name => boolean, defaults to false. | map | `<map>` | no |
|retention_policy | Mandatory map of  retention period in seconds | map | `<map>` | yes |
| viewers | IAM-style members who will be granted roles/storage.objectViewer on all buckets. | list(string) | `<list>` | no |
| website | Map of website values. Supported attributes: main_page_suffix, not_found_page | any | `<map>` | no |
| iam_method          | Method to apply IAM bindings to resources                  | `string`            | n/a     | no       |
| iam_bindings        | A map of members and roles to apply to the service account | `map(list(string))` | n/a     | no       |

## Outputs

| Name | Description |
|------|-------------|
| bucket | Bucket resource (for single use). |
| buckets | Bucket resources. |
| name | Bucket name (for single use). |
| names | Bucket names. |
| names\_list | List of bucket names. |
| url | Bucket URL (for single use). |
| urls | Bucket URLs. |
| urls\_list | List of bucket URLs. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Requirements

These sections describe requirements for using this module.

### Software

The following dependencies must be available:

- [Terraform][terraform] v0.12
  - For Terraform v0.11 see the [Compatibility](#compatibility) section above
- [Terraform Provider for GCP][terraform-provider-gcp] plugin v2.0

### Service Account

User or service account credentials with the following roles must be used to provision the resources of this module:

- Storage Admin: `roles/storage.admin`

The [Project Factory module][project-factory-module] and the
[IAM module][iam-module] may be used in combination to provision a
service account with the necessary roles applied.

### APIs

A project with the following APIs enabled must be used to host the
resources of this module:

- Google Cloud Storage JSON API: `storage-api.googleapis.com`

The [Project Factory module][project-factory-module] can be used to
provision a project with the necessary APIs enabled.

## Contributing

Refer to the [contribution guidelines](./CONTRIBUTING.md) for
information on contributing to this module.

[iam-module]: https://registry.terraform.io/modules/terraform-google-modules/iam/google
[project-factory-module]: https://registry.terraform.io/modules/terraform-google-modules/project-factory/google
[terraform-provider-gcp]: https://www.terraform.io/docs/providers/google/index.html
[terraform]: https://www.terraform.io/downloads.html

<!-- BEGIN_TF_DOCS -->
Copyright 2019 Google LLC

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

     http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 3.88.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_validate_naming_conventions"></a> [validate\_naming\_conventions](#module\_validate\_naming\_conventions) | ../../utils/naming_convention | n/a |

## Resources

| Name | Type |
|------|------|
| [google_storage_bucket.bucket](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket) | resource |
| [google_storage_bucket_iam_binding.admins](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_iam_binding) | resource |
| [google_storage_bucket_iam_binding.creators](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_iam_binding) | resource |
| [google_storage_bucket_iam_binding.viewers](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_iam_binding) | resource |
| [google_storage_project_service_account.storage_sa](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/storage_project_service_account) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket_admins"></a> [bucket\_admins](#input\_bucket\_admins) | List of bucket admins | `list` | `[]` | no |
| <a name="input_bucket_creators"></a> [bucket\_creators](#input\_bucket\_creators) | List of bucket creators | `list` | `[]` | no |
| <a name="input_bucket_logging"></a> [bucket\_logging](#input\_bucket\_logging) | Enables logging for the GCS bucket | <pre>object({<br>    log_bucket = string<br>  })</pre> | `null` | no |
| <a name="input_bucket_viewers"></a> [bucket\_viewers](#input\_bucket\_viewers) | List of bucket viewers | `list` | `[]` | no |
| <a name="input_cors"></a> [cors](#input\_cors) | Map of maps of mixed type attributes for CORS values. See appropriate attribute types here: https://www.terraform.io/docs/providers/google/r/storage_bucket.html#cors | `any` | `null` | no |
| <a name="input_data_classification"></a> [data\_classification](#input\_data\_classification) | The type of data stored in the bucket, either PUBLIC, DEFAULT or AUDIT. | `string` | `"DEFAULT"` | no |
| <a name="input_description"></a> [description](#input\_description) | What the resource is for. Backend, frontend, etc | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment type | `string` | n/a | yes |
| <a name="input_force_destroy"></a> [force\_destroy](#input\_force\_destroy) | Destroy the contents of the bucket when the bucket is deleted. | `bool` | `true` | no |
| <a name="input_iam_bindings"></a> [iam\_bindings](#input\_iam\_bindings) | Map of members with a list of roles for each member | `map(list(string))` | `{}` | no |
| <a name="input_iam_method"></a> [iam\_method](#input\_iam\_method) | IAM Binding method MEMBER\|BINDING\|POLICY | `string` | `"MEMBER"` | no |
| <a name="input_job"></a> [job](#input\_job) | Resource role functional job description | `string` | `""` | no |
| <a name="input_key_name"></a> [key\_name](#input\_key\_name) | The name of the encryption key used to encrypt the contents of the bucket | `string` | `null` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | Labels (in addition to the defaults) | `map(string)` | `{}` | no |
| <a name="input_lifecycle_rules"></a> [lifecycle\_rules](#input\_lifecycle\_rules) | List of lifecycle rules to configure. Format is the same as described in provider documentation https://www.terraform.io/docs/providers/google/r/storage_bucket.html#lifecycle_rule except condition.matches\_storage\_class should be a comma delimited string. | <pre>list(object({<br>    # Object with keys:<br>    # - type - The type of the action of this Lifecycle Rule. Supported values: Delete and SetStorageClass.<br>    # - storage_class - (Required if action type is SetStorageClass) The target Storage Class of objects affected by this Lifecycle Rule.<br>    action = map(string)<br><br>    # Object with keys:<br>    # - age - (Optional) Minimum age of an object in days to satisfy this condition.<br>    # - created_before - (Optional) Creation date of an object in RFC 3339 (e.g. 2017-06-13) to satisfy this condition.<br>    # - with_state - (Optional) Match to live and/or archived objects. Supported values include: "LIVE", "ARCHIVED", "ANY".<br>    # - matches_storage_class - (Optional) Comma delimited string for storage class of objects to satisfy this condition. Supported values include: MULTI_REGIONAL, REGIONAL, NEARLINE, COLDLINE, STANDARD, DURABLE_REDUCED_AVAILABILITY.<br>    # - num_newer_versions - (Optional) Relevant only for versioned objects. The number of newer versions of an object to satisfy this condition.<br>    condition = map(string)<br>  }))</pre> | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | The location of the storage bucket. | `string` | `"EU"` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | The string used to prefix resources within this folder. Considered to be the cost owner of all resources in said folder. | `string` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | The ID of the project in which the storage bucket will be created. Considered the owner of the resources. | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | Region to deploy this pattern into | `string` | `null` | no |
| <a name="input_retention_policy_enabled"></a> [retention\_policy\_enabled](#input\_retention\_policy\_enabled) | Enables the bucket retention policy. Off by default | `bool` | `false` | no |
| <a name="input_storage_class"></a> [storage\_class](#input\_storage\_class) | The storage class of the storage bucket. | `string` | `"STANDARD"` | no |
| <a name="input_tenant_name"></a> [tenant\_name](#input\_tenant\_name) | Tenant Name usage for consumption | `string` | n/a | yes |
| <a name="input_versioning_enabled"></a> [versioning\_enabled](#input\_versioning\_enabled) | Enables versioning of objects within the bucket. Off by default | `bool` | `false` | no |
| <a name="input_website"></a> [website](#input\_website) | Map of website values. Supported attributes: main\_page\_suffix, not\_found\_page | `any` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bucket"></a> [bucket](#output\_bucket) | Bucket resource |
| <a name="output_console_link"></a> [console\_link](#output\_console\_link) | The console link to the destination storage bucket |
| <a name="output_name"></a> [name](#output\_name) | Bucket name |
| <a name="output_storage_default_service_account_email"></a> [storage\_default\_service\_account\_email](#output\_storage\_default\_service\_account\_email) | The email address of the default storage service account. Needed for key permissions. |
| <a name="output_url"></a> [url](#output\_url) | Bucket URL |
<!-- END_TF_DOCS -->