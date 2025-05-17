# ✅ Phase03 – Apply Security and Compliance Policies via Intune

## 🎯 **Objective**  
Manage security baselines and compliance rules to protect devices.


## 🔐 BitLocker Configuration via Intune – Endpoint Protection Policy

## 🎯 Objective
To enforce BitLocker encryption on Windows 10/11 devices using Microsoft Intune, ensuring OS drives are secured and recovery information is safely stored in Azure AD.

---

## ✅ Steps to Configure BitLocker in Intune

### 1. Navigate to Disk Encryption
- Go to: **Intune Admin Center** → **Endpoint security** → **Disk encryption**

### 2. Create a New Policy
- Click **+ Create Policy**
- **Platform**: Windows 10 and later
- **Profile**: Endpoint Protection
- Click **Create**

---
### 3. 🔐 BitLocker Configuration Setting

This guide provides a complete and recommended configuration for enabling and managing BitLocker via Microsoft Intune on Windows 10/11 devices.

---

#### A. Require Device Encryption

| Setting                                      | Recommended Value                                     |
|---------------------------------------------|--------------------------------------------------------|
| Require Device Encryption                   | **Enabled**                                            |
| Allow warning for other disk encryption     | **Enabled**                                            |
| Configure recovery password rotation        | **Refresh on Azure AD joined & Hybrid-Joined Devices** |

---

#### B. BitLocker Drive Encryption Settings

| Setting                                                    | Recommended Value      |
|------------------------------------------------------------|------------------------|
| Choose drive encryption method (OS, Fixed, Removable)      | **Enabled**            |
| Select the encryption method for fixed data drives:        | **XTS-AES 256-bit**    |
| Select the encryption method for operating system drives:  | **XTS-AES 256-bit**    |
| Select the encryption method for removable data drives:    | **XTS-AES 256-bit**    |
---

#### C. Operating System Drives

| Setting                                                              | Recommended Value                                   |
|----------------------------------------------------------------------|-----------------------------------------------------|
| Enforce drive encryption type on OS drives                           | **Enabled** - Full encryption                       |
| Require additional authentication at startup                         | **Enabled**                                         |
| Allow BitLocker without a compatible TPM                             | **True**                                            |
| Configure TPM startup key and PIN                                    | **Do not allow startup key and PIN with TPM**       |
| Configure TPM startup key                                            | **Do not allow statrup key with TPM**               |
| Configure TPM startup PIN                                            | **Require Startup PIN with TPM**                    |
| Configure TPM startup:                                               | **Require TPM**                                     |
| Configure minimum PIN length for startup                             | **Enabled** / **6+ character**                      |
| Allow enhanced PIN                                                   | **Enabled**                                         |
| Disallow standard users from changing PIN or password                | **Disabled**                                        |
| Choose how BitLocker-protected OS drives can be recovered            | **Enabled** - **256-bit key and 48-digit password** |
| Configure storage of recovery info to AD DS                          | **Store Recovery Password and Key Packages**        |
| Do not Enable BitLocker until recovery info is stored to AD DS       | **True**                                            |
| Save BitLocker recovery info to AD DS for OS drives                  | **True**                                            |


---

#### D. Fixed Data Drives

| Setting                                                      | Recommended Value                                   |
|--------------------------------------------------------------|-----------------------------------------------------|
| Enforce drive encryption type                                | **Enabled** - **Full encryption**                   |
| Choose encryption method                                     | **XTS-AES 256-bit**                                 |
| Choose how fixed drives can be recovered                     | **Enabled** - **256-bit key and 48-digit password** |
| Allow data recovery agent                                    | **False**                                           |
| Configure storage of BitLocker recovery info to AD DS        | **Enabled**                                         |
| Deny write access to fixed drives not protected by BitLocker | **Enabled**                                         |
---

#### E. Removables Data Drives

| Setting                                                                  | Recommended Value   |
|--------------------------------------------------------------------------|----------------------|
| Control use of bitlocker on removables drives                            | **Enabled**         | 
| Allow users to apply Bitlocker protection                                | **False**           |
| Enforce drive encryption type on removable data drives                   | **False**           |
| Deny write access to removable drives not protected by BitLocker         | **Enabled**         |     
| Do not Allow Write Access to Devices Confighured in another organization | **True**            | 
---

