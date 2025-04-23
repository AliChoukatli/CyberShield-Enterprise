# 🛠️ Support IT – Active Directory & Remote Helpdesk

This module simulates the role of an IT technician responsible for user management, remote support, and basic troubleshooting through PowerShell. It fits within the context of a small business with 25 employees, focused on security and efficiency.

---

## 📌 Objectives

- Create and manage users via Active Directory (AD)
- Reset user passwords as needed
- Manage groups and file permissions
- Provide remote support via RDP and TeamViewer
- Troubleshoot basic network and system issues
- Automate common tasks with PowerShell scripts

---

## 📂 Folder Contents

| File/Folder                        | Description |
|-----------------------------------|-------------|
| `PowerShell_Scripts/`             | PowerShell automation scripts (Office install, Password Reset, Security Check) |
| `01_AD_User_Creation.png`         | Creating a user in AD |
| `02_Group_Management.png`         | Adding a user to a group |
| `03_Password_Reset_AD.png`        | Resetting a password in AD |
| `04_AD_Permissions_Management.png`| Managing file/folder permissions |
| `05_Remote_Support_TeamViewer.png`| Providing remote support using TeamViewer |
| `06_Remote_Desktop_Session.png`   | Connecting to a remote machine using RDP |
| `07_Device_Manager_Troubleshooting.png` | Troubleshooting via Device Manager |
| `08_Windows_Network_Troubleshooter.png` | Using Windows Network Troubleshooter |
| `09_CMD_Ping_Test.png`            | Testing connectivity with `ping` |
| `10_CMD_Ipconfig_Results.png`     | Network status with `ipconfig` |

---

## ⚙️ PowerShell Scripts

### ▶️ `DeployOffice365.ps1`

Installs Microsoft 365 silently via PowerShell.

```powershell
Start-Process "https://aka.ms/office-install" -Wait

