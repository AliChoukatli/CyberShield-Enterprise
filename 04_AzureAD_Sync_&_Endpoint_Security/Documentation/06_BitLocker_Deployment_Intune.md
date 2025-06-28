# 🔐 BitLocker Deployment via Microsoft Intune

## 🎯 Objective

Establish a professional and secure deployment of BitLocker encryption across Windows devices using Microsoft Intune. This ensures enterprise-grade data protection, compliance with security standards, and operational reliability for both Azure AD joined and Hybrid-joined devices.

---

## 📝 Introduction

BitLocker is a critical technology for protecting data at rest on Windows devices through full disk encryption. Deploying BitLocker via Intune allows centralized management and enforcement of encryption policies. This guide details the step-by-step process to create, test, and assign BitLocker policies, ensuring a smooth and controlled rollout in your organization.

---

## 🔧 Prerequisites
- Microsoft Intune configured and licensed
- Devices Azure AD joined or Hybrid-joined
- Admin access to Intune and Entra Admin Center
---

## 📋 Table of Contents
- [📦 Step 1 – Test Group](#-step-1--test-group)
- [📦 Step 2 – Create a Dynamic Group](#-step-2--create-a-dynamic-group-for-windows-1011-devices)
- [📦 Step 3 – Configure BitLocker Policy in Intune](#-step-3---configure-bitlocker-policy-in-intune)
- [📦 Step 4 – Assign the Policy in Intune](#-step-4---assign-the-policy-in-intune)
---

### 📦 Step 1 – Test Group

1. Go to **Microsoft Entra Admin Center** → **Groups**  
2. Click **+ New group**, then configure:
   - **Group type**: Security  
   - **Group name**: `BitLocker-Test-Group`  
   - **Description**: Testing BitLocker policy deployment  
   - **Membership type**: Assigned  
3. Add 1–2 test devices (e.g., a VM or a controlled PC)  
4. Click **Create**

#### 💡 *Use this group to safely validate and troubleshoot your BitLocker policy before full deployment.*
---

### 📦 Step 2 – Create a Dynamic Group for Windows 10/11 Devices

1. Return to **Groups** > **New group**
2. Select:

   * **Group type**: Security
   * **Group name**: `Windows 10/11 Devices`
   * **Membership type**: Dynamic Device
3. Click **Add dynamic query**
4. Define the rule with the following properties:

![Windows-Device-Group](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/03_AzureAD_Sync_%26_Endpoint_Security/Screenshots/Windows-Device-Group.png)

5. Click **Save** > **Create**



#### 📌 Optional: Use KQL for more precision
```kql
(device.deviceOSType -eq "Windows") and
(device.deviceOSVersion -startsWith "10" or device.deviceOSVersion -startsWith "11")
```

---

### 📦 Step 3 - Configure BitLocker Policy in Intune

1. Navigate to BitLocker Policy Creation

* Go to: **Intune Admin Center** > **Endpoint security** > **Disk encryption**
* Click **+ Create Policy**
* Platform: **Windows 10 and later**
* Profile: **Endpoint Protection**
* Click **Create**

---

2. Configure Required Settings

A. Device Encryption BitLcoker

| Setting                                 | Recommended Value                                  |
| --------------------------------------- | -------------------------------------------------- |
| Require Device Encryption               | Enabled                                            |
| Allow warning for other disk encryption | Enabled                                            |
| Configure recovery password rotation    | Refresh on Both Azure AD joined & Hybrid-Joined Devices |

B. Drive Encryption Settings

| Setting                                          | Recommended Value |
| ------------------------------------------------ | ----------------- |
| Drive encryption method for OS, Fixed, Removable | Enabled           |
| Encryption Fixed drives method                   | XTS-AES 256-bit   |
| Encryption OS drives method                      | XTS-AES 256-bit   |
| Encryption Removable drives method               | XTS-AES 256-bit   |

C. OS Drive Setting

| Setting                                                | Recommended Value                           |
| ------------------------------------------------------ | ------------------------------------------- |
| Enforce OS drive encryption                            | Enabled - Full encryption                   |
| Require auth at startup                                | Enabled                                     |
| Allow BitLocker without TPM                            | True                                        |
| Configure TPM startup key and PIN                      | Do not allow startup key and PIN with TPM   |
| Configure TPM startup key                              | Do not allow startup key with TPM           |
| Configure TPM startup PIN                              | Require Startup PIN with TPM                |
| Configure TPM startup                                  | Require TPM                                 |
| Minimum PIN length                                     | Enabled / 6+ characters                     |
| Allow enhanced PIN                                     | Enabled                                     |
| Disallow user PIN/password change                      | Disabled                                    |
| OS drive recovery options                              | Enabled - 256-bit key and 48-digit password |
| Store recovery info to AD DS                           | Enabled (password + key packages)           |
| Block BitLocker until recovery info is stored in AD DS | True                                        |
| Save OS BitLocker info to AD DS                        | True                                        |

D. Fixed Drives

| Setting                                                                | Recommended Value                           |
| -----------------------------------------------------------------------| ------------------------------------------- |
| Enforce encryption type                                                | Enabled - Full encryption                   |
| Encryption method                                                      | XTS-AES 256-bit                             |
| Choose how BitLocker can be recovered                                  | Enabled - 256-bit key and 48-digit password |
| Allow recovery agents                                                  | False                                       |
| Do not enable BitLocker until recovery information is stored to AD DS  | True
| Save BitLocker recovery information to AD DS                           | Enabled                                     |
| Deny write access to fixed drives not protected by BitLocker           | Enabled                                     |

E. Removable Drives

| Setting                                              | Recommended Value |
| ---------------------------------------------------- | ----------------- |
| Control use of BitLocker                             | Enabled           |
| Allow user BitLocker enablement                      | False             |
| Enforce encryption type                              | False             |
| Deny unprotected removable write access              | Enabled           |
| Deny access to foreign-organization encrypted drives | True              |

---

## 📦 Step 4 - Assign the Policy in Intune

* Go to **Intune** > **Endpoint security** > **Disk encryption** > Select your policy
* Click **Assignments**
* Assign to:

  * `BitLocker-Test-Group` first (for testing)
  * `All Windows 10/11 Devices` after validation

![BitLocker-Policy](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/03_AzureAD_Sync_%26_Endpoint_Security/Screenshots/BitLocker-Policy.png)

---

> 📡 This structure ensures controlled, tested, and secure deployment of BitLocker encryption across the enterprise, meeting both compliance and operational excellence standards.

---

## Conclusion

By following this structured approach—starting with a test group, creating dynamic device groups, configuring detailed BitLocker policies, and assigning policies through Intune—you can confidently deploy BitLocker at scale. This method safeguards sensitive data, enforces compliance, and integrates seamlessly into your existing cloud or hybrid device management strategy.

