terraform {
  # terraformのバージョン指定
  required_version = ">= 1.7.0"

  # providerのバージョン指定
  required_providers {
    snowflake = {
      source = "Snowflake-Labs/snowflake"
    }
  }
}

# providerの設定を行う
provider "snowflake" {
  account  = "CHURA-CHURAINTERN2024"
  role = "SYSADMIN"
}
