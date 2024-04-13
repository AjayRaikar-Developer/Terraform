
locals {
  slots = ["stage"]
}
data "azurerm_resource_group" "main" {
  name = var.resource_group_name
}

data "azurerm_service_plan" "main" {
  count               = length(var.appservice_configs)
  name                = var.appservice_configs[count.index].app_service_plan_name
  resource_group_name = data.azurerm_resource_group.main.name
}

data "azurerm_log_analytics_workspace" "main" {
  name                = var.workspace_name
  resource_group_name = var.resource_group_name
}


resource "azurerm_application_insights" "main" {
  count               = length(var.appservice_configs)
  workspace_id        = data.azurerm_log_analytics_workspace.main.id
  name                = "${var.appservice_configs[count.index].name}-appinsights"
  location            = data.azurerm_resource_group.main.location
  resource_group_name = data.azurerm_resource_group.main.name
  application_type    = "web"
  tags                = var.default_tags
}


#Web app creation & enable system assigned identity
resource "azurerm_windows_web_app" "main" {
  count                                    = length(var.appservice_configs)
  name                                     = var.appservice_configs[count.index].name
  resource_group_name                      = data.azurerm_resource_group.main.name
  location                                 = data.azurerm_resource_group.main.location
  service_plan_id                          = data.azurerm_service_plan.main.*.id[count.index]
  tags                                     = var.default_tags
  https_only                               = true
  ftp_publish_basic_authentication_enabled = true
  client_affinity_enabled                  = true

  site_config {
    application_stack {
      current_stack  = "dotnet"
      dotnet_version = var.appservice_configs[count.index].dot_net_version
    }

    use_32_bit_worker     = false
    managed_pipeline_mode = "Integrated"
    ftps_state            = "AllAllowed"
    http2_enabled         = false
    websockets_enabled    = false
    always_on             = true
    minimum_tls_version   = "1.2"
  }

  identity {
    type = "SystemAssigned"
  }

  lifecycle {
    ignore_changes = [app_settings, tags]
  }

  app_settings = {
    "APPLICATIONINSIGHTS_CONNECTION_STRING"      = azurerm_application_insights.main[count.index].connection_string,
    "ApplicationInsightsAgent_EXTENSION_VERSION" = "~3"
  }

  depends_on = [azurerm_application_insights.main]
}

# create 2 slots test & stage 
#slot creation for an exsiting web app
resource "azurerm_windows_web_app_slot" "main" {
  count          = var.create_slots ? length(var.appservice_configs) * length(local.slots) : 0
  name           = element(local.slots, count.index % length(local.slots))
  app_service_id = element(azurerm_windows_web_app.main.*.id, count.index / length(local.slots))
  tags           = var.default_tags

  site_config {}

  lifecycle {
    ignore_changes = [app_settings, tags]
  }


  depends_on = [azurerm_windows_web_app.main]
}
