variable "cluster-name" {
  description = "Name of the cluster"
  type        = string
}

variable "fs-backup-start-time" {
  description = "Daily automatic backup start time for the FSx ONTAP file system"
  type        = string

  default = "02:00"
}

variable "fs-deployment-type" {
  description = "Deployment type for the FSx ONTAP file system"
  type        = string

  default = "SINGLE_AZ_2"
}

variable "fs-maintenance-start-time" {
  description = "Weekly maintenance start time for the FSx ONTAP file system"
  type        = string

  default = "7:11:00"
}

variable "fs-retention-days" {
  description = "Automatic backup retention days for the FSx ONTAP file system"
  type        = number

  default = 30
}

variable "fs-ssd-capacity-gb" {
  description = "Storage capacity for the FSx ONTAP file system, in GigaBytes. This cannot be shrunk, only grown."
  type        = number

  default = 1024
}

variable "fs-ssd-throughput-mbps" {
  description = "Throughput capacity for the FSx ONTAP file system"
  type        = number

  default = 128
}

variable "preferred-subnet-id" {
  description = "Preferred Subnet ID to use for the FSx ONTAP file system"
  type        = string
}

variable "sg-cidrs" {
  description = "CIDRs to allow in the security group"
  type        = list(string)

  default = []
}

variable "subnet-ids" {
  description = "Subnet IDs to use for the FSx ONTAP file system"
  type        = list(string)
}


variable "svm-volume-map" {
  description = "Map of SVM names to volume names. Top level configurations are for SVMs, nested configurations are for volumes. For more details and an example, see svm-volume-map.md"
  type        = any
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)

  default = {
    createdBy = "terraform"
  }
}

variable "vpc-id" {
  description = "VPC ID to use for the FSx ONTAP file system"
  type        = string
}
