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

```plaintext
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
