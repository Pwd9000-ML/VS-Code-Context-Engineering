variable "name" {
  type        = string
  description = "Redis Cache name"
}

variable "resource_group_name" {
  type        = string
  description = "Resource Group name where the Redis cache will be created"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "sku_name" {
  type        = string
  description = "Redis SKU: Basic | Standard | Premium"
  default     = "Basic"
}

variable "family" {
  type        = string
  description = "SKU family: C (Basic/Standard) or P (Premium)"
  default     = "C"
}

variable "capacity" {
  type        = number
  description = "Redis cache size (depends on family/SKU)"
  default     = 1
}

variable "enable_non_ssl_port" {
  type        = bool
  description = "Enable the non-SSL port (6379)"
  default     = false
}

variable "minimum_tls_version" {
  type        = string
  description = "Minimum TLS version"
  default     = "1.2"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply"
  default     = {}
}
