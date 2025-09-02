# AI Coding Agent Guide

Purpose: Enable rapid, consistent contributions to this Terraform Azure infra boilerplate.
Keep answers specific; prefer editing files directly over generic advice.

## Big Picture
- Single domain: provisioning Azure core infra (RGs, Storage Accounts, Key Vaults) via Terraform 1.6+.
- Layered layout: root orchestrates versioned provider + environment-specific variable maps feeding composable modules under `terraform/modules/*`.
- Environments are isolated by passing a single `-var-file=env/<env>.tfvars`; no workspaces currently used.
- Tagging strategy centralized: locals merge `global_tags` + `environment` + per-object `tags` before passing to modules.

## Key Directories / Files
- `terraform/providers.tf` – pins required versions (Terraform >=1.6, azurerm >=3.100). Add new providers here only.
- `terraform/variables.tf` – canonical contract for root inputs. Maintain optional() defaults pattern.
- `terraform/main.tf` – orchestration: builds merged locals, then `for_each` module instantiation; new resource types should follow same pattern (local merge + module call + consolidated outputs when useful).
- `terraform/env/*.tfvars` – authoritative env definitions. Don't hardcode env-specific values elsewhere.
- `terraform/modules/*` – one logical Azure resource each. Keep: `main.tf`, `variables.tf`, `outputs.tf`; inputs minimal, no hidden data sources unless justified.

## Conventions / Patterns
- Module folder naming is numeric-padded for ordering (e.g. `01_`, `02_`). Preserve sequence when inserting new modules; pick next number.
- Module variable names mirror Azure resource argument names for clarity (e.g. `resource_group_name`).
- Tag merging happens ONLY in root locals; modules accept final `tags` map verbatim.
- Cross-module linkage via keys: higher-level maps use a synthetic key (`core`) whose value includes `resource_group_key`; resolving happens in `main.tf` using `module.resource_groups[each.value.resource_group_key]`.
- Sensitive outputs (keys, connection strings) explicitly flagged `sensitive = true` (see storage module). Follow that for secrets.
- Use `for_each` over `count` for map-driven resources to enable stable addressing.
- Access policies for Key Vault use a `dynamic` block iterating provided list; replicate this style for future collection-based nested blocks (e.g. network_acls).

## Typical Workflow
```pwsh
cd terraform
terraform init
terraform plan -var-file=env/dev.tfvars
terraform apply -var-file=env/dev.tfvars
```
Adjust file to `prod.tfvars` for production. Avoid mixing manual variable flags with tfvars files.

## Adding a New Resource Type
1. Create `terraform/modules/NN_<short_name>/` with `main.tf`, `variables.tf`, `outputs.tf`.
2. Expose minimal required variables; default optional ones using Terraform defaults (or `optional()` in root variable object if map-driven).
3. Add a new root variable map (e.g. `variable "subnets" { type = map(object({ ... })) }`). Provide `default = {}` if optional.
4. In `locals {}` create `merged_<plural>` applying the tag merge pattern.
5. Add a `module` block with `for_each = local.merged_<plural>` mirroring existing modules.
6. Export aggregate outputs (list or map of names/ids) only if they add reuse value.

## Safe Change Guidelines
- Before altering provider version constraints, ensure compatibility with existing azurerm arguments.
- When introducing breaking input changes, make them additive first (new variable) then deprecate; document in `terraform/README.md`.
- Never embed environment literal strings inside modules; always feed via variables.
- Keep resource names deterministic (no randomness) to avoid drift across plans.

## Testing / Validation
- Run `terraform fmt -check` and `terraform validate` after structural changes.
- Prefer `terraform plan -var-file=env/dev.tfvars` as quick regression check.

## Secrets & Sensitive Data
- Only the root or modules output sensitive values with `sensitive = true`; do not print them in logs or README examples.
- Key Vault access policies should reference object IDs provided in tfvars; do not hardcode GUIDs in module code.

## Extensibility Examples
- To add diagnostics or logging: create a diagnostics module; accept target resource IDs as inputs rather than reaching into other modules' internals.
- For remote state: add backend block inside existing `terraform {}` (documented in `terraform/README.md`), not a separate file.

## When Unsure
- Prefer reading existing module patterns before inventing new structures.
- Surface ambiguities (e.g. naming standards, networking strategy) as TODO comments near the related code instead of guessing.

## Out of Scope
- No CI/CD workflows or tests exist yet—do not reference pipelines unless adding one.

Provide diffs only; avoid restating whole files unless required.
