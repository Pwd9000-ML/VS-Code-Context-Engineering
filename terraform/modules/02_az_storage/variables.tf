variable "name" {
  type        = string
  description = "Storage Account name"
}

variable "resource_group_name" {
  type        = string
  description = "Resource Group name where the storage account will be created"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "account_tier" {
  type        = string
  description = "Storage Account tier"
  default     = "Standard"
}

variable "account_replication_type" {
  type        = string
  description = "Storage Account replication type"
  default     = "LRS"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply"
  default     = {}
}