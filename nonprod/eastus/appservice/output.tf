output "appservice_default_hostname" {
  description = "The default hostname of the app service"
  value       = module.azurerm_windows_web_app.appservice_default_hostname
}