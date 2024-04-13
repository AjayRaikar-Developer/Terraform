output "appservice_default_hostname" {
  description = "The default hostname of the app service"
  value       = azurerm_windows_web_app.main.default_hostname
}