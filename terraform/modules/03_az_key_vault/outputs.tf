output "id" {
  value       = azurerm_key_vault.this.id
  description = "Key Vault ID"
}

output "name" {
  value       = azurerm_key_vault.this.name
  description = "Key Vault name"
}

output "vault_uri" {
  value       = azurerm_key_vault.this.vault_uri
  description = "Key Vault URI"
}