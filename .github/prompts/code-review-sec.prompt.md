---
mode: agent
tools: ['codebase', 'githubRepo', 'editFiles', 'runCommands', 'github']
description: 'Perform a Terraform security and code quality review on the provided code.'
---
Perform a Terraform security and code quality review:
* Check the provided Terraform code for security best practices by running 'tfsec' recursively over all terraform files in the project as a CLI in the terminal. Give a summary of the findings in JSON.
* For any security issues create a github issue on this projects repo for @Pwd9000-ML with the issue title prefixed 🚨 [CRITICAL SECURITY].