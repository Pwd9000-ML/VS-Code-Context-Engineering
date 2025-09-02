variable "name" {
  type        = string
  description = "Resource Group name"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply"
  default     = {}
}
