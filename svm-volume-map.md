# Custom Object representing SVM <> Volumes relationships

## Syntax
```python
svm-volume-map = {
    # Add as many SVMs as you want to the parent File System
    <SVM NAME> = {
        active-directory = { # Optional
            netbios-name = str
            dns-ips = ["ip","ip"]
            domain-name = str
            password = str # Service Account to manage domain resources for fsx
            username = str # Service Account to manage domain resources for fsx
        },
        volumes = {
            # Add as many volumes as you want to the parent SVM
            <VOLUME NAME> = {
                name = str # Optional
                size-gb = int # Required
                ontap-volume-type = "DP|RW" # Required
                tiering-policy = { # Optional
                    cooling-period = int(days)
                    name = "SNAPSHOT_ONLY|AUTO|ALL|NONE" 
                }
                junction-path = str # Optional, must be azAZ09_, do not include with ontap-volume-type = DP
                security-style = "UNIX|NTFS|MIXED" # Optional, do not include with ontap-volume-type = DP
                storage-efficiency-enabled = bool # Optional
            },
        }
    }
}
```

## Example
```python
  svm-volume-map = {
    fsx-test-svm = {
      volumes = {
        fsx_test_vol1 = {
          size-gb           = 100
          ontap-volume-type = "DP"
          tiering-policy = {
            cooling-period = 14
            name           = "AUTO"
          }
        },
        secondary_test_vol = {
          size-gb                    = 50
          storage-efficiency-enabled = true
          security-style             = "UNIX"
          ontap-volume-type          = "RW"
          junction-path              = "/secondary_test_vol"
          tiering-policy = {
            cooling-period = 14
            name           = "AUTO"
          }
        }
      }
    },
    other-svm-on-ad = {
        active-directory = {
            netbios-name = "EXAMPLE"
            dns-ips = ["123.0.0.123", "1.123.123.1"]
            domain-name = "ad.asdf.com"
            password = "adserviceaccountpassword"
            username = "adserviceaccountusername"
        },
        volumes = {
            fsx_test_vol2 = {
                size = 100
                ontap-volume-type = "DP"
                tiering-policy = {
                    cooling-period = 14
                    name = "auto"
                }
            }
        }
    }
  }
```