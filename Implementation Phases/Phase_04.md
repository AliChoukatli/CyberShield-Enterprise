# Phase 4: AzureAD Sync - Endpoint Security & Device Management 

## Objective
This phase enables you to:
- Hybrid join your on-premises devices to Azure AD
- Manage Windows devices using Microsoft Intune
- Apply security and compliance policies

## Prerequisites
Before you begin, ensure you have:
- A Microsoft 365 account with a license that includes Intune (e.g., Business Premium)
- A local Active Directory domain set up (e.g., `corp.aclab.tech`)
- Your Microsoft account connected to Azure AD (e.g., `corp.aclab.tech.onmicrosoft.com`)
- Azure AD Connect installed and configured (for Hybrid Join scenarios)
- Deploy BitLocker on all endpoints (disk encryption)
  - Configure via GPO or Intune
  - Backup recovery keys in Azure AD or Active Directory
- Enable Windows Defender Antivirus and Firewall by default
- Configure Windows Hello, SmartScreen, Exploit Protection
- Enroll devices in Intune (MDM)
- Ensure device compliance via Device Compliance Policies

---

# Step 1: Hybrid Join of On-Premises Devices to Azure AD

## 🎯 Objective
Enable on-premises domain-joined devices (e.g., `LTP-HLP01`, `LTP-EMP01`) to also join Azure Active Directory (`Hybrid Azure AD Join`). This allows Intune to manage the devices later.

---

## 🧰 Prerequisites
- Active Directory domain: `corp.aclab.tech`
- Azure AD tenant: `corp.aclab.tech.onmicrosoft.com`
- Devices are already joined to the on-prem AD domain
- Azure AD Connect is installed on the domain controller
- Admin access to the Entra portal (`https://entra.microsoft.com`)

---

## 🛠️ Technical Steps

### ✅ 1.1 – Verify On-Prem Domain Join
Run the following on each client machine:

- Verify the fully qualified domain name (FQDN)
```bash
whoami /fqdn
```
- Verify domain membership:
```
systeminfo | findstr /i "domain"
```

![whoami-hlp01](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/Screenshots/Phase%20%204/whoami-hlp01.png)

![whoami-emp01](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/Screenshots/Phase%20%204/whoami-emp01.png)


