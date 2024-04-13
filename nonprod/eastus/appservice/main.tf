module "azurerm_windows_web_app" {
  source = "./../../../modules/appservice" # path to the module directory

  resource_group_name  = var.resource_group_name
  storage_account_name = var.storage_account_name
  appservice_configs   = var.appservice_configs
  create_slots         = var.create_slots
  workspace_name       = var.workspace_name
  default_tags         = var.default_tags
}