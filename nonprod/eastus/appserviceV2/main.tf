module "azurerm_windows_web_app_v2" {
  source = "./../../../modules/appserviceV2" # path to the module directory

  count               = length(var.appservice_configs)
  resource_group_name  = var.resource_group_name
  storage_account_name = var.storage_account_name
  appservice_config   = var.appservice_configs[count.index]
  workspace_name       = var.workspace_name
  default_tags         = var.default_tags
}