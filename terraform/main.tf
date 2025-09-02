locals {
  merged_rgs = { for k, rg in var.resource_groups : k => merge(rg, {
    tags = merge(var.global_tags, { environment = var.environment }, rg.tags)
  }) }

  merged_storage_accounts = { for k, sa in var.storage_accounts : k => merge(sa, {
    tags = merge(var.global_tags, { environment = var.environment }, sa.tags)
  }) }

  merged_key_vaults = { for k, kv in var.key_vaults : k => merge(kv, {
    tags = merge(var.global_tags, { environment = var.environment }, kv.tags)
  }) }
}

module "resource_groups" {
  source   = "./modules/01_resource_group"
  for_each = local.merged_rgs

  name     = each.value.name
  location = var.location
  tags     = each.value.tags
}

module "storage_accounts" {
  source   = "./modules/02_az_storage"
  for_each = local.merged_storage_accounts

  name                     = each.value.name
  resource_group_name      = module.resource_groups[each.value.resource_group_key].name
  location                 = var.location
  account_tier             = each.value.account_tier
  account_replication_type = each.value.account_replication_type
  tags                     = each.value.tags
}

module "key_vaults" {
  source   = "./modules/03_az_key_vault"
  for_each = local.merged_key_vaults

  name                = each.value.name
  resource_group_name = module.resource_groups[each.value.resource_group_key].name
  location            = var.location
  sku_name            = each.value.sku_name
  access_policies     = each.value.access_policies
  tags                = each.value.tags
}

output "resource_group_names" {
  value = [for m in module.resource_groups : m.name]
}

output "storage_account_names" {
  value = [for m in module.storage_accounts : m.name]
}

output "key_vault_names" {
  value = [for m in module.key_vaults : m.name]
}
