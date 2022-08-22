# ------ root/providers.tf

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.24.0"
    }
  }
  #   cloud {
  #     organization = "Flintlocks-Terraform"
  #     workspaces {
  #       name = "2-Tier-Project"
  #     }
  #   }
}

provider "aws" {
  region = "us-east-2"

}
