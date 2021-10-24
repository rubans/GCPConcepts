<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 3.84.0 |
| <a name="provider_google-beta"></a> [google-beta](#provider\_google-beta) | 3.84.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_validate_naming_conventions"></a> [validate\_naming\_conventions](#module\_validate\_naming\_conventions) | ../../utils/naming_convention | n/a |
| <a name="module_validate_network_resource_type"></a> [validate\_network\_resource\_type](#module\_validate\_network\_resource\_type) | ../../utils/naming_convention/resource_type | n/a |

## Resources

| Name | Type |
|------|------|
| [google-beta_google_container_cluster.cluster](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_container_cluster) | resource |
| [google-beta_google_container_node_pool.cluster](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_container_node_pool) | resource |
| [google_compute_network.main](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_network) | resource |
| [google_compute_subnetwork.main](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_subnetwork) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_secondary_range"></a> [cluster\_secondary\_range](#input\_cluster\_secondary\_range) | GKE pod secondary range | `string` | `"gkepods"` | no |
| <a name="input_create_default_network"></a> [create\_default\_network](#input\_create\_default\_network) | Automatically create network for GKE | `bool` | `false` | no |
| <a name="input_enable_istio"></a> [enable\_istio](#input\_enable\_istio) | Whether to enable the istio addon | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment type | `string` | n/a | yes |
| <a name="input_horizontal_pod_autoscaling"></a> [horizontal\_pod\_autoscaling](#input\_horizontal\_pod\_autoscaling) | Whether to enable the horizontal pod autoscaling addon | `bool` | `true` | no |
| <a name="input_http_load_balancing"></a> [http\_load\_balancing](#input\_http\_load\_balancing) | Whether to enable http load balancing | `bool` | `true` | no |
| <a name="input_job"></a> [job](#input\_job) | Resource role functional job description | `string` | `""` | no |
| <a name="input_kms_key_name"></a> [kms\_key\_name](#input\_kms\_key\_name) | KMS key used for encryption of the data | `string` | `null` | no |
| <a name="input_machine_type"></a> [machine\_type](#input\_machine\_type) | Machine type to deploy in node pools | `string` | `"n1-standard-1"` | no |
| <a name="input_maintenance_policy"></a> [maintenance\_policy](#input\_maintenance\_policy) | maintenance policy | <pre>object({<br>    start_time   = string<br>    end_time     = string<br>    recurrence   = string<br>  })</pre> | `null` | no |
| <a name="input_master_authorized_networks_cidr_block"></a> [master\_authorized\_networks\_cidr\_block](#input\_master\_authorized\_networks\_cidr\_block) | CIDR range of the external networks to access the GKE masters | `string` | `"192.168.0.0/18"` | no |
| <a name="input_master_ipv4_cidr_block"></a> [master\_ipv4\_cidr\_block](#input\_master\_ipv4\_cidr\_block) | CIDR range to use for GKE masters | `string` | `"192.168.224.0/28"` | no |
| <a name="input_min_master_version"></a> [min\_master\_version](#input\_min\_master\_version) | Overwrite the minimum master version. Note: You cannot specify the version, only minimum version. | `string` | `null` | no |
| <a name="input_network"></a> [network](#input\_network) | GKE VPC self link | `string` | `null` | no |
| <a name="input_network_policy"></a> [network\_policy](#input\_network\_policy) | Enable network policy addon | `bool` | `true` | no |
| <a name="input_network_policy_provider"></a> [network\_policy\_provider](#input\_network\_policy\_provider) | The network policy provider. | `string` | `"CALICO"` | no |
| <a name="input_node_count"></a> [node\_count](#input\_node\_count) | Initial node count | `number` | `1` | no |
| <a name="input_node_networktags"></a> [node\_networktags](#input\_node\_networktags) | n/a | `list(string)` | `null` | no |
| <a name="input_node_pool_auto_upgrade"></a> [node\_pool\_auto\_upgrade](#input\_node\_pool\_auto\_upgrade) | Automatically upgrade node pools to newer versions | `bool` | `true` | no |
| <a name="input_pod_security_policy"></a> [pod\_security\_policy](#input\_pod\_security\_policy) | Enable pod security policies on the cluster | `bool` | `true` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Prefix attributed to client | `string` | n/a | yes |
| <a name="input_private_cluster"></a> [private\_cluster](#input\_private\_cluster) | Whether cluster is private | `bool` | `false` | no |
| <a name="input_private_endpoint"></a> [private\_endpoint](#input\_private\_endpoint) | Whether cluster is accessible private only | `bool` | `false` | no |
| <a name="input_project"></a> [project](#input\_project) | The project ID to create the resources in. | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | Region to deploy this pattern into | `string` | `null` | no |
| <a name="input_release_channel"></a> [release\_channel](#input\_release\_channel) | Specify the release channel. | `string` | `"STABLE"` | no |
| <a name="input_service_account"></a> [service\_account](#input\_service\_account) | Service account id to run the GKE node pool as | `string` | `null` | no |
| <a name="input_services_secondary_range"></a> [services\_secondary\_range](#input\_services\_secondary\_range) | GKE services secondary range prefix | `string` | `"gkeservices"` | no |
| <a name="input_subnetwork"></a> [subnetwork](#input\_subnetwork) | GKE Subnetwork self link | `string` | `null` | no |
| <a name="input_tenant_name"></a> [tenant\_name](#input\_tenant\_name) | Tenant Name usage for consumption | `string` | n/a | yes |
| <a name="input_vertical_pod_autoscaling"></a> [vertical\_pod\_autoscaling](#input\_vertical\_pod\_autoscaling) | Vertical Pod Autoscaling automatically adjusts the resources of pods controlled by it. | `bool` | `false` | no |
| <a name="input_zone"></a> [zone](#input\_zone) | Zone to deploy this pattern into | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_kubernetes_cluster_host"></a> [kubernetes\_cluster\_host](#output\_kubernetes\_cluster\_host) | GKE Cluster Host |
| <a name="output_kubernetes_cluster_name"></a> [kubernetes\_cluster\_name](#output\_kubernetes\_cluster\_name) | GKE Cluster Name |
<!-- END_TF_DOCS -->