# 🧹 Microsoft Office Removal Script – Purpose & Context

## 🎯 Why This Script?

Removing Microsoft Office isn't always as simple as using “Add or Remove Programs.” Issues often include:
- Leftover files, services, and registry entries
- Corrupted installations that block reinstallation
- Multiple conflicting Office versions (e.g., Office 2016 + M365)
- Incomplete uninstalls via GUI

This [script](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/03_IT_Helpdesk_%26_Network_Troubleshooting/PowerShell_Scripts/msoffice-removal.ps1) resolves those problems using official Microsoft tools and advanced automation.

---

## 🧰 What the Script Does

| Step | Action                                                                                                                                                                          |
|------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| 1    | Displays a banner and asks for confirmation (unless `-Force`)                                                                                                                     |
| 2    | Terminates all running Office apps (Word, Excel, Outlook, etc.)                                                                                                                   |
| 3    | Uninstalls Office using either: <br> • [Microsoft SaRA (Support and Recovery Assistant)](https://aka.ms/SaRA_CommandLineVersionFiles) <br> • Office Deployment Tool + `purge.xml` |
| 4    | Optionally reinstalls Office 365 using `setup.exe` + `upgrade.xml`                                                                                                                |
| 5    | Can automatically reboot the machine (configurable)                                                                                                                               |
| 6    | Tracks progress using Windows Registry to support recovery on reboot                                                                                                              |

---

## ⚙️ Parameters Overview

| Parameter | Description                                                   |
|----------|----------------------------------------------------------------|
| `-InstallOffice365` | Reinstalls Office after removal                     |
| `-UseSetupRemoval`  | Uses `setup.exe` + `purge.xml` instead of SaRA      |
| `-SuppressReboot`   | Skips auto-reboot after removal/install             |
| `-Force`            | Skips user confirmation prompt                      |
| `-RunAgain`         | Ignores previous state and runs full workflow again |
| `-SecondsToReboot`  | Sets reboot delay (default: 60 seconds)             |


> Using Microsoft SaRA or the Office Deployment Tool ensures complete cleanup of registry keys, services, leftover files, and prevents future reinstallation failures.

---

## 🧪 Ideal Use Cases
- PCs where Office refuses to uninstall
- Environments with conflicting versions of Office
- Bulk removal and reinstallation of Office 365
- Intune deployment

---

## 📎 Credits
Script author: **Aaron Viehl (Singleton Factory GmbH)**  
Website: [(https://github.com/Admonstrator/msoffice-removal-tool/blob/main/msoffice-removal-tool.ps1)]

---
