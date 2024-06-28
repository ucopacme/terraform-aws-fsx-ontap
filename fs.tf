# Core FS resource. This is singleton for this module and all other resources are children of this resource.
resource "aws_fsx_ontap_file_system" "fsx-ontap" {
  fsx_admin_password  = data.aws_secretsmanager_secret_version.fsx-ontap-password.secret_string
  preferred_subnet_id = var.preferred-subnet-id
  security_group_ids  = [module.sg-fsx-ontap.id]
  subnet_ids          = var.subnet-ids

  automatic_backup_retention_days   = var.fs-retention-days
  daily_automatic_backup_start_time = var.fs-backup-start-time
  deployment_type                   = var.fs-deployment-type
  storage_capacity                  = var.fs-ssd-capacity-gb
  throughput_capacity               = var.fs-ssd-throughput-mbps
  weekly_maintenance_start_time     = var.fs-maintenance-start-time

  tags = merge(local.tags, {
    Name = var.cluster-name
  })
}
