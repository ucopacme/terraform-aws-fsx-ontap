
locals {
  name = join("-", [local.tags.application, local.tags.environment, var.cluster_name])

  cidrs = flatten(var.sg_cidrs, ["128.48.64.0/19", "10.48.0.0/15"])
  
  # For all volumes in all svms, create a map of {volume: {size: size, securityStyle: securityStyle, svm: svm}}
  volumes = merge([
    for svm, volumes in var.svm_volume_map : {
      for volume, volume_config in volumes.volumes : volume => {
          size          = lookup(volume_config, "size", 100)
          securityStyle = lookup(volume_config, "securityStyle", "unix")
          svm           = svm
          name = lookup(volume_config, "name", "")
          ontap_volume_type = lookup(volume_config, "ontap_volume_type", "DP")
          tiering_policy = lookup(volume_config, "tiering_policy", {
            cooling_period = 14
            name           = "AUTO"
          })
        }
      }
  ]...)

  tags = var.tags
}
