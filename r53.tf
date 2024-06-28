resource "random_password" "fsx-ontap-password" {
  length           = 16
  special          = true
  override_special = "_%@"
}

resource "aws_secretsmanager_secret" "fsx-ontap-password" {
  name = join("/", ["fsx-ontap", var.cluster-name, "fsxadmin-password"])

  tags = local.tags
}

# Generate a first-time password
resource "aws_secretsmanager_secret_version" "fsx-ontap-password" {
  secret_id     = aws_secretsmanager_secret.fsx-ontap-password.id
  secret_string = random_password.fsx-ontap-password.result

  lifecycle {
    ignore_changes = [secret_string]
  }
}

# Get latest secret from Secrets Manager in case it's been updated manually
data "aws_secretsmanager_secret_version" "fsx-ontap-password" {
  secret_id = aws_secretsmanager_secret.fsx-ontap-password.id

  depends_on = [ aws_secretsmanager_secret_version.fsx-ontap-password ]
}