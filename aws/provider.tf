terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.43.0"
    }
  }

  required_version = ">= 1.7.0"
}

# providerの設定を行う
provider "aws" {
  region = "ap-northeast-1"
}
