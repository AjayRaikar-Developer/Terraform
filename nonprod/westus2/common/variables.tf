variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "ase_name" {
  description = "The name of the App Service Environment"
  type        = string
}

variable "app_service_plan_names" {
  description = "The name of the App Service Plan"
  type        = list(string)
}

variable "workspace_name" {
  type        = string
  description = "Name of the log analytics workspace"
}

variable "default_tags" {
  description = "The default tags to apply to all resources"
  type        = map(string)
}

variable "os_type" {
  description = "The OS Type of the App Service Environment"
  type        = string
}

variable "sku_name" {
  description = "The SKU Name of the App Service Environment"
  type        = string
}

variable "log_retention_in_days" {
  type        = number
  description = "Retention in days log analytics workspace"
}

variable "storage_account_name" {
  type        = string
  description = "storage account name"
}