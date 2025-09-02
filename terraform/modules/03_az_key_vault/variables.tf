variable "name" {
  type        = string
  description = "Key Vault name"
}

variable "resource_group_name" {
  type        = string
  description = "Resource Group name where the key vault will be created"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "sku_name" {
  type        = string
  description = "Key Vault SKU name"
  default     = "standard"
}

variable "access_policies" {
  type = list(object({
    object_id          = string
    key_permissions    = list(string)
    secret_permissions = list(string)
  }))
  description = "List of access policies for the key vault"
  default     = []
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply"
  default     = {}
}