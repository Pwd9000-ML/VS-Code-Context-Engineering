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

variable "global_tags" {
  description = "Global tags merged with per-RG tags"
  type        = map(string)
  default = {
    owner       = "team-platform"
    cost_center = "cc-001"
  }
}
