<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.53 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.53 |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_sg-fsx-ontap"></a> [sg-fsx-ontap](#module\_sg-fsx-ontap) | git::https://git@github.com/ucopacme/terraform-aws-security-group.git// | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_fsx_ontap_file_system.fsx-ontap](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/fsx_ontap_file_system) | resource |
| [aws_fsx_ontap_storage_virtual_machine.svm](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/fsx_ontap_storage_virtual_machine) | resource |
| [aws_fsx_ontap_volume.volume](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/fsx_ontap_volume) | resource |
| [aws_route53_record.fs_intercluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_record.fs_management](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_record.svm_iscsi](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_record.svm_management](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_record.svm_nfs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_zone.fsx](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_zone) | resource |
| [aws_secretsmanager_secret.fsx-ontap-password](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret_version.fsx-ontap-password](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version) | resource |
| [random_password.fsx-ontap-password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [aws_secretsmanager_secret_version.fsx-ontap-password](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/secretsmanager_secret_version) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster-name"></a> [cluster-name](#input\_cluster-name) | Name of the cluster | `string` | n/a | yes |
| <a name="input_fs-backup-start-time"></a> [fs-backup-start-time](#input\_fs-backup-start-time) | Daily automatic backup start time for the FSx ONTAP file system | `string` | `"02:00"` | no |
| <a name="input_fs-deployment-type"></a> [fs-deployment-type](#input\_fs-deployment-type) | Deployment type for the FSx ONTAP file system | `string` | `"SINGLE_AZ_1"` | no |
| <a name="input_fs-maintenance-start-time"></a> [fs-maintenance-start-time](#input\_fs-maintenance-start-time) | Weekly maintenance start time for the FSx ONTAP file system | `string` | `"7:11:00"` | no |
| <a name="input_fs-retention-days"></a> [fs-retention-days](#input\_fs-retention-days) | Automatic backup retention days for the FSx ONTAP file system | `number` | `30` | no |
| <a name="input_fs-ssd-capacity-gb"></a> [fs-ssd-capacity-gb](#input\_fs-ssd-capacity-gb) | Storage capacity for the FSx ONTAP file system, in GigaBytes. This cannot be shrunk, only grown. | `number` | `1024` | no |
| <a name="input_fs-ssd-throughput-mbps"></a> [fs-ssd-throughput-mbps](#input\_fs-ssd-throughput-mbps) | Throughput capacity for the FSx ONTAP file system | `number` | `128` | no |
| <a name="input_preferred-subnet-id"></a> [preferred-subnet-id](#input\_preferred-subnet-id) | Preferred Subnet ID to use for the FSx ONTAP file system | `string` | n/a | yes |
| <a name="input_sg-cidrs"></a> [sg-cidrs](#input\_sg-cidrs) | CIDRs to allow in the security group | `list(string)` | `[]` | no |
| <a name="input_subnet-ids"></a> [subnet-ids](#input\_subnet-ids) | Subnet IDs to use for the FSx ONTAP file system | `list(string)` | n/a | yes |
| <a name="input_svm-volume-map"></a> [svm-volume-map](#input\_svm-volume-map) | Map of SVM names to volume names. Top level configurations are for SVMs, nested configurations are for volumes. | `any` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to all resources | `map(string)` | <pre>{<br>  "createdBy": "terraform"<br>}</pre> | no |
| <a name="input_vpc-id"></a> [vpc-id](#input\_vpc-id) | VPC ID to use for the FSx ONTAP file system | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_fsx_admin_password_location"></a> [fsx\_admin\_password\_location](#output\_fsx\_admin\_password\_location) | Where to find the default password to start interacting with the filer. |
| <a name="output_fsx_fs_intercluster_ips"></a> [fsx\_fs\_intercluster\_ips](#output\_fsx\_fs\_intercluster\_ips) | IPs for the intercluster LIFs on the filer. |
| <a name="output_fsx_fs_management_ip"></a> [fsx\_fs\_management\_ip](#output\_fsx\_fs\_management\_ip) | If the DNS doesn't work, this is the IP for the filer management interface. |
| <a name="output_route53_records"></a> [route53\_records](#output\_route53\_records) | Map of all DNS records created for all resources in this module. |
<!-- END_TF_DOCS -->

## Example
```
locals {
  name = join("-", [local.tags.application, local.tags.environment, "fsx-test-2"])

  cidrs = ["128.48.64.0/19", "10.48.0.0/15"]

  tags = {
    application = "chs-dev"
    createdBy   = "terraform"
    environment = "dev"
    group       = "chs"
    source      = join("/", ["https://github.com/ucopacme/ucop-terraform-deployments/terraform/chs-dev"])
  }
}

module "fsx" {
  source = "git::https://git@github.com/ucopacme/terraform-aws-fsx-ontap.git"

  cluster-name = local.name

  preferred-subnet-id = data.terraform_remote_state.vpc-chs-dev-vpc.outputs.data_subnet_ids[0]
  sg-cidrs            = local.cidrs
  subnet-ids          = [data.terraform_remote_state.vpc-chs-dev-vpc.outputs.data_subnet_ids[0]] # One subnet id is required for single_az_1
  vpc-id              = data.terraform_remote_state.vpc-chs-dev-vpc.outputs.vpc_id

  fs-deployment-type     = "SINGLE_AZ_1"
  fs-retention-days      = 30
  fs-ssd-capacity-gb     = 1024
  fs-ssd-throughput-iops = 128
  
  svm-volume-map = {
    fsx-test-svm = {
      volumes = {
        fsx_test_vol1 = {
          size-gb           = 100
          ontap-volume-type = "DP"
          tiering-policy = {
            cooling-period = 14
            name           = "AUTO"
          }
        },
        secondary_test_vol = {
          size-gb                    = 50
          storage-efficiency-enabled = true
          security-style             = "UNIX"
          ontap-volume-type          = "RW"
          junction-path              = "/secondary_test_vol"
          tiering-policy = {
            cooling-period = 14
            name           = "AUTO"
          }
        }
      }
    },
    #other-svm-on-ad = {
    #    active-directory = {
    #        svc-account = "svc-account"
    #    },
    #    volumes = {
    #        fsx-test-vol1 = {
    #            size = 100
    #            security-style = "ntfs"
    #            ontap-volume-type = "DP"
    #            tiering-policy = {
    #                cooling-period = 14
    #                name = "auto"
    #            }
    #        }
    #    }
    #}
  }

  tags = local.tags
}
```