resource "azurerm_redis_cache" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name

  sku_name = format("%s", var.sku_name)
  family   = var.family
  capacity = var.capacity

  minimum_tls_version = var.minimum_tls_version

  tags = var.tags
}
