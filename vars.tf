variable "cluster-name" {
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

variable "subnet-ids" {
  description = "Subnet IDs to use for the FSx ONTAP file system"
  type        = list(string)
}

variable "preferred-subnet-id" {
  description = "Preferred Subnet ID to use for the FSx ONTAP file system"
  type        = string
}

variable "vpc-id" {
  description = "VPC ID to use for the FSx ONTAP file system"
  type        = string
}

variable "svm-volume-map" {
  description = "Map of SVM names to volume names"
  type        = any

  # Example:
  # {
  #     "ssd-size" = 100
  #     "svm" = {
  #       "active-directory" = {svc-account = "svc-account"}
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

variable "fs-ssd-capacity-gb" {
  description = "Storage capacity for the FSx ONTAP file system"
  type        = number

  default = 1024
}

variable "fs-ssd-throughput-mbps" {
  description = "Throughput capacity for the FSx ONTAP file system"
  type        = number

  default = 128
}

variable "fs-deployment-type" {
  description = "Deployment type for the FSx ONTAP file system"
  type        = string

  default = "SINGLE_AZ_1"
}

variable "fs-retention-days" {
  description = "Automatic backup retention days for the FSx ONTAP file system"
  type        = number

  default = 30
}

variable "sg-cidrs" {
    description = "CIDRs to allow in the security group"
    type        = list(string)
    
    default = []
}