# Phase 4: Endpoint Security & Device Management 

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
  

📸 **Screenshot to capture**: The screen where you select the **Sign-In Method** (Hash Sync, AD FS, etc.).

#### 4. **Configure Device Options**:
- Click on **"Configure device options"**.
- Continue until you reach the **Device options** section.

#### 5. **Enable Hybrid Azure AD Join**:
- Select **"Configure Hybrid Azure AD Join"**. This is where you configure the Hybrid Azure AD Join for your on-premises Active Directory to Azure AD.

📸 **Screenshot to capture**: The screen where **"Configure Hybrid Azure AD Join"** is selected.

#### 6. **Specify the Devices to Sync**:
- Select **Windows 10 or later domain-joined devices** to specify that you want to join Windows 10 or newer devices to Azure AD.
- Choose your local domain **corp.aclab.tech**.

📸 **Screenshot to capture**: The screen where you select your domain **corp.aclab.tech**.

#### 7. **Configure and Force Synchronization**:
- Click **Next**, then **Configure** to finalize the configuration.
- Once the configuration is complete, on the server where **Azure AD Connect** is installed, open PowerShell and run the following command to force synchronization:

```powershell
Start-ADSyncSyncCycle -PolicyType Delta
```
📸 Screenshot to capture: The output of the PowerShell sync command.

8. Verify in Entra ID (Azure AD):
- Go to https://entra.microsoft.com.

- Navigate to Devices > All Devices.

- Check that your devices are listed with Join Type = Hybrid Azure AD joined.

📸 Screenshot to capture: The table showing your devices with Hybrid Azure AD joined.

### ✅ 1.4 – Specify Local Domain
- Select Windows 10 or later domain-joined devices.

- Choose your local domain: `corp.aclab.tech`

- Click Next, then click Configure.

📸 Screenshot to capture: The domain selection screen showing corp.aclab.tech.

### ✅ 1.5 – Force a Synchronization
On the server with Azure AD Connect, run the following PowerShell command:
```powershell
Start-ADSyncSyncCycle -PolicyType Delta
```
📸 Screenshot to capture: The output of the PowerShell sync command.

### ✅ 1.6 – Verify in Entra ID
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


