output "route53_records" {
  description = "Map of all DNS records created for all resources in this module."

  value = { for r in aws_route53_record.* : r.fqdn => r.records }
}

output "fsx_admin_password_location" {
  description = "Where to find the default password to start interacting with the filer."

  value = aws_secretsmanager_secret.fsx-ontap-password.arn
}

output "fsx_fs_management_ip" {
  description = "If the DNS doesn't work, this is the IP for the filer management interface."

  value = aws_fsx_ontap_file_system.fsx-ontap.endpoints[0].management[0].ip_address
}

output "fsx_fs_intercluster_ips" {
  description = "IPs for the intercluster LIFs on the filer."
  
  value = aws_fsx_ontap_file_system.fsx-ontap.endpoints[0].intercluster[*].ip_address
}