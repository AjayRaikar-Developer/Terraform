output "app_service_plan_ids" {
  value = azurerm_service_plan.main[*].id
}

