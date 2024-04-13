
#verify the resource group exists
data "azurerm_resource_group" "main" {
  name = var.resource_group_name
}

#verify the key vault exists
data "azurerm_key_vault" "main" {
  name                = var.key_valut_name
  resource_group_name = data.azurerm_resource_group.main.name
}

#create a key vault access policy
resource "azurerm_key_vault_access_policy" "main" {
  key_vault_id = data.azurerm_key_vault.main.id

  tenant_id = var.tenant_id
  object_id = var.object_id

  key_permissions = [
    "Get", "List"
  ]

  secret_permissions = [
    "Get", "List"
  ]

  certificate_permissions = [
    "Get", "List"
  ]

}