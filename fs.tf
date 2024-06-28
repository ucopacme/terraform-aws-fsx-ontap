
resource "aws_fsx_ontap_file_system" "fsx-ontap" {
  fsx_admin_password  = data.aws_secretsmanager_secret_version.fsx-ontap-password.secret_string
  subnet_ids          = var.subnet-ids
  preferred_subnet_id = var.preferred-subnet-id
  security_group_ids  = [module.sg-fsx-ontap.id]

  automatic_backup_retention_days = var.fs-retention-days
  deployment_type                 = var.fs-deployment-type
  storage_capacity                = var.fs-ssd-capacity-gb
  throughput_capacity             = var.fs-ssd-throughput-iops

  tags = local.tags
}
