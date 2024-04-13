#Backend Config where the state file will be created and saved & updated

terraform {
  backend "azurerm" {
    resource_group_name  = "Terraform-RG"
    storage_account_name = "Terraform-Storage-AC"
    container_name       = "nonprod-tfstate"
    key                  = "terraform-useast-appservice.tfstate"
  }
}