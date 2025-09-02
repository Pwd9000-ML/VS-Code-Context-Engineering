environment = "dev"
location    = "westeurope"
resource_groups = {
  core = {
    name = "rg-dev-core"
    tags = { workload = "core" }
  }
}

storage_accounts = {
  core = {
    name                     = "stdevcore001"
    resource_group_key       = "core"
    account_tier             = "Standard"
    account_replication_type = "LRS"
    tags                     = { workload = "core" }
  }
}

key_vaults = {
  core = {
    name               = "kv-dev-core-001"
    resource_group_key = "core"
    sku_name           = "standard"
    access_policies    = []
    tags               = { workload = "core" }
  }
}
