output "east_app_service_plan_ids" {
  value = module.app_service_plan.app_service_plan_ids
}

output "east_azurerm_log_analytics_workspace_id" {
  value = module.azurerm_log_analytics_workspace.workspace_id
}
