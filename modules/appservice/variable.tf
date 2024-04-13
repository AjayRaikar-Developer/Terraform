variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "storage_account_name" {
  description = "The name of the storage account"
  type        = string
}

# variable "app_service_plan_name" {
#   description = "The name of the app service plan"
#   type        = string
# }

variable "appservice_configs" {
  description = "App service configurations"
  type = list(object({
    name            = string
    dot_net_version = string
    app_service_plan_name : string
  }))
}

variable "create_slots" {
  description = "Create slots for the web apps"
  type        = bool
}

# variable "dot_net_versions" {
#   description = "The names of the web apps"
#   type        = list(string)
# }

variable "workspace_name" {
  type        = string
  description = "Name of the log analytics workspace"
}

variable "default_tags" {
  description = "The default tags to apply to all resources"
  type        = map(string)
}