
locals {
  name = join("-", [local.tags.application, local.tags.environment, var.cluster-name])

  cidrs = flatten([var.sg-cidrs, ["128.48.64.0/19", "10.48.0.0/15"]])

  # For all volumes in all svms, create a map of {volume: {size: size, securityStyle: securityStyle, svm: svm}}
  volumes = merge([
    for svm, volumes in var.svm-volume-map : {
      for volume, volume-config in volumes.volumes : volume => {
        size-gb                    = lookup(volume-config, "size-gb", 100)
        security-style             = lookup(volume-config, "security-style", null)
        svm                        = svm
        name                       = lookup(volume-config, "name", "")
        junction-path              = lookup(volume-config, "junction-path", null)
        ontap-volume-type          = lookup(volume-config, "ontap-volume-type", "DP")
        storage-efficiency-enabled = lookup(volume-config, "storage-efficiency-enabled", null)
        tiering-policy = lookup(volume-config, "tiering-policy", {
          cooling-period = 14
          name           = "AUTO"
        })
      }
    }
  ]...)

  tags = var.tags
}
