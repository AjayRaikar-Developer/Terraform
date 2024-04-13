variable "key_valut_name" {
  description = "The name of the key vault"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "tenant_id" {
  description = "The tenant ID"
  type        = string
}

# This is the Azure Resource Managed Identity Id 
# azurerm_resource.example.identity.0.principal_id
variable "object_id" {
  description = "The object ID"
  type        = string
}

variable "default_tags" {
  description = "The default tags to apply to all resources"
  type        = map(string)
}