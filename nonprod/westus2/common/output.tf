output "west_app_service_plan_ids" {
  value = module.west_app_service_plan.app_service_plan_ids
}

output "west_azurerm_log_analytics_workspace_id" {
  value = module.west_azurerm_log_analytics_workspace.workspace_id
}
