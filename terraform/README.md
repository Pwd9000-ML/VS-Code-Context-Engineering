# Terraform Azure Boilerplate

Layered, environment-driven structure inspired by Azure-Terraform-Deployments.

## Structure
```
terraform/
  providers.tf          # Required providers + azurerm
  variables.tf          # Root input variables
  main.tf               # Orchestrates modules (resource groups demo)
  outputs.tf            # Root outputs
  modules/
    resource-group/     # Reusable RG module
  env/
    dev.tfvars          # Dev environment values
    prod.tfvars         # Prod environment values
```

## Usage
```pwsh
cd terraform
terraform init
terraform plan -var-file=env/dev.tfvars
terraform apply -var-file=env/dev.tfvars
```
Swap `dev.tfvars` for `prod.tfvars` to target prod.

## Extend
1. Create new module under `modules/<name>`.
2. Add a map entry or variables for that resource.
3. Reference via `module` block with `for_each` if multiple.

## Tagging Strategy
Global tags + environment tag + per-RG tags merged in `locals.merged_rgs`.

## Remote State (Optional)
Add a backend block in `terraform {}` once you have a storage account:
```hcl
backend "azurerm" {
  resource_group_name  = "rg-tfstate"
  storage_account_name = "sttfstate123"
  container_name       = "tfstate"
  key                  = "core/${var.environment}.tfstate"
}
```

## Next Ideas
- Add diagnostic settings module
- Add networking baseline
- Introduce `locals` for naming conventions
- Implement CI workflow using `terraform fmt -check`, `validate`, `plan`
