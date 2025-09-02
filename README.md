## Latest Updates - 2025-09-02

Summary of recent changes (last 10 commits):

- feat: Added Azure Storage Account and Key Vault Terraform modules (foundation modules).
- feat: Initialized Resource Group module, then restructured module files.
- feat: Added Redis Cache module with dev and prod environment configuration.
- feat: Added AI Coding Agent Guide; removed outdated prompt files to reduce clutter.
- docs: Expanded AI Working Guide and refined security review prompts (now recursive tfsec scan).
- chore: Cleaned up superfluous resource group module files during restructuring.
- fix: Adjusted storage account min_tls_version configuration.

Suggested follow-ups:

- Enforce TLS1_2 (or higher) on storage accounts for stronger security posture.
- Add CI workflow for terraform fmt, validate, and tfsec on PRs.
- Expand this README with full project overview, usage, and contributing guidelines.

#todo