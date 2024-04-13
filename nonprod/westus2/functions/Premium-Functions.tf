locals {
  premium_function_names = ["n0-timer-fn","n0-batch-fn"]
  azurerm_service_plan_name = "uswest2-asp2"
}

data "azurerm_resource_group" "main" {
  name = var.resource_group_name
}

resource "azurerm_service_plan" "main" {
  name                       = local.azurerm_service_plan_name
  location                   = data.azurerm_resource_group.main.location
  resource_group_name        = var.resource_group_name
  os_type                    = "Windows"
  sku_name                   = "P1v2"
  tags                       = var.default_tags
}

module "azurerm_windows_function_app_premium" {
  source = "./../../../modules/func_app" # path to the module directory

  resource_group_name   = var.resource_group_name
  storage_account_name  = var.storage_account_name
  app_service_plan_name = local.azurerm_service_plan_name
  function_app_names    = local.premium_function_names
  create_slots          = var.create_slots
  workspace_name        = var.workspace_name
  default_tags          = var.default_tags
}
