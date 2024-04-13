
#verify the resource group exists
data "azurerm_resource_group" "main" {
  name = var.resource_group_name
}


resource "azurerm_log_analytics_workspace" "main" {
  name                = var.workspace_name
  location            = data.azurerm_resource_group.main.location
  resource_group_name = data.azurerm_resource_group.main.name
  retention_in_days   = var.log_retention_in_days # 30 days retention change this value in PROD
  tags                = var.default_tags
}