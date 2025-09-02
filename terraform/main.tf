locals {
  merged_rgs = { for k, rg in var.resource_groups : k => merge(rg, {
    tags = merge(var.global_tags, { environment = var.environment }, rg.tags)
  }) }
}

module "resource_groups" {
  source   = "./modules/resource-group"
  for_each = local.merged_rgs

  name     = each.value.name
  location = var.location
  tags     = each.value.tags
}

output "resource_group_names" {
  value = [for m in module.resource_groups : m.name]
}