### ✅ 1.2 – Download and Install Azure AD Connect
- Go to the official [Microsoft page](https://www.microsoft.com/en-us/download/details.aspx?id=47594) for Azure AD Connect: Azure AD Connect - Microsoft.

- Click Download to download the installer.

- Once the download is complete, run the file to start the installation of Azure AD Connect.

- Follow the installation instructions until the tool is ready for configuration.


### ✅ 1.3 – **Configure Azure AD Connect** (Complete and Updated)

#### 1. **Launch Azure AD Connect**:
- Open **Azure AD Connect** on your domain controller.
- Click on **"Configure"**.

#### 2. **Choose "Customize" for Advanced Setup**:
- Select **"Customize"** to have more control over the configuration.
- Click **Next**.

#### 3. **Choose the Sign-In Method**:

- **Select "Password Hash Synchronization (Hash Sync)"** to synchronize your on-premises Active Directory passwords with Azure AD..
  

![Enable-SSO](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/Screenshots/Phase%20%204/enable-sso.png)

#### 4. Specify Azure AD Administrator Username for Synchronization

For Azure AD Connect to authenticate with your Azure AD tenant, specify the **administrator username** associated with your Azure AD account:

- If you have your custom domain (e.g., **corp.aclab.tech**) in Azure AD, use the associated username (e.g., **admin@corp.aclab.tech**).
- If you're still using the default **onmicrosoft.com** domain, use a username like `admin@[yourtenant].onmicrosoft.com`.

This username will be used by Azure AD Connect to synchronize your on-premises Active Directory with Azure AD.

![username-connect](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/Screenshots/Phase%20%204/username-connect.png)

#### 5. Connect Your Directories

At this step, you will link your on-premises Active Directory (`corp.aclab.tech`) with Azure AD using Azure AD Connect.

A. **Create the `sync-admin` account** in Active Directory.
B. **Add `sync-admin` to the following groups**:
   - **Domain Admins** (for initial configuration)
   - **Administrators** (on the Azure AD Connect server)
   
C. Once the initial configuration of Azure AD Connect is complete, remove `syncadmin` from the **Domain Admins** and **Administrators** groups to minimize privileges.
D. Optionally, place the `sync-admin` account in a **Azure-AD-Connect** group with restricted access.

E. **Add Directory**:
   - **Click**: `Add Directory`
   - **Select**: `Use Existing Account` to connect to your on-premises Active Directory forest.
   - **Enter** the credentials of the sync account you just created (e.g., `corp.aclab.tech\syncadmin`).
  
![dir-connect](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/Screenshots/Phase%20%204/dir-connect.png)

F. Once the directory is validated, **click Next** to proceed.
   
#### 6. Select **Conitnue without matching all UPN suffixes to verified domains

#### 7. Choose **"Users are represented only once across all directories".** & **Let Azrure manage the source anchor.
   
![azure-manage](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/Screenshots/Phase%20%204/azure-manage.png)


#### 8. Enable Password Writeback and Group Writeback

- ✅ **Password writeback**
- ✅ **Group writeback**

When prompted to select the **on-premises destination for group writeback**, create or choose an appropriate Organizational Unit (OU) such as `AzureAD-Groups` to store the synced groups from Azure AD.

> 📁 Recommended OU structure:
> ```
> corp.aclab.tech/
> └── AzureAD-Groups/
>     └── [Groups synced from Azure AD]
> ```

This structure ensures proper organization and easier management of cloud-originated groups within your on-premises Active Directory.

![Groups-Writeback](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/Screenshots/Phase%20%204/Groups-Writeback.png)

#### 9. Enable Single Sign-On (SSO)

To enable seamless Single Sign-On for hybrid identities:

- Use a **Domain Admin** credential when prompted.
> 💡 Only accounts with domain-level privileges can configure SSO delegation settings.

#### 10. Launch Synchronization

After reviewing all settings and ensuring the configuration is correct:

- Click **Install** to begin the installation and initial synchronization.
- This process may take several minutes depending on the number of objects in Active Directory.
 - Once the configuration is complete, on the server where **Azure AD Connect** is installed, open PowerShell and run the following command to force synchronization:

```powershell
Start-ADSyncSyncCycle -PolicyType Delta
```
![Sync-Success](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/Screenshots/Phase%20%204/Sync-Success.png)

#### **Notes : The synchronization status can be reviewed via **Synchronization Service Manager** or the **Microsoft Entra admin portal**.


### ✅ 1.4 Verification in Microsoft Entra ID

- Open the [Microsoft Entra admin center](https://entra.microsoft.com)
- Navigate to **Users** 
- Confirm that your on-premises users (e.g., `ali.choukatli@corp.aclab.tech`) appear in the list.

![Users-Sync](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/Screenshots/Phase%20%204/Users-Sync.png)

- Navigate to **Groups** 
- Confirm that your Groups appear in the list.

![Groups-Sync](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/Screenshots/Phase%20%204/Goups-Sync.png)


---





















### ✅ 1.5 – Verify in Entra ID
- Go to: https://entra.microsoft.com

- Navigate to Devices > All Devices.

- Check for devices showing Join Type = Hybrid Azure AD joined.

📸 Screenshot to capture: The table listing your joined device(s) with "Hybrid Azure AD joined".
---

## Step 2: Manage Devices Using Microsoft Intune

### Objective
Intune allows you to manage security and compliance on your Windows devices.

### Prerequisites
- You need a Microsoft 365 license with Intune enabled.

### Actions
1. Log in to **Microsoft Intune** through the **Azure portal**.
2. Register your Windows devices in **Intune** either through automatic enrollment or manually adding the devices.
3. Ensure the devices are enrolled in **MDM** (Mobile Device Management).

---

## Step 3: Apply Security and Compliance Policies

### Objective
Apply necessary policies to secure and ensure the compliance of your devices.

### Actions
1. Create **security policies** in Intune (e.g., password policies, screen lock settings).
2. Apply **compliance policies** on the Windows devices to ensure they meet the defined security criteria.

---

## Step 4: Deploy BitLocker on Endpoints

### Objective
Encrypt the disks of the devices with **BitLocker**.

### Actions
1. Use **Intune** or **GPO** to deploy BitLocker on all endpoints.
2. Ensure the BitLocker recovery keys are backed up in **Azure AD** or **Active Directory**.

---

## Step 5: Enable Windows Defender Antivirus and Firewall

### Objective
Ensure that **Windows Defender Antivirus** and the firewall are enabled by default on all devices.

### Actions
1. Configure **Windows Defender Antivirus** and **the firewall** through **Intune** or **GPO** to ensure they are enabled on all devices.

---

## Step 6: Configure Windows Hello, SmartScreen, and Exploit Protection

### Objective
Enable additional security features such as Windows Hello, SmartScreen, and Exploit Protection.

### Actions
1. Configure **Windows Hello**, **SmartScreen**, and **Exploit Protection** features within **Intune**.

---

## Step 7: Enroll Devices in Intune (MDM)

### Objective
Ensure that all devices are enrolled in **Intune** for management.

### Actions
1. Enroll devices into **Intune** via **MDM** (Mobile Device Management) to ensure they are properly managed.

---

## Step 8: Verify Device Compliance (Device Compliance Policies)

### Objective
Ensure that the devices comply with the defined compliance policies.

### Actions
1. Configure **Device Compliance Policies** in Intune and verify that all devices are in compliance.
2. Ensure that devices meet the necessary security standards, such as password length, encryption, and anti-virus settings.


