# Phase 4: Endpoint Security & Device Management 

## Objective
This phase enables you to:
- Hybrid join your on-premises devices to Azure AD
- Manage Windows devices using Microsoft Intune
- Apply security and compliance policies

## Prerequisites
Before you begin, ensure you have:
- A Microsoft 365 account with a license that includes Intune (e.g., Business Premium)
- A local Active Directory domain set up (e.g., `acpracticelab.local`)
- Your Microsoft account connected to Azure AD (e.g., `acpracticelab.onmicrosoft.com`)
- Azure AD Connect installed and configured (for Hybrid Join scenarios)
- Deploy BitLocker on all endpoints (disk encryption)
  - Configure via GPO or Intune
  - Backup recovery keys in Azure AD or Active Directory
- Enable Windows Defender Antivirus and Firewall by default
- Configure Windows Hello, SmartScreen, Exploit Protection
- Enroll devices in Intune (MDM)
- Ensure device compliance via Device Compliance Policies

---

## Step 1: Hybrid Join Your Devices to Azure AD

### Objective
Hybrid join allows your on-premises devices to connect to Azure AD.

### Prerequisites
- Azure AD Connect must be installed and configured for Hybrid Join.

### Actions
1. Open **Azure AD Connect** and ensure the synchronization is correctly configured for Hybrid Join.
2. Verify that on-premises devices are set to join Azure AD in a hybrid configuration.
3. Test Hybrid Join on an on-premises device using the **dsregcmd** tool.

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


