resource "azurerm_service_plan" "main" {
  count                      = length(var.app_service_plan_names)
  name                       = var.app_service_plan_names[count.index]
  location                   = var.location
  resource_group_name        = var.resource_group_name
  app_service_environment_id = var.ase_id
  os_type                    = var.os_type
  sku_name                   = var.sku_name
  tags                       = var.default_tags
}
