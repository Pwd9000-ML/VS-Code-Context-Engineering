environment = "prod"
location    = "westeurope"
resource_groups = {
  core = {
    name = "rg-prod-core"
    tags = { workload = "core", tier = "prod" }
  }
}
