module "azurerm_windows_function_app" {
  source = "./../../../modules/func_app" # path to the module directory

  resource_group_name   = var.resource_group_name
  storage_account_name  = var.storage_account_name
  app_service_plan_name = var.app_service_plan_name
  function_app_names    = var.function_app_names
  create_slots          = var.create_slots
  workspace_name        = var.workspace_name
  default_tags          = var.default_tags
}