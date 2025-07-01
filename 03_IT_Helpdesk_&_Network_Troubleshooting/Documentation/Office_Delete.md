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

| Step  | Action                                                                     |
|-------|----------------------------------------------------------------------------|
| 1     | Displays an introduction banner and requests confirmation unless forced    |
| 2     | Stops all running Office applications (Word, Excel, Outlook, Teams, etc.)  |
| 3     | Downloads the latest SaRA command-line tool (`SaRAcmd.exe`)                |
| 4     | Runs SaRA in command-line mode to uninstall all Office installations       |
| 5     | Optionally reinstalls Office 365 if requested                              |
| 6     | Optionally triggers a system reboot with a configurable delay              |
| 7     | Tracks progress using Windows Registry keys to allow resuming after reboot |

---

## ⚙️ Parameters Overview

| Parameter           | Description                                         |
|----------===========|-----------------------------------------------------|
| `-InstallOffice365` | Reinstalls Office after removal                     |
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
Author Website: [Aaron Viehl](https://github.com/Admonstrator)

Script : [Script](https://github.com/Admonstrator/msoffice-removal-tool/blob/main/msoffice-removal-tool.ps1)

