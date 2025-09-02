# Terraform Azure Boilerplate

Layered, environment-driven structure inspired by Azure-Terraform-Deployments.

## Structure
```
terraform/
  providers.tf                # Required providers + azurerm
  variables.tf                # Root input variables
  main.tf                     # Orchestrates modules (resource groups, storage, key vault)
  outputs.tf                  # Root outputs
  modules/
    01_resource_group/        # Resource group module
    02_az_storage/            # Storage account module
    03_az_key_vault/          # Key vault module
  env/
    dev.tfvars                # Dev environment values
    prod.tfvars               # Prod environment values
```

## Usage
```pwsh
cd terraform
terraform init
terraform plan -var-file=env/dev.tfvars
terraform apply -var-file=env/dev.tfvars
```
Swap `dev.tfvars` for `prod.tfvars` to target prod.

## Modules

### 01_resource_group
Creates Azure resource groups with configurable tags.

### 02_az_storage
Creates Azure storage accounts with configurable tier and replication settings.

### 03_az_key_vault
Creates Azure key vaults with configurable SKU and access policies.

## Extend
1. Create new module under `modules/<name>`.
2. Add a map entry or variables for that resource.
3. Reference via `module` block with `for_each` if multiple.

## Tagging Strategy
Global tags + environment tag + per-resource tags merged in local values.

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
