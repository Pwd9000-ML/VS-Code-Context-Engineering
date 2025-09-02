environment = "dev"
location    = "westeurope"
resource_groups = {
  core = {
    name = "rg-dev-core"
    tags = { workload = "core" }
  }
}
