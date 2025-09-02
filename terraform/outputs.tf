output "resource_group_ids" {
  value       = { for k, m in module.resource_groups : k => m.id }
  description = "Map of RG IDs"
}
