# Security Groups
module "sg-fsx-ontap" {
  source                 = "git::https://git@github.com/ucopacme/terraform-aws-security-group.git//"
  enabled                = true
  name                   = var.cluster-name
  vpc_id                 = var.vpc-id
  revoke_rules_on_delete = true
  ingress = concat( # Ports identified from https://docs.aws.amazon.com/fsx/latest/ONTAPGuide/limit-access-security-groups.html
    [
      for tcp-port in tolist(["22", "111", "135", "139", "161", "162", "443", "445", "635", "749", "2049", "3260", "4045", "4046", "10000", "11104", "11105"]) : {
        description = "TCP port ${tcp-port}"
        from_port   = tcp-port
        to_port     = tcp-port
        protocol    = "tcp"
        cidr_blocks = local.cidrs
      }
    ],
    [
      for udp-port in tolist(["111", "135", "137", "139", "161", "162", "635", "2049", "4045", "4046", "4049"]) : {
        description = "UDP port ${udp-port}"
        from_port   = udp-port
        to_port     = udp-port
        protocol    = "udp"
        cidr_blocks = local.cidrs
      }
    ],
    [
      {
        description = "ICMP"
        from_port   = "0"
        to_port     = "0"
        protocol    = "icmp"
        cidr_blocks = local.cidrs
      }
    ]
  )
  egress = [
    {
      from_port   = "0"
      to_port     = "0"
      protocol    = "-1"
      cidr_blocks = local.cidrs
    },
  ]

  tags = local.tags
}

# for each svm create an svm if svm.active-directory is set
resource "aws_fsx_ontap_storage_virtual_machine" "svm" {
  for_each       = var.svm-volume-map
  file_system_id = aws_fsx_ontap_file_system.fsx-ontap.id
  name           = each.key

  # if each.value.active-directory-configuration is set
  dynamic "active_directory_configuration" {
    for_each = lookup(each.value, "active-directory", {})
    content {
      netbios_name = each.value.active-directory.netbios-name
      self_managed_active_directory_configuration {
        dns_ips     = each.value.active-directory.dns-ips
        domain_name = each.value.active-directory.domain-name
        password    = each.value.active-directory.password
        username    = each.value.active-directory.username
      }
    }
  }

  tags = local.tags
}
