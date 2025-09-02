environment = "prod"
location    = "westeurope"
resource_groups = {
  core = {
    name = "rg-prod-core"
    tags = { workload = "core", tier = "prod" }
  }
}

storage_accounts = {
  core = {
    name                     = "stprodcore001"
    resource_group_key       = "core"
    account_tier             = "Standard"
    account_replication_type = "GRS"
    tags                     = { workload = "core", tier = "prod" }
  }
}

key_vaults = {
  core = {
    name               = "kv-prod-core-001"
    resource_group_key = "core"
    sku_name           = "premium"
    access_policies    = []
    tags               = { workload = "core", tier = "prod" }
  }
}

redis_caches = {
  core = {
    name                = "redis-prod-core-001"
    resource_group_key  = "core"
    sku_name            = "Standard"
    family              = "C"
    capacity            = 1
    enable_non_ssl_port = false
    minimum_tls_version = "1.2"
    tags                = { workload = "core", tier = "prod" }
  }
}
