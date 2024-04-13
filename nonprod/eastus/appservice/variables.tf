variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "storage_account_name" {
  description = "The name of the storage account"
  type        = string
}

variable "workspace_name" {
  type        = string
  description = "Name of the log analytics workspace"
}

variable "appservice_configs" {
  description = "App service configurations"
  type = list(object({
    name            = string
    dot_net_version = string
    app_service_plan_name : string
  }))
}

variable "create_slots" {
  description = "Create slots for the web & function apps"
  type        = bool
}

variable "default_tags" {
  description = "The default tags to apply to all resources"
  type        = map(string)
}