resource "aws_fsx_ontap_volume" "volume" {
  for_each                   = local.volumes
  
  name                       = each.key
  storage_virtual_machine_id = aws_fsx_ontap_storage_virtual_machine.svm[each.value.svm].id

  copy_tags_to_backups       = true
  junction_path              = each.value.junction-path
  ontap_volume_type          = each.value.ontap-volume-type
  security_style             = each.value.security-style
  size_in_megabytes          = 1024 * tonumber(each.value.size-gb)
  storage_efficiency_enabled = each.value.storage-efficiency-enabled
  
  dynamic "tiering_policy" {
    for_each = [each.value.tiering-policy]
    content {
      cooling_period = tonumber(each.value.tiering-policy.cooling-period)
      name           = each.value.tiering-policy.name
    }
  }

  tags = local.tags

  lifecycle {
    ignore_changes = [
      storage_efficiency_enabled,
      security_style,
      ontap_volume_type,
      junction_path,
      size_in_megabytes,
      tiering_policy,
    ]
  }
}
