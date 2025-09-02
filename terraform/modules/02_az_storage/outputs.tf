output "id" {
  value       = azurerm_storage_account.this.id
  description = "Storage Account ID"
}

output "name" {
  value       = azurerm_storage_account.this.name
  description = "Storage Account name"
}

output "primary_access_key" {
  value       = azurerm_storage_account.this.primary_access_key
  description = "Storage Account primary access key"
  sensitive   = true
}

output "primary_connection_string" {
  value       = azurerm_storage_account.this.primary_connection_string
  description = "Storage Account primary connection string"
  sensitive   = true
}