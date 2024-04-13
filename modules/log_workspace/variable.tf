variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "workspace_name" {
  type        = string
  description = "Name of the log analytics workspace"
}

variable "default_tags" {
  description = "The default tags to apply to all resources"
  type        = map(string)
}

variable "log_retention_in_days" {
  type        = number
  description = "Retention in days log analytics workspace"
}