# [Google Dataflow Terraform Module](https://registry.terraform.io/modules/terraform-google-modules/dataflow/google)

This module handles opiniated Dataflow job configuration and deployments.

The resources/services/activations/deletions that this module will create/trigger are:
- Create a  GCS bucket for temporary job data
- Create a Dataflow job

## Compatibility
This module is meant for use with Terraform 0.13. If you haven't


### Assumption
The module is made to be used with the template_gcs_path as the staging location.
Hence, one assumption is that, before using this module, you already have working Dataflow job template(s) in GCS staging location(s).

```hcl  
  module "dataflow" {
  source = "git::ssh://git@github.com/ps-gcp-foundation/modules//dataflow"
  
  version = "kindly_specify"
  project_id  = "<project_id>"
  job_name = "<kindly_specify>"
  on_delete = "cancel"
  zone = "<Kindly_specify>"
  max_workers = "<Kindly_specify>"
  template_gcs_path =  "gs://<path-to-template>"
  temp_gcs_location = "gs://<gcs_path_temp_data_bucket"
  parameters = {
      dataflow = "example string"
        Jobs = <Kindly specify>
  }
}
```

Then perform the following commands on the root folder:

- `terraform init` to get the plugins
- `terraform plan` to see the infrastructure plan
- `terraform apply` to apply the infrastructure build
- `terraform destroy` to destroy the built infrastructure


<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| ip\_configuration | The configuration for VM IPs. Options are 'WORKER\_IP\_PUBLIC' or 'WORKER\_IP\_PRIVATE'. | `string` | `null` | no |
| kms\_key\_name | The name for the Cloud KMS key for the job. Key format is: projects/PROJECT\_ID/locations/LOCATION/keyRings/KEY\_RING/cryptoKeys/KEY | `string` | `null` | no |
| machine\_type | The machine type to use for the job. | `string` | `""` | no |
| max\_workers | The number of workers permitted to work on the job. More workers may improve processing speed at additional cost. | `number` | `1` | no |
| name | The name of the dataflow job | `string` | n/a | yes |
| network\_self\_link | The network self link to which VMs will be assigned. | `string` | `"default"` | no |
| on\_delete | One of drain or cancel. Specifies behavior of deletion during terraform destroy. The default is cancel. | `string` | `"cancel"` | no |
| parameters | Key/Value pairs to be passed to the Dataflow job (as used in the template). | `map(string)` | `{}` | no |
| project\_id | The project in which the resource belongs. If it is not provided, the provider project is used. | `string` | n/a | yes |
| region | The region in which the created job should run. Also determines the location of the staging bucket if created. | `string` | `"us-central1"` | no |
| service\_account\_email | The Service Account email that will be used to identify the VMs in which the jobs are running | `string` | `""` | no |
| subnetwork\_self\_link | The subnetwork self link to which VMs will be assigned. | `string` | `""` | no |
| temp\_gcs\_location | A writeable location on GCS for the Dataflow job to dump its temporary data. | `string` | n/a | yes |
| template\_gcs\_path | The GCS path to the Dataflow job template. | `string` | n/a | yes |
| zone | The zone in which the created job should run. | `string` | `"us-central1-a"` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The unique Id of the newly created Dataflow job |
| name | The name of the dataflow job |
| state | The state of the newly created Dataflow job |
| temp\_gcs\_location | The GCS path for the Dataflow job's temporary data. |
| template\_gcs\_path | The GCS path to the Dataflow job template. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Requirements

Before this module can be used on a project, you must ensure that the following pre-requisites are fulfilled:

1. Terraform is [installed](#software-dependencies) on the machine where Terraform is executed.
2. The Service Account you execute the module with has the right [permissions](#configure-a-service-account).
3. The necessary APIs are [active](#enable-apis) on the project.
4. A working Dataflow template in uploaded in a GCS bucket

The [project factory](https://github.com/terraform-google-modules/terraform-google-project-factory) can be used to provision projects with the correct APIs active.

### Software Dependencies
### Terraform
- [Terraform](https://www.terraform.io/downloads.html) >= 0.13.0
- [terraform-provider-google](https://github.com/terraform-providers/terraform-provider-google) plugin v2.18.0

### Configure a Service Account to execute the module

In order to execute this module you must have a Service Account with the
following project roles:

- roles/dataflow.admin
- roles/iam.serviceAccountUser
- roles/storage.admin

### Configure a Controller Service Account to create the job

If you want to use the service_account_email input to specify a service account that will identify the VMs in which the jobs are running, the service account will need the following project roles:

- roles/dataflow.worker
- roles/storage.objectAdmin

### Configure a Customer Managed Encryption Key

If you want to use [Customer Managed Encryption Keys](https://cloud.google.com/kms/docs/cmek) in the [Dataflow Job](https://cloud.google.com/dataflow/docs/guides/customer-managed-encryption-keys) use the variable `kms_key_name` to provide a valid key.
Follow the instructions in [Granting Encrypter/Decrypter permissions](https://cloud.google.com/dataflow/docs/guides/customer-managed-encryption-keys#granting_encrypterdecrypter_permissions) to configure the necessary roles for the Dataflow service accounts.

### Enable APIs

In order to launch a Dataflow Job, the Dataflow API must be enabled:

- Dataflow API - `dataflow.googleapis.com`
- Compute Engine API: `compute.googleapis.com`

**Note:** If you want to use a Customer Managed Encryption Key, the Cloud Key Management Service (KMS) API must be enabled:

- Cloud Key Management Service (KMS) API: `cloudkms.googleapis.com`
