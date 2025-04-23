# Support IT - Small Business Simulation

## 📝 Overview
This section of the project focuses on IT support activities such as Active Directory management, device troubleshooting, and PowerShell scripting for automation. It simulates common tasks that an IT support technician might perform in a small business environment.

---

## 🔧 Key Tasks

- **Day 1 - Installation & Configuration of Active Directory (AD):** Setup AD, create users and groups, and synchronize with Azure AD.
- **Day 2 - Endpoint Security & Device Management:** Use Intune for device management, configure BitLocker, and deploy Office 365.
- **Day 3 - Remote Support & Troubleshooting:** Use TeamViewer, Remote Desktop, and Windows Network Troubleshooter to resolve IT issues.
- **Day 4 - PowerShell Automation:** Automate tasks like Office 365 deployment, user password reset, and endpoint security status checks.

---

## 📂 Project Structure

The structure of the **Support_IT** section is organized as follows:

```
Support_IT/
├── Day1_Installation_AD/                  # Initial server and AD configuration
│   ├── 01_m365_admin_dashboard.png        # Microsoft 365 Admin Dashboard
│   ├── 02_windows_server_install.png      # Windows Server installation
│   ├── 03_ad_users_creation.png           # User creation in AD
│   ├── 04_azure_ad_overview.png           # Azure AD Overview
│   ├── 05_intune_enrollment.png           # Intune device enrollment
│   └── README.md                          # Day 1 Guide
├── PowerShell_Scripts/                    # Automation and support scripts
│   ├── DeployOffice365.ps1                # Silent install for Office 365
│   ├── Reset-UserPassword.ps1             # Reset user password in AD
│   └── Get-SecurityStatus.ps1             # Check endpoint security status
└── Screenshots/                           # Screenshots alongside tasks
    ├── 01_AD_User_Creation.png            # User creation step screenshot
    ├── 02_Group_Management.png            # Group management screenshot
    ├── 03_Password_Reset_AD.png           # Password reset in AD
    ├── 04_AD_Permissions_Management.png   # AD permissions management
    ├── 05_Remote_Support_TeamViewer.png   # TeamViewer usage screenshot
    ├── 06_Remote_Desktop_Session.png      # Remote Desktop session screenshot
    ├── 07_Device_Manager_Troubleshooting.png # Device manager screenshot
    ├── 08_Windows_Network_Troubleshooter.png # Network troubleshooting screenshot
    ├── 09_CMD_Ping_Test.png               # CMD Ping test screenshot
    └── 10_CMD_Ipconfig_Results.png        # CMD Ipconfig results screenshot
```
## 🛠️ Setup Instructions
Day 1: Installation & Configuration of Active Directory

**Step 1:** Install Windows Server on a VM.

Follow the guide in 02_windows_server_install.png.

**Step 2:** Set up Active Directory (AD).

Create users and groups following the screenshots provided in 03_ad_users_creation.png.

*Step 3:** Configure Azure AD synchronization for hybrid identity.

Check the Azure AD overview in 04_azure_ad_overview.png.

**Step 4:** Enroll devices into Intune for mobile and device management.

Refer to 05_intune_enrollment.png for setup instructions.

## ⚡ PowerShell Scripts
DeployOffice365.ps1
This script will silently install Office 365 on managed devices.

Usage:

Open PowerShell as Administrator.

Run the script using the command:.\DeployOffice365.ps1

Reset-UserPassword.ps1
This script resets the password of a specified Active Directory user.

Usage:

Run the script and provide the username whose password needs to be reset.

Get-SecurityStatus.ps1
This script checks the endpoint security status of devices using Intune and Defender.

📸 Screenshots
Screenshots are included for each significant task, such as:

User creation in AD

Group management

Remote support actions

For example, see 01_AD_User_Creation.png for user creation details.

🛠️ Required Tools
Windows Server 2022 or later

Microsoft 365 Business Premium (includes Intune, Azure AD P1)

PowerShell for script execution

Remote support tools (e.g., TeamViewer, RDP)

## 📅 Future Updates
Integration with Microsoft Sentinel for Threat Detection

Additional PowerShell scripts for system management

## 👤 Author & Contributions
Author: [Your Name]

Email: [Your Email]

GitHub: [Your GitHub Profile]

## 📝 License
This project is licensed under the MIT License - see the LICENSE.md file for details.

Explications :
Overview : Donne une idée générale de ce que fait la section.

Key Tasks : Liste des tâches réalisées dans cette section.

Project Structure : Une vue d'ensemble de l'organisation du dossier, avec des liens vers les fichiers importants.

Setup Instructions : Des instructions étape par étape sur comment configurer et utiliser les ressources de cette section.

PowerShell Scripts : Explique chaque script dans la section PowerShell.

Screenshots : Fait référence aux captures d'écran pour que l'utilisateur puisse voir les résultats visuels des étapes.

Required Tools : Liste des prérequis nécessaires pour suivre les étapes.

Future Updates : Mentionne ce qui pourrait être ajouté dans les mises à jour futures.

