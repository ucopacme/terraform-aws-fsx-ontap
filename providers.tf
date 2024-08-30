terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.58" # Earliest version that supports fsx-2nd-gen
    }
    random = {
      source = "hashicorp/random"
    }
  }
}
