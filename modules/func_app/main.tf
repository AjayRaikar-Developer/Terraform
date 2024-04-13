
locals {
  slots = ["stage"]
}
data "azurerm_resource_group" "main" {
  name = var.resource_group_name
}

data "azurerm_service_plan" "main" {
  name                = var.app_service_plan_name
  resource_group_name = data.azurerm_resource_group.main.name
}


data "azurerm_log_analytics_workspace" "main" {
  name                = var.workspace_name
  resource_group_name = var.resource_group_name
}


data "azurerm_storage_account" "main" {
  name                     = var.storage_account_name
  resource_group_name      = data.azurerm_resource_group.main.name
}

resource "azurerm_application_insights" "main" {
  count               = length(var.function_app_names)
  workspace_id        = data.azurerm_log_analytics_workspace.main.id
  name                = "${var.function_app_names[count.index]}-appinsights"
  location            = data.azurerm_resource_group.main.location
  resource_group_name = data.azurerm_resource_group.main.name
  application_type    = "web"
  tags                = var.default_tags
}

resource "azurerm_windows_function_app" "main" {
  count                                    = length(var.function_app_names)
  name                                     = var.function_app_names[count.index]
  location                                 = data.azurerm_resource_group.main.location
  resource_group_name                      = data.azurerm_resource_group.main.name
  service_plan_id                          = data.azurerm_service_plan.main.id
  storage_account_name                     = data.azurerm_storage_account.main.name
  storage_account_access_key               = data.azurerm_storage_account.main.primary_access_key
  tags                                     = var.default_tags
  https_only                               = true
  ftp_publish_basic_authentication_enabled = true

  site_config {
    application_stack {
      dotnet_version = "v6.0"
    }

    application_insights_connection_string = azurerm_application_insights.main[count.index].connection_string
    always_on                              = true
    use_32_bit_worker                      = false
    websockets_enabled                     = false
    managed_pipeline_mode                  = "Integrated"
    ftps_state                             = "AllAllowed"
    http2_enabled                          = false
    minimum_tls_version                    = "1.2"
    pre_warmed_instance_count              = 0
    app_scale_limit                        = 0

  }

  identity {
    type = "SystemAssigned"
  }

  lifecycle {
    ignore_changes = [app_settings, tags]
  }


  depends_on = [azurerm_application_insights.main]
}

resource "azurerm_windows_function_app_slot" "stage" {
  count                = var.create_slots ? length(var.function_app_names) * length(local.slots) : 0
  function_app_id      = element(azurerm_windows_function_app.main.*.id, count.index / length(local.slots))
  name                 = element(local.slots, count.index % length(local.slots))
  storage_account_name =  data.azurerm_storage_account.main.name
  tags                 = var.default_tags
  site_config {
    always_on = true
  }
  lifecycle {
    ignore_changes = [app_settings, tags]
  }
}
