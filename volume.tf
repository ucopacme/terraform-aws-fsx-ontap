resource "aws_fsx_ontap_volume" "volume" {
  for_each = local.volumes
  storage_virtual_machine_id = aws_fsx_ontap_storage_virtual_machine.svm[each.value.svm].id
  name                       = each.value.name

  ontap_volume_type          = each.value.securityStyle
  size_in_megabytes          = 1024 * each.value.size # 100 GB

  dynamic tiering_policy {
    for_each = [each.value.tiering_policy]
    content {
      cooling_period = tiering_policy.value.cooling_period
      name           = tiering_policy.value.name
    }
  }

  tags = local.tags
}