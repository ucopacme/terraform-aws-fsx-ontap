variable "cluster_name" {
  description = "Name of the cluster"
  type        = string
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)

  default = {
    createdBy = "terraform"
  }
}

variable "subnet_ids" {
  description = "Subnet IDs to use for the FSx ONTAP file system"
  type        = list(string)
}

variable "preferred_subnet_id" {
  description = "Preferred Subnet ID to use for the FSx ONTAP file system"
  type        = string

  default = var.subnet_ids[0]
}

variable "vpc_id" {
  description = "VPC ID to use for the FSx ONTAP file system"
  type        = string
}

variable "svm_volume_map" {
  description = "Map of SVM names to volume names"
  type        = map(map(map(string)))

  # Example:
  # {
  #     "ssd_size" = 100
  #     "svm" = {
  #       "active_directory" = {svc_account = "svc_account"}
  #       "volumes" = {
  #           "volume1" = {
  #               "size" = 100
  #               "securityStyle" = "ntfs"
  #           },
  #           "volume2" = {
  #               "size" = 100
  #               "securityStyle" = "ntfs"
  #       },
  #     }
  # }
}

variable "fs_ssd_capacity" {
  description = "Storage capacity for the FSx ONTAP file system"
  type        = number

  default = 1024
}

variable "fs_ssd_throughput" {
  description = "Throughput capacity for the FSx ONTAP file system"
  type        = number

  default = 128
}

variable "fs_deployment_type" {
  description = "Deployment type for the FSx ONTAP file system"
  type        = string

  default = "SINGLE_AZ_1"
}

variable "fs_retention_days" {
  description = "Automatic backup retention days for the FSx ONTAP file system"
  type        = number

  default = 30
}

variable "sg_cidrs" {
    description = "CIDRs to allow in the security group"
    type        = list(string)
    
    default = []
}