output "web_app_default_hostname" {
  description = "The default hostname of the function app"
  value       = azurerm_windows_web_app.main[*].default_hostname
}