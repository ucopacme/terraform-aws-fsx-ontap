# Generates cleaner DNS records. At the time of this comment, this will only ever be resolvable internally to the VPC
# in which this module is deployed.
resource "aws_route53_zone" "fsx" {
  name = "${var.cluster-name}.ucop.edu"

  vpc {
    vpc_id = var.vpc-id
  }

  tags = local.tags
}

resource "aws_route53_record" "fs_management" {
  zone_id = aws_route53_zone.fsx.zone_id
  name    = "management.fs"
  type    = "CNAME"
  ttl     = "300"
  records = [aws_fsx_ontap_file_system.fsx-ontap.endpoints[0].management[0].dns_name]
}

resource "aws_route53_record" "fs_intercluster" {
  zone_id = aws_route53_zone.fsx.zone_id
  name    = "intercluster.fs"
  type    = "CNAME"
  ttl     = "300"
  records = [aws_fsx_ontap_file_system.fsx-ontap.endpoints[0].intercluster[0].dns_name]
}

resource "aws_route53_record" "svm_iscsi" {
  for_each = aws_fsx_ontap_storage_virtual_machine.svm
  zone_id = aws_route53_zone.fsx.zone_id
  name    = "iscsi.${each.key}"
  type    = "CNAME"
  ttl     = "300"
  records = [each.value.endpoints[0].iscsi[0].dns_name]
}

resource "aws_route53_record" "svm_nfs" {
  for_each = aws_fsx_ontap_storage_virtual_machine.svm
  zone_id = aws_route53_zone.fsx.zone_id
  name    = "nfs.${each.key}"
  type    = "CNAME"
  ttl     = "300"
  records = [each.value.endpoints[0].nfs[0].dns_name]
}

resource "aws_route53_record" "svm_management" {
  for_each = aws_fsx_ontap_storage_virtual_machine.svm
  zone_id = aws_route53_zone.fsx.zone_id
  name    = "management.${each.key}"
  type    = "CNAME"
  ttl     = "300"
  records = [each.value.endpoints[0].management[0].dns_name]
}

resource "aws_route53_record" "svm_smb" {
  for_each = aws_fsx_ontap_storage_virtual_machine.svm
  zone_id = aws_route53_zone.fsx.zone_id
  name    = "smb.${each.key}"
  type    = "CNAME"
  ttl     = "300"
  records = [each.value.endpoints[0].management[0].dns_name]
}