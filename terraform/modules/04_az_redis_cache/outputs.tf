output "id" {
  value       = azurerm_redis_cache.this.id
  description = "Redis Cache ID"
}

output "name" {
  value       = azurerm_redis_cache.this.name
  description = "Redis Cache name"
}

output "hostname" {
  value       = azurerm_redis_cache.this.hostname
  description = "Redis Cache hostname"
}

output "port" {
  value       = azurerm_redis_cache.this.port
  description = "Redis Cache SSL Port"
}

output "primary_access_key" {
  value       = azurerm_redis_cache.this.primary_access_key
  description = "Primary access key"
  sensitive   = true
}

output "secondary_access_key" {
  value       = azurerm_redis_cache.this.secondary_access_key
  description = "Secondary access key"
  sensitive   = true
}
