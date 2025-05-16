# Phase 3 – Azure AD Sync & Endpoint Security

## 🎯 Objective

This phase enables you to:

1. Hybrid join your on-premises devices to Azure AD  
2. Manage Windows devices using Microsoft Intune  
3. Apply security and compliance policies  

---

## ✅ Prerequisites

Before getting started, ensure the following:

- A Microsoft 365 account with a license including Intune (e.g., Business Premium)
- On-premises Active Directory domain (e.g., `corp.aclab.tech`)
- Azure AD tenant linked to your domain (e.g., `corp.aclab.tech.onmicrosoft.com`)
- Azure AD Connect installed and configured
- BitLocker configured on all endpoints
  - Deployed via Intune or Group Policy
  - Recovery keys backed up to Azure AD or on-prem AD
- Windows Defender Antivirus and Firewall enabled by default
- Security features configured: Windows Hello, SmartScreen, Exploit Protection
- Devices enrolled in Intune (MDM)
- Device compliance policies created and enforced

---

## ✅ Step 1 – Hybrid Azure AD Join of On-Premises Devices

Enable domain-joined Windows devices to be automatically registered in Azure AD as **Hybrid Azure AD joined**, allowing for modern device management (Intune, Conditional Access, Defender, etc.).`

### A. Verify On-Prem Domain Join

1. Run the following command on client machines to verify the on-premises domain join status:

```powershell
whoami /fqdn
systeminfo | findstr /i "domain"
```
![whoami-help01](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/03_AzureAD_Sync_%26_Endpoint_Security/Screenshots/whoami-hlp01.png)
![whoami-emp01](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/03_AzureAD_Sync_%26_Endpoint_Security/Screenshots/whoami-emp01.png)


### B. Download and Install Azure AD Connect

1. **Download Azure AD Connect** from the official Microsoft website.
2. Launch the installer and proceed through the wizard.


### C. Azure AD Connect Configuration (Custom)
1. Open **Azure AD Connect** > Click **"Configure"**.
2. Choose **"Customize"**.
3. Select **Password Hash Synchronization**  
   ✅ *Recommended for simplicity and security*.


### D. Sign In

1. Sign in with your **Azure AD Global Admin** credentials:  
   *(e.g., admin@corp.aclab.tech)*.


### E. Create a Sync Account

1. Create a sync account:  
   `corp.aclab.tech\syncadmin`

   - Temporarily add to **Domain Admins** and **Administrators** groups.
   - Remove privileges after setup.
   - Optionally place in a restricted group (e.g., **Azure-AD-Connect**).


### F. Link Directories

1. Link your directories:
   - Select **"Use Existing Account"** to connect to your on-premises AD forest.
   - Enter the sync account credentials.

2. Once directory validation is complete, click **Next**.


### G. Enable Password Writeback and Group Writeback

1. Enable **Password Writeback** and **Group Writeback**:
   - *Recommended to enable these features for hybrid identity management*.

📁 Recommended OU Structure:

```sql
corp.aclab.tech/
└── AzureAD-Groups/
```
![Groupe-writeback](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/03_AzureAD_Sync_%26_Endpoint_Security/Screenshots/Groups-Writeback.png)


### H. Enable Single Sign-On (SSO) for Seamless Login Experience

1. Enable **Single Sign-On (SSO)** for a seamless login experience.

   💡 *Only Domain Admin privileges are required for configuring SSO delegation*.

---

### I. Start the Installation and Synchronization Process

1. After reviewing the settings, click **Install** to begin synchronization.
2. Once complete, run the following PowerShell command to force a delta sync:

   ```powershell
   Start-ADSyncSyncCycle -PolicyType Delta
   ```
![Sync_Success](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/03_AzureAD_Sync_%26_Endpoint_Security/Screenshots/Sync-Success.png)


### J. Configure Hybrid Azure AD Join (Windows + Azure AD Connect)
1. Launch AzureAD Connect (Entra Connect Sync) and select Configure Device Options.
2. Choose Configure Hybrid Microsoft Entra ID Join.

![Hybrid_Join](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/03_AzureAD_Sync_%26_Endpoint_Security/Screenshots/Hybrid_Join.png)

3. Add your domain (e.g., corp.aclab.tech) and sign in with a Global Administrator account.

4. Apply the configuration to enable automatic device registration in Azure AD.

### K. Configure Hybrid Azure AD Join with Auto Device Registration GPO

1. Open the **Group Policy Management Console** (`gpmc.msc`).

2. Locate and **edit your existing “Auto Device Registration” GPO** linked to the OU containing your target machines (e.g., `Devices`).

---

#### K.1 - Enable Automatic Device Registration

- Navigate to:  
  `Computer Configuration` → `Administrative Templates` → `Windows Components` → `Device Registration`

- Double-click **Register domain-joined computers as devices** and set it to **Enabled**.
  
![Auto-Device-REG](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/03_AzureAD_Sync_%26_Endpoint_Security/Screenshots/Auto-Device_Registration-GPO.png)
  
---

#### K.2 - Add Scheduled Task to Force Hybrid Azure AD Join

- Navigate to:  
  `Computer Configuration` → `Preferences` → `Control Panel Settings` → **Scheduled Tasks**

- Right-click → **New** → **Scheduled Task (Windows Vista and later)**

- Configure the scheduled task as follows:

| Field                       | Value                 |
|-----------------------------|-----------------------|
| **Name**                    | HybridAzureADJoin     |
| **Action**                  | Create                |
| **Run as user**             | SYSTEM                |
| **Trigger**                 | At startup            |
| **Program/script**          | `dsregcmd.exe`        |
| **Arguments**               | `/join`               |
| **Run with highest privileges** | Checked          |

- Click **OK** to save.

![Join-Task](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/03_AzureAD_Sync_%26_Endpoint_Security/Screenshots/Join-Task.png)

---

#### K.3 - Apply and Validate

Apply the GPO and force an update on client devices:
```bash
gpupdate /force
```
6. Validate the device registration with the following command:
```bash
dsregcmd /status
```

![dsreg-Status](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/03_AzureAD_Sync_%26_Endpoint_Security/Screenshots/dsregcmd_status_emp01.png)


## ✅ Step 2 – Device Management Using Microsoft Intune
🎯 Objective
Manage Windows devices through Microsoft Intune for security and compliance.

1. Log in to Microsoft Intune via the Azure Portal.

2. Ensure all devices are enrolled for management (MDM).

3. Apply security policies (e.g., password requirements, screen lock, etc.).

4. Monitor compliance policies and manage device health.
---

## ✅ Step 3 – Apply Security and Compliance Policies
🎯 Objective
Enforce security policies and ensure device compliance.

1. Create and assign security policies (e.g., password, encryption settings).

2. Apply compliance policies to enforce required standards, such as antivirus, firewall, and disk encryption.
---

## ✅ Step 4 – Deploy BitLocker on Endpoints
🎯 Objective
Encrypt all devices using BitLocker for data protection.

1. Deploy BitLocker via Intune or Group Policy.
2. Ensure recovery keys are backed up to Azure AD or Active Directory.
---

## ✅ Step 5 – Enable Windows Defender Antivirus and Firewall
🎯 Objective
Ensure Windows Defender Antivirus and Firewall are enabled by default on all devices.

1. Configure Windows Defender Antivirus and Firewall settings through Intune or Group Policy.
---

# ✅ Step 6 – Configure Windows Hello, SmartScreen, and Exploit Protection
🎯 Objective
Enhance security by enabling Windows Hello, SmartScreen, and Exploit Protection.

1. Configure Windows Hello, SmartScreen, and Exploit Protection within Intune for added device security.

# ✅Step 6 – Configure Windows Hello, SmartScreen, and Exploit Protection
# Step 7 – Enroll Devices in Intune (MDM)
🎯 Objective
Ensure all devices are enrolled in Intune for ongoing management.

1. Enroll devices via MDM (Mobile Device Management) to ensure consistent management and monitoring.

# ✅Step 6 – Configure Windows Hello, SmartScreen, and Exploit Protection
# Step 8 – Verify Device Compliance
🎯 Objective
Verify that all devices are compliant with the defined security standards.

1. Create and monitor Device Compliance Policies in Intune.

2. Verify compliance for devices across all security criteria, including password complexity, encryption, and antivirus settings.

























