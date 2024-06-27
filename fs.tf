
resource "aws_fsx_ontap_file_system" "fsx_ontap" {
  fsx_admin_password  = data.aws_secretsmanager_secret_version.fsx_ontap_password.secret_string
  subnet_ids          = var.subnet_ids
  preferred_subnet_id = var.preferred_subnet_id
  security_group_ids  = [module.sg_fsx_ontap.id]

  automatic_backup_retention_days = var.fs_retention_days
  deployment_type                 = var.fs_deployment_type
  storage_capacity                = var.fs_ssd_capacity
  throughput_capacity             = var.fs_ssd_throughput

  tags = merge(local.tags, { "Name" = "${local.tags.application}-${local.name}" })
}
