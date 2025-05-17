## 📅 Phase 3 – Apply Security and Compliance Policies via Intune

### 🌟 Objective

Establish a professional-grade deployment of BitLocker via Microsoft Intune to ensure enterprise-grade security, compliance, and operational reliability across Windows devices.

---

## ✅ Step 1 – Create a Test Group (Recommended for Validation)

1. Navigate to **Microsoft Entra Admin Center**
2. Go to **Groups** from the left-side menu
3. Click **+ New group**
4. Fill in the following:

   * **Group type**: Security
   * **Group name**: `BitLocker-Test-Group`
   * **Description**: Group for testing BitLocker policy deployment
   * **Membership type**: Assigned
5. Add 1 or 2 test devices (e.g., lab VM or controlled PC)
6. Click **Create**

⚡ This allows safe testing and troubleshooting before broader rollout.

---

## ✅ Step 2 – Create a Dynamic Group for All Windows 10/11 Devices

1. Return to **Groups** > **New group**
2. Select:

   * **Group type**: Security
   * **Group name**: `All Windows 10/11 Devices`
   * **Membership type**: Dynamic Device
3. Click **Add dynamic query**
4. Define the rule with the following properties:
5. Click **Save** > **Create**

![Windows-Device-Group](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/03_AzureAD_Sync_%26_Endpoint_Security/Screenshots/Windows-Device-Group.png)

```kql
(device.deviceOSType -eq "Windows") and
(device.deviceOSVersion -startsWith "10" or device.deviceOSVersion -startsWith "11")
```
---

## 🔐 BitLocker Configuration via Intune

### 🌟 Objective

Use Microsoft Intune to enforce BitLocker drive encryption on Windows 10/11, ensuring data protection and recovery key compliance.

---

## ✅ Configure BitLocker Policy in Intune

### 1. Navigate to BitLocker Policy Creation

* Go to: **Intune Admin Center** > **Endpoint security** > **Disk encryption**
* Click **+ Create Policy**
* Platform: **Windows 10 and later**
* Profile: **Endpoint Protection**
* Click **Create**

---

### 2. Configure Required Settings

#### A. Device Encryption

| Setting                                 | Recommended Value                                  |
| --------------------------------------- | -------------------------------------------------- |
| Require Device Encryption               | Enabled                                            |
| Allow warning for other disk encryption | Enabled                                            |
| Configure recovery password rotation    | Refresh on Azure AD joined & Hybrid-Joined Devices |

#### B. Drive Encryption Settings

| Setting                                          | Recommended Value |
| ------------------------------------------------ | ----------------- |
| Drive encryption method for OS, Fixed, Removable | Enabled           |
| Fixed drives method                              | XTS-AES 256-bit   |
| OS drives method                                 | XTS-AES 256-bit   |
| Removable drives method                          | XTS-AES 256-bit   |

#### C. OS Drive Protection

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

#### D. Fixed Drives

| Setting                             | Recommended Value                           |
| ----------------------------------- | ------------------------------------------- |
| Enforce encryption type             | Enabled - Full encryption                   |
| Encryption method                   | XTS-AES 256-bit                             |
| Recovery options                    | Enabled - 256-bit key and 48-digit password |
| Allow recovery agents               | False                                       |
| Store recovery info in AD DS        | Enabled                                     |
| Deny unprotected drive write access | Enabled                                     |

#### E. Removable Drives

| Setting                                              | Recommended Value |
| ---------------------------------------------------- | ----------------- |
| Control use of BitLocker                             | Enabled           |
| Allow user BitLocker enablement                      | False             |
| Enforce encryption type                              | False             |
| Deny unprotected removable write access              | Enabled           |
| Deny access to foreign-organization encrypted drives | True              |

---

## ✅ Assign the Policy in Intune

* Go to **Intune** > **Endpoint security** > **Disk encryption** > Select your policy
* Click **Assignments**
* Assign to:

  * `BitLocker-Test-Group` first (for testing)
  * `All Windows 10/11 Devices` after validation

![BitLocker-Policy](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/03_AzureAD_Sync_%26_Endpoint_Security/Screenshots/BitLocker-Policy.png)

---

> 📡 This structure ensures controlled, tested, and secure deployment of BitLocker encryption across the enterprise, meeting both compliance and operational excellence standards.
