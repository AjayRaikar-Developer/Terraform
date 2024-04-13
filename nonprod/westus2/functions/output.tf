output "function_app_default_hostname" {
  description = "The default hostname of the function app"
  value       = module.azurerm_windows_function_app.function_app_default_hostname
}

output "premium_function_app_default_hostname" {
  description = "The default hostname of the function app"
  value       = module.azurerm_windows_function_app_premium.function_app_default_hostname
}