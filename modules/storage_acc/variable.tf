variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "storage_account_name" {
  description = "The name of the storage account"
  type        = string
}
variable "default_tags" {
  description = "The default tags to apply to all resources"
  type        = map(string)
}