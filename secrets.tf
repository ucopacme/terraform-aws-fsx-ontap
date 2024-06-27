resource "random_password" "fsx_ontap_password" {
  length           = 16
  special          = true
  override_special = "_%@"
}

resource "aws_secretsmanager_secret" "fsx_ontap_password" {
  name = join("/", ["fsx-ontap", local.name, "fsxadmin-password"])

  tags = local.tags
}

# Generate a first-time password
resource "aws_secretsmanager_secret_version" "fsx_ontap_password" {
  secret_id     = aws_secretsmanager_secret.fsx_ontap_password.id
  secret_string = random_password.fsx_ontap_password.result

  lifecycle {
    ignore_changes = [secret_string]
  }
}

# Get latest secret from Secrets Manager in case it's been updated manually
data "aws_secretsmanager_secret_version" "fsx_ontap_password" {
  secret_id = aws_secretsmanager_secret.fsx_ontap_password.id
}