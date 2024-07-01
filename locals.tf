
locals {
  name = join("-", [local.tags["ucop:application"], local.tags["ucop:environment"], var.cluster-name])

  cidrs = flatten([var.sg-cidrs, []])

  # Restructures the svm-volume-map variable into a map of volumes. As this is an arbitrary map,
  # consider these to be the "variables" for this map definition.
  volumes = merge([
    for svm, volumes in var.svm-volume-map : {
      for volume, volume-config in volumes.volumes : volume => {
        junction-path              = lookup(volume-config, "junction-path", null)
        name                       = lookup(volume-config, "name", "")
        ontap-volume-type          = lookup(volume-config, "ontap-volume-type", "DP")
        security-style             = lookup(volume-config, "security-style", null)
        size-gb                    = lookup(volume-config, "size-gb", 100)
        storage-efficiency-enabled = lookup(volume-config, "storage-efficiency-enabled", null)
        svm                        = svm
        tiering-policy = lookup(volume-config, "tiering-policy", {
          cooling-period = 14
          name           = "AUTO"
        })
      }
    }
  ]...)

  tags = var.tags
}
