## AI Working Guide for This Repo (Terraform Azure Boilerplate)

Purpose: Enable fast, safe Terraform changes for a layered Azure infrastructure baseline. Keep edits minimal, composable, and map-driven.

### 1. Big Picture Architecture
- Root `terraform/` orchestrates modules via map variables + `for_each` (stable addressing). 3 core modules: resource groups, storage accounts, key vaults.
- Environments are data-only: `env/dev.tfvars`, `env/prod.tfvars` feed maps (resource_groups, storage_accounts, key_vaults).
- Tag & config normalization happens in `locals` (`main.tf`): merges `global_tags` + `{ environment = var.environment }` + per‑resource tags before passing to modules.
- Cross-module linkage uses logical map keys (e.g. `storage_accounts.core.resource_group_key = "core"`) then resolved with `module.resource_groups[each.value.resource_group_key].name`.

### 2. Key Conventions
- Module folders numbered (`01_`, `02_`, `03_`) for human ordering; keep naming when adding new modules.
- Input maps drive multiplicity; prefer extending maps over duplicating module blocks.
- Always keep provider constraint (`providers.tf`) and feature block untouched unless upgrading intentionally.
- Sensitive outputs (storage access keys / connection strings) already marked `sensitive = true`; do not print them in added examples or logs.
- Use lowercase, globally unique names where Azure requires (storage, key vault). Example: `stdevcore001`, `kv-prod-core-001`.

### 3. Typical Workflows
- Init & plan (dev): `terraform init && terraform plan -var-file=env/dev.tfvars` inside `terraform/`.
- Apply: `terraform apply -var-file=env/dev.tfvars` (swap to `prod.tfvars` for prod). Avoid editing tfvars inline; change maps instead.
- Validation before commit: run `terraform fmt -check` then `terraform validate` then a `plan` for each changed environment.
- (Optional) Remote state: add backend block (see `terraform/README.md`) only once a storage account exists; do not auto-add if absent.

### 4. Adding a New Resource Type (Pattern)
1. Create `terraform/modules/NN_<type>/` with `main.tf`, `variables.tf`, `outputs.tf` minimal pattern matching existing modules.
2. Add a new root variable map (e.g. `variable "<type_plural>" { type = map(object({ ... })) }`).
3. In `main.tf` add a `local.merged_<type_plural>` applying the consistent tag merge pattern.
4. Add a `module "<type_plural>"` block with `for_each = local.merged_<type_plural>`.
5. Extend env `*.tfvars` maps—never hardcode environment logic in module code.

### 5. Editing Existing Resources
- To add an instance: append a new key entry in the appropriate map within `env/<env>.tfvars` + any needed map in root `variables.tf` (if new type).
- To change tags: modify only the per-resource `tags` map; global tagging is centralized.
- To change replication or SKU: update that resource's map entry; no module code change required if variable already exists.

### 6. Cross-Cutting Patterns
- Tag Merge Formula (replicate exactly): `merge(var.global_tags, { environment = var.environment }, <resource>.tags)`.
- Resource dependency indirection: never hardcode names—always derive via module outputs (e.g. `module.resource_groups[each.value.resource_group_key].name`).
- Keep `for_each` (not `count`) to preserve state alignment with logical keys.

### 7. Safe Upgrade Guidelines
- Provider upgrade: adjust version in `providers.tf`, run `terraform init -upgrade`, inspect plan for all environments.
- Module addition: prefer incremental commit containing only new module + map wiring + sample tfvars entries.

### 8. What NOT to Do
- Do not echo sensitive outputs or remove `sensitive = true` flags.
- Do not inline environment-specific conditionals inside modules; all env variance lives in tfvars maps.
- Do not rename existing map keys casually—this forces recreation; add new keys instead and deprecate old ones explicitly.

### 9. Quick Example: Adding Another Storage Account (dev only)
Add to `env/dev.tfvars` under `storage_accounts`:
```
  logs = {
    name               = "stdevlogs001"
    resource_group_key = "core"
    account_replication_type = "ZRS"
    tags = { workload = "logs" }
  }
```
Run plan with dev tfvars; no root code change needed.

---
If any convention above seems missing or ambiguous, request clarification before generating large refactors.