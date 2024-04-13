variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "storage_account_name" {
  description = "The name of the storage account"
  type        = string
}


variable "appservice_config" {
  description = "App service configurations"
  type = object({
    name            = string
    dot_net_version = string
    app_service_plan_name : string,
    create_slots : bool
  })
}


variable "workspace_name" {
  type        = string
  description = "Name of the log analytics workspace"
}

variable "default_tags" {
  description = "The default tags to apply to all resources"
  type        = map(string)
}