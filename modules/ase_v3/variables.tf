variable "ase_name" {
  description = "The name of the App Service Environment"
  type        = string
}

variable "ase_resource_group_name" {
  description = "The name of the resource group for ASE"
  type        = string
}

variable "ase_subnet_id" {
  description = "The id of the subnet for ASE"
  type        = string
}

variable "default_tags" {
  description = "The default tags to apply to all resources"
  type        = map(string)
}