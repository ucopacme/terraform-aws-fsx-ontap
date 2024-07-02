output "route53_records" {
  description = "Map of all DNS records created for all resources in this module."

  value = { 
    fs_management = aws_route53_record.fs_management.fqdn,
    fs_intercluster = aws_route53_record.fs_intercluster.fqdn,
    svm_iscsi = { for k, v in aws_route53_record.svm_iscsi : k => v.fqdn },
    svm_nfs = { for k, v in aws_route53_record.svm_nfs : k => v.fqdn },
    svm_smb = { for k, v in aws_route53_record.svm_smb : k => v.fqdn },
    svm_management = { for k, v in aws_route53_record.svm_management : k => v.fqdn },
   }
}

output "fsx_admin_password_location" {
  description = "Where to find the default password to start interacting with the filer."

  value = aws_secretsmanager_secret.fsx-ontap-password.arn
}

output "fsx_fs_management_ip" {
  description = "If the DNS doesn't work, this is the IP for the filer management interface."

  value = aws_fsx_ontap_file_system.fsx-ontap.endpoints[0].management[0].ip_addresses
}

output "fsx_fs_intercluster_ips" {
  description = "IPs for the intercluster LIFs on the filer."
  
  value = aws_fsx_ontap_file_system.fsx-ontap.endpoints[0].intercluster[*].ip_addresses
}