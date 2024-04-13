terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
  }
}

provider "azurerm" {
  features {}
  skip_provider_registration = true
  subscription_id            = "" #Add Azure you Subscription ID here
  tenant_id                  = "" #Add Azure you Tenant ID here
  client_id                  = "" #Add Azure you Service Principal Client ID here
  client_secret              = "" #Add Azure you Service Principal Client Secret here
}