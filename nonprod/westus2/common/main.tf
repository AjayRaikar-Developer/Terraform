# West Region 


####################################################################################### ASE CREATION ######################################################################################

# module "west_resource_group" {
#   source = "./../../modules/rg" # path to the module directory

#   resource_group_name = var.west2_resource_group_name
#   location            = var.west2_location
# }

# module "west_ase_v3" {
#   source = "./../../modules/ase_v3" # path to the module directory

#   ase_name                = var.west2_ase_name
#   ase_resource_group_name = module.west_resource_group.resource_group_name
#   ase_subnet_id           = var.west2_ase_subnet_id
# }


#############################################################################################################################################################################################

############################################################### STORAGE ACCOUNT CREATION #######################################################################################


module "azurerm_storage_account" {
  source = "./../../../modules/storage_acc" 

  storage_account_name               = var.storage_account_name
  resource_group_name      = data.azurerm_resource_group.main.name
  default_tags = var.default_tags
}


#############################################################################################################################################################################################



############################################################### APP SERVICE PLAN CREATION ####################################################################################################


data "azurerm_resource_group" "main" {
  name = var.resource_group_name
}

data "azurerm_app_service_environment_v3" "main" {
  name                = var.ase_name
  resource_group_name = data.azurerm_resource_group.main.name
}

module "west_app_service_plan" {
  source = "./../../../modules/asp" # path to the module directory

  app_service_plan_names = var.app_service_plan_names
  location               = data.azurerm_resource_group.main.location
  resource_group_name    = data.azurerm_resource_group.main.name
  ase_id                 = data.azurerm_app_service_environment_v3.main.id
  default_tags           = var.default_tags
  os_type                = var.os_type
  sku_name               = var.sku_name
}

############################################################################################################################################################################################



############################################################### LOG ANALYTICS CREATION ####################################################################################################

module "west_azurerm_log_analytics_workspace" {
  source = "./../../../modules/log_workspace" # path to the module directory

  resource_group_name   = var.resource_group_name
  workspace_name        = var.workspace_name
  default_tags          = var.default_tags
  log_retention_in_days = var.log_retention_in_days
}

############################################################################################################################################################################################
