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
- Devices enrolled in Intune (MDM)
- BitLocker configured on all endpoints
  - Deployed via Intune or Group Policy
  - Recovery keys backed up to Azure AD or on-prem AD
- Windows Defender Antivirus and Firewall enabled by default
- Security features configured: Windows Hello, SmartScreen, Exploit Protection
- Device compliance policies created and enforced

---

## ✅ Step 1 – Hybrid Azure AD Join of On-Premises Devices

### 🎯 Objective
Enable domain-joined Windows devices to be automatically registered in Azure AD as **Hybrid Azure AD joined**, allowing for modern device management (Intune, Conditional Access, Defender, etc.).`

### A. Verify On-Prem Domain Join

1. Run the following command on client machines to verify the on-premises domain join status:

```powershell
whoami /fqdn
systeminfo | findstr /i "domain"
```
![whoami-help01](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/03_AzureAD_Sync_%26_Endpoint_Security/Screenshots/whoami-hlp01.png)
![whoami-emp01](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/03_AzureAD_Sync_%26_Endpoint_Security/Screenshots/whoami-emp01.png)

---

### B. Download and Install Azure AD Connect

1. **Download Azure AD Connect** from the [official Microsoft website](https://www.microsoft.com/en-us/download/details.aspx?id=47594)
2. Launch the installer and proceed through the wizard.

---

### C. Azure AD Connect Configuration (Custom)
1. Open **Azure AD Connect** > Click **"Configure"**.
2. Choose **"Customize"**.
3. Select **Password Hash Synchronization**  
   ✅ *Recommended for simplicity and security*.

---

### D. Sign In

1. Sign in with your **Azure AD Global Admin** credentials:  
   *(e.g., admin@corp.aclab.tech)*.

---

### E. Create a Sync Account

Create a dedicated sync account used by Azure AD Connect to synchronize data between on-premises AD and Azure AD:

`corp.aclab.tech\syncadmin`

- Requires permissions to read/write directory data.
- Temporarily add to Domain Admins and Administrators during setup.
- Remove elevated privileges immediately after setup.
- Optionally place in a restricted group (e.g., Azure-AD-Connect) for better management.

This dedicated account improves security and allows better auditing of sync operations.

---

### F. Link Directories

1. Link your directories:
   - Select **"Use Existing Account"** to connect to your on-premises AD forest.
   - Enter the sync account credentials.

2. Once directory validation is complete, click **Next**.

---

### G. Enable Password Writeback and Group Writeback

1. Enable **Password Writeback** and **Group Writeback**:
   - *Recommended to enable these features for hybrid identity management*.

📁 Recommended OU Structure:
```sql
corp.aclab.tech/
└── AzureAD-Groups/
```
![Groupe-writeback](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/03_AzureAD_Sync_%26_Endpoint_Security/Screenshots/Groups-Writeback.png)

---

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

---

### J. Configure Hybrid Azure AD Join (Windows + Azure AD Connect)
1. Launch AzureAD Connect (Entra Connect Sync) and select Configure Device Options.
2. Choose Configure Hybrid Microsoft Entra ID Join.

![Hybrid_Join](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/03_AzureAD_Sync_%26_Endpoint_Security/Screenshots/Hybrid_Join.png)

3. Add your domain (e.g., corp.aclab.tech) and sign in with a Global Administrator account.

4. Apply the configuration to enable automatic device registration in Azure AD.

---

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

---

## L. Entra ID – Device Verification

Once the Hybrid Azure AD Join configuration and device registration GPO are applied, you should verify that your domain-joined devices are correctly registered in Microsoft Entra ID.

### Important Note on Device Ownership

In the **Devices** list, the **Owner** field may display **None** for hybrid Azure AD joined devices. This is normal because:

- Hybrid joined devices are automatically registered without an explicit owner assigned.
- Assigning an owner manually is optional and not required for device management or compliance enforcement.

### How to Verify Device Registration

1. Access the [Microsoft Entra Admin Center](https://entra.microsoft.com/).
2. Navigate to:  
Identity → Devices → All devices
3. Locate your devices and verify the following:
- **Join Type**: `Hybrid Azure AD joined`
- **Registered**: `Date`
- **Owner**: May be `None` (expected)
- **Device Name**: Corresponds to the actual device hostname

![Entra Devices List](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/03_AzureAD_Sync_%26_Endpoint_Security/Screenshots/Entra-Devices.png)

This confirms your devices are successfully registered and managed via Microsoft Entra ID.

---

## ✅ Step 2 – Device Enrollment in Microsoft Intune (MDM)

### 🎯 Objective
Ensure all devices are enrolled in Intune for centralized management, security, and compliance monitoring.

---

### Prerequisites
- Microsoft 365 tenant with Intune licenses assigned (e.g., Business Premium)  
- Devices must be Hybrid Azure AD Joined or Azure AD Joined  
- Network connectivity allowing devices to reach Intune endpoints  
- User accounts with appropriate permissions to enroll devices  

---

### Part 1 – Access the Intune Portal
- Log in to the [Microsoft Endpoint Manager Admin Center](https://endpoint.microsoft.com/)  
- Confirm your admin account has the **Intune Administrator** role or equivalent  

![Intune-Admin](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/03_AzureAD_Sync_%26_Endpoint_Security/Screenshots/intune-admin.png)

---

### Part 2 – Configure Automatic Enrollment
- Navigate to **Devices > Enroll devices > Automatic Enrollment**  
- Enable **MDM user scope** for targeted groups (e.g., All or specific Azure AD groups)  
- Save the configuration  

![Auto-Enrollement](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/03_AzureAD_Sync_%26_Endpoint_Security/Screenshots/auto-enrollement.png)

---

### Part 3 – Prepare Devices for Enrollment
- Ensure devices are Hybrid Azure AD Joined or Azure AD Joined  
- Confirm devices are up to date with Windows Updates  
- Ensure device users have valid Intune licenses assigned  

> **Screenshot optional:**  
> You may include a screenshot of **Azure AD Licenses assigned** to users or a device’s update status for clarity.

---

### Part 4 – Device Enrollment

Before enrolling devices, ensure your Domain Controller’s DNS can resolve internet domain names by configuring DNS forwarders. This step is essential for devices to communicate properly with Azure AD and Microsoft services during enrollment.

**Steps to configure DNS forwarders:**  
1. Open **DNS Manager** on your Domain Controller.  
2. Right-click your server name and select **Properties**.  
3. Go to the **Forwarders** tab.  
4. Add one or more reliable public DNS server IPs, such as:  
   - `8.8.8.8` (Google DNS)  
   - `1.1.1.1` (Cloudflare DNS)  
5. Click **OK** to save the settings.

This setup enables your DNS server to forward unresolved queries to public DNS servers, ensuring smooth device enrollment and uninterrupted internet access.

---

### Part 5 - Device Enrollment

#### Enrolling New Devices (During OOBE)
- When setting up a new device for the first time (Out-of-Box Experience), **sign in with your Azure AD credentials**.
- This will automatically enroll the device into Azure AD and Intune.

#### Enrolling Existing Devices
- Users can manually enroll their existing devices by:  
  1. Opening **Settings**  
  2. Navigating to **Accounts**  
  3. Selecting **Access work or school**  
  4. Clicking **Connect** and signing in with their Azure AD account.

![Enroll Device Screenshot](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/03_AzureAD_Sync_%26_Endpoint_Security/Screenshots/Enroll-Connect.png)

#### Bulk Enrollment (Optional)
- For enrolling multiple devices at once, consider automating enrollment through:  
  - Group Policy for automatic enrollment configuration, or  
  - Provisioning packages for streamlined deployment.

---

> **Note:** If devices fail to enroll, double-check your DNS forwarder settings to ensure connectivity to Azure AD endpoints.


---

### Part 5 – Verify Enrollment Status
- In the Endpoint Manager portal, go to **Devices > All devices**  
- Confirm devices appear with status **Compliant** or **Enrolled**  
- On client devices, run:

```powershell
dsregcmd /status
```

## ✅ Step 3 – Apply Security and Compliance Policies via Intune
🎯 Objective  
Manage security baselines and compliance rules to protect devices.

- Create and assign security policies (password requirements, screen lock, etc.).
- Enforce compliance policies covering antivirus, firewall, encryption status, etc.
- Monitor device compliance through the Intune portal.

---

## ✅ Step 4 – Deploy BitLocker Encryption
🎯 Objective  
Protect data on devices by enabling BitLocker encryption.

- Deploy BitLocker policies via Intune or Group Policy.
- Ensure BitLocker recovery keys are backed up securely to Azure AD or on-premises AD.
- Monitor BitLocker encryption status on devices.

---

## ✅ Step 5 – Enable Windows Defender Antivirus and Firewall
🎯 Objective  
Ensure endpoint protection is active on all devices.

- Configure Windows Defender Antivirus and Firewall via Intune or Group Policy.
- Monitor antivirus status and firewall settings compliance.

---

## ✅ Step 6 – Configure Additional Security Features
🎯 Objective  
Enhance device security with advanced protections.

- Enable Windows Hello for Business.
- Configure SmartScreen filtering.
- Apply Exploit Protection settings through Intune.

---

## ✅ Step 7 – Verify Device Compliance
🎯 Objective  
Confirm all devices meet security standards.

- Create and monitor compliance policies in Intune.
- Verify compliance on key security criteria including encryption, antivirus, firewall, and password policies.

---

