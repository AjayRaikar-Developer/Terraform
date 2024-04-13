output "appservice_app_default_hostnames" {
  description = "The default hostname of the apps"
  value       = module.azurerm_windows_web_app.appservice_default_hostname
}