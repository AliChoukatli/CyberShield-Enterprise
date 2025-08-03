# 07 - Windows Autopilot (Modern Deployment Lab)

## 🎯 Objective

Simulate a modern Windows 11 deployment using **Windows Autopilot** and **Microsoft Intune**, without relying on on-premises infrastructure. This lab demonstrates how to register a device for Autopilot, create and assign deployment profiles, and trigger an automatic enrollment during the device’s Out-of-Box Experience (OOBE).

---

## 🧰 Prerequisites

| Component | Details |
|----------|---------|
| ✅ Microsoft 365 E5 Developer tenant | Created from [developer.microsoft.com](https://developer.microsoft.com/en-us/microsoft-365/dev-program) |
| ✅ Intune enabled | Check access via [https://endpoint.microsoft.com](https://endpoint.microsoft.com) |
| ✅ Windows 11 VM (Pro or Enterprise) | Installed using official evaluation ISO |
| ✅ PowerShell Admin on the VM | Required to extract the Hardware Hash (HWID) |

---

## 🧱 Folder Structure

```bash
07_Autopilot/
├── README.md
├── captures/
│   ├── 1-tenant-created.png
│   ├── 2-profile-creation-1.png
│   ├── 3-profile-creation-2.png
│   ├── 4-powershell-hwid.png
│   ├── 5-import-device.png
│   ├── 6-device-imported.png
│   ├── 7-assign-profile.png
│   ├── 8-oobe-start.png (optional)
│   └── 9-intune-autoconfig.png (optional)
└── scripts/
    └── Get-WindowsAutopilotInfo.ps1
