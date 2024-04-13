resource "azurerm_app_service_environment_v3" "main" {
  name                                   = var.ase_name
  resource_group_name                    = var.ase_resource_group_name
  subnet_id                              = var.ase_subnet_id
  zone_redundant                         = false
  allow_new_private_endpoint_connections = false             # Configuration -> Allow new private endpoints -> Fasle
  internal_load_balancing_mode           = "Web, Publishing" # Virtual IP -> Internal
  tags                                   = var.default_tags
}  