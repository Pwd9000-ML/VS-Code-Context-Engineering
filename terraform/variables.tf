variable "environment" {
  type        = string
  description = "Environment name (e.g. dev, prod)"
}

variable "location" {
  type        = string
  description = "Azure region"
  default     = "westeurope"
}

variable "resource_groups" {
  description = "Map of resource group definitions"
  type = map(object({
    name = string
    tags = map(string)
  }))
}

variable "storage_accounts" {
  description = "Map of storage account definitions"
  type = map(object({
    name                     = string
    resource_group_key       = string
    account_tier             = optional(string, "Standard")
    account_replication_type = optional(string, "LRS")
    tags                     = optional(map(string), {})
  }))
  default = {}
}

variable "key_vaults" {
  description = "Map of key vault definitions"
  type = map(object({
    name               = string
    resource_group_key = string
    sku_name           = optional(string, "standard")
    access_policies = optional(list(object({
      object_id          = string
      key_permissions    = list(string)
      secret_permissions = list(string)
    })), [])
    tags = optional(map(string), {})
  }))
  default = {}
}

variable "redis_caches" {
  description = "Map of Redis Cache definitions"
  type = map(object({
    name                = string
    resource_group_key  = string
    sku_name            = optional(string, "Basic") # Basic | Standard | Premium
    family              = optional(string, "C")     # C = (Basic/Standard), P = (Premium)
    capacity            = optional(number, 1)       # 0-6 depending on SKU; keep small baseline
    enable_non_ssl_port = optional(bool, false)
    minimum_tls_version = optional(string, "1.2")
    tags                = optional(map(string), {})
  }))
  default = {}
}

variable "global_tags" {
  description = "Global tags merged with per-RG tags"
  type        = map(string)
  default = {
    owner       = "team-platform"
    cost_center = "cc-001"
  }
}
