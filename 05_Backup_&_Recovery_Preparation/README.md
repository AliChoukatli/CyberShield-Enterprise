# Phase 5. Backup & Recovery Preparation



This step outlines a basic backup and recovery preparation strategy, which can be expanded in production.

## 🔄 Objective

Ensure business continuity in case of system failures or data loss.

## 🧩 Strategy

- For cloud data (e.g. SharePoint, Exchange): Microsoft 365 built-in retention policies.
- For on-prem servers: Use Windows Server Backup or Azure Backup.
- For endpoints: Recommend OneDrive folder redirection and device-based recovery tools.

## ✅ Example Tools

- Azure Backup Vault (for servers or VMs)
- OneDrive + Known Folder Move
- Configuration backup using Intune Export or PowerShell

> 🔍 Note: Full automation and testing of recovery is out of scope for this simulation project.