---

### 4. 🎯 Assignments – BitLocker Policy Deployment Strategy

To ensure a professional and scalable deployment, BitLocker configuration profiles must be assigned properly in Microsoft Intune. Below is the recommended assignment strategy for production-grade environments.

# 🎯 Objective
Create a group to assign your BitLocker policy in Intune.

---

## ✅ Step 1 – Create a Test Group (Recommended for Validation)
1. Go to the Microsoft Entra portal  
2. Left menu → Groups  
3. Click **+ New group**  
4. Choose:  
   - **Group type**: Security  
   - **Group name**: BitLocker-Test-Group  
   - **Description**: BitLocker test group  
   - **Membership type**: Assigned  
5. Add 1 or 2 devices you control (e.g., a personal PC or VM)  
6. Click **Create**

🧪 This group lets you test your BitLocker policy before rolling it out broadly.

---

## ✅ Step 2 – (After Testing) Create a Dynamic Group for All Windows Devices
1. Go back to **Groups** → **New group**  
2. Choose:  
   - **Group type**: Security  
   - **Group name**: All Windows 10/11 Devices  
   - **Membership type**: Dynamic Device  
3. Click **Add dynamic query** and create a rule:  
   - Property: `device.deviceOSType`  
   - Operator: `Equals`  
   - Value: `Windows`  
4. Add another clause:  
   - Property: `device.deviceOSVersion`  
   - Operator: `StartsWith`  
   - Value: `10`  
5. Add another clause:  
   - Property: `device.deviceOSVersion`  
   - Operator: `StartsWith`  
   - Value: `11`  
6. Combine the clauses with **OR** for Windows 10 or 11

Alternatively, use this full KQL rule:

```kql
(device.deviceOSType -eq "Windows") and 
(device.deviceOSVersion -startsWith "10" or device.deviceOSVersion -startsWith "11")
```
7. Click Save, then Create


## ✅ Step 3 – Assign Policy in Intune
In Intune portal → Endpoint security > Disk encryption > your BitLocker policy

Click Assignments

Add groups:

First, assign BitLocker-Test-Group to test

Then, assign All Windows 10/11 Devices after successful validation







---

















---

### 🔐 1. Create and Assign a Security Baseline

1. Go to **Intune Admin Center** → **Endpoint security** → **Security baselines**.
2. Click **+ Create profile**.
3. Choose a baseline (e.g., *Microsoft Defender for Endpoint Baseline*).
4. Configure the settings as needed (password length, screen lock timeout, etc.).
5. Click **Next**, assign to a group (e.g., *All Devices* or a test group).
6. Click **Create**.

📸 **Screenshot to take:**  
- Security baseline configuration page.  
- Assignment summary with targeted group.

---

### 📋 2. Create and Enforce a Compliance Policy

1. Go to **Devices** → **Compliance policies** → **+ Create policy**.
2. Select platform: **Windows 10 and later**.
3. Name the policy (e.g., *Windows Compliance Policy*).
4. Configure rules:
   - Require password.
   - Require encryption (BitLocker).
   - Require antivirus enabled and up to date.
   - Require firewall enabled.
5. Click **Next**, assign the policy to a device group.
6. Click **Create**.

📸 **Screenshots to take:**  
- Each configured setting (password, encryption, antivirus, etc.).  
- Group assignment screen.

---

### 📊 3. Monitor Device Compliance

1. Go to **Devices** → **Monitor** → **Device compliance**.
2. Review compliance status:
   - Count of **compliant / non-compliant** devices.
   - Details of non-compliant reasons (e.g., antivirus not active).

📸 **Screenshots to take:**  
- Compliance summary dashboard.  
- Example of a non-compliant device and details of failure.

---

💡 **Tips**  
You can simulate non-compliance (e.g., by turning off antivirus) to test and generate alerts for your report/demo.

---

➡️ Ready to move to **Step 4 – Configure Device Profiles** when you're done.

