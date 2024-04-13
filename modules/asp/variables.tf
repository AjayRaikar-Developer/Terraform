variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The location of the resource group"
  type        = string
}

variable "ase_id" {
  description = "The name of the App Service Environment Id"
  type        = string
}

variable "os_type" {
  description = "The OS Type of the App Service Environment"
  type        = string
}

variable "sku_name" {
  description = "The SKU Name of the App Service Environment"
  type        = string
}

variable "app_service_plan_names" {
  description = "The name of the App Service Plan"
  type        = list(string)
}

variable "default_tags" {
  description = "The default tags to apply to all resources"
  type        = map(string)
}