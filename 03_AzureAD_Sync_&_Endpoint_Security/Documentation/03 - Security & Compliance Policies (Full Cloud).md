# 03 - Security Compliance & Policies

This section covers security compliance settings and policies essential to secure the environment and enforce best practices.

---

## 🔴 Security Policies Overview

| Policy Area                 | Description                                                        |
|----------------------------|--------------------------------------------------------------------|
| **Conditional Access (CA)**| Enforces granular access controls based on user, device, location, and risk level. |
| **Multi-Factor Authentication (MFA)** | Adds a second layer of verification to strengthen identity security.        |
| **Device Compliance**       | Ensures devices meet security baselines (patching, encryption, antivirus). |
| **Identity Protection**     | Uses risk detection and mitigation to prevent compromised accounts. |

![Auth-Methods](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/03_AzureAD_Sync_%26_Endpoint_Security/Screenshots/Auth-Methods.png)

---


## 🔴 **Conditional Access Policies - Recommended Settings**

| Policy Name                    | Purpose                                             | Key Settings                                                         |
|-------------------------------|-----------------------------------------------------|----------------------------------------------------------------------|
| Block Legacy Authentication    | Block insecure protocols like IMAP, POP, SMTP      | Target: All users<br>Client apps: Legacy auth<br>Access: Block      |
| Require MFA for All Users      | Enforce MFA for all sign-ins                        | Target: All users<br>Access: Require MFA                            |
| Require Compliant Devices      | Allow access only from compliant or Azure AD joined devices | Target: All users<br>Device state: Require compliant or Azure AD joined<br>Access: Grant if compliant |
| Block Risky Sign-ins           | Block sign-ins flagged as risky                      | Target: All users<br>Sign-in risk: Medium or higher<br>Access: Block|

---

## 🔴 Multi-Factor Authentication (MFA)

The project implements MFA using the following modern methods:

1. ✅  **Microsoft Authenticator App – Recommended Settings**

| Setting                                            | Recommended Value       | Description                                                                                   |
|----------------------------------------------------|--------------------------|-----------------------------------------------------------------------------------------------|
| **Enable and Target**                              | ✅ Enabled               | Method is enabled for users                                                                   |
| **Target**                                         | 🎯 All users             | Include all users or a specific security group                                                |
| **Allow use of Microsoft Authenticator OTP**       | ✅ Yes                  | Allows use of TOTP codes from the app in addition to push notifications                      |
| **Require number matching for push notifications** | ✅ Enabled (mandatory)   | Prevents MFA fatigue attacks by requiring users to enter the number shown on the screen      |
| **Show application name in notifications**         | ☁️ Microsoft-managed     | App name shown in push/passwordless notifications                                            |
| **Show geographic location in notifications**      | ☁️ Microsoft-managed     | Location info shown to detect suspicious logins                                             |
| **Authenticator on companion apps**                | ☁️ Microsoft-managed     | Controls use on devices like Apple Watch                                                    |


![Authenticator-Policy](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/03_AzureAD_Sync_%26_Endpoint_Security/Screenshots/Authenticator-Policy.png)

---

2. ✅  **Temporary Access Pass (TAP) – Recommended Settings**

| Setting                   | Recommended Value  | Description                                                                                   |
|---------------------------|--------------------|-----------------------------------------------------------------------------------------------|
| **Enable and Target**     | ✅ Enabled         | TAP enabled for targeted users or groups                                                     |
| **Minimum lifetime**      | 1 hour             | Minimum validity period                                                                      |
| **Maximum lifetime**      | 8 hours            | Maximum validity                                                                            |
| **Default lifetime**      | 1 hour             | Default value assigned on generation                                                        |
| **One-time use**          | ✅ Yes             | Pass valid for only one sign-in (recommended for security)                                   |
| **Length**                | 8 characters       | Length of the TAP code                                                                       |

> **Note:** TAP is used mainly by admins during MFA registration bootstrap or recovery; not for SSPR.

![TAP Policy](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/03_AzureAD_Sync_%26_Endpoint_Security/Screenshots/TAP-Policy.png)


---

3. ✅  **FIDO2 Security Key (Passkey) – Recommended Settings**

| Setting                     | Recommended Value | Description                                                                 |
|----------------------------|-------------------|-----------------------------------------------------------------------------|
| Allow self-service set up  | ✅ Yes            | Users can register their own FIDO2 keys                                    |
| Enforce attestation        | ❌ No             | Not required unless verified device metadata needed                         |
| Enforce key restrictions   | ✅ Yes            | Prevent use of unapproved or unknown FIDO2 keys                            |
| Restrict specific keys     | 🔒 Block          | Block specific keys by vendor AAGUID                                       |
| Microsoft Authenticator    | ❌ No             | Separate method from FIDO2                                                 |

![FIDO2 Policy](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/03_AzureAD_Sync_%26_Endpoint_Security/Screenshots/FIDO2-Policy.png)

---

## 🔴 Windows Hello for Business

---

### ✅ Hybrid Deployment (Azure AD + On-premises Active Directory)

### Prerequisites

- Windows Server 2016 or later for domain controllers
- Azure AD Connect configured for hybrid Azure AD join
- Windows 10/11 client device with TPM enabled and compatible with Windows Hello
- Administrative privileges to create and edit Group Policy Objects (GPO)

---

### Step 1: Verify Prerequisites on Client Device

- Open PowerShell as an administrator and run:

powershell
dsregcmd /status

- Check the output:

  - AzureAdJoined or DomainJoined should be YES

  - Device State should indicate Hybrid Azure AD joined

- Also verify TPM status by running **tpm.msc**

![TPM](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/03_AzureAD_Sync_%26_Endpoint_Security/Screenshots/TPM.png)

> **Result:** TPM is present and ready (Hyper-V secure boot & TPM enabled)

---

### Step 2: Create and Configure the GPO for Windows Hello for Business

 1. Open Group Policy Management Console (GPMC) on your domain controller (gpmc.msc)

 2. Navigate to the appropriate Organizational Unit (OU) or domain.

3. Right-click → Create a GPO in this domain, and Link it here...

4.  Name the GPO (e.g., Windows Hello for Business - Key Trust).

5.  Edit the GPO:

  - Go to:
rust
Computer Configuration → Policies → Administrative Templates → Windows Components → Windows Hello for Business
 
![Hello-GPO](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/03_AzureAD_Sync_%26_Endpoint_Security/Screenshots/Hello-GPO.png)

- Enable these policies:

| Setting                             | Recommended Value | Description                                 |
|-------------------------------------|-------------------|---------------------------------------------|
| Use Windows Hello for Business      | ✅ Enabled        | Enables Hello sign-in on hybrid devices     |
| Use biometrics                      | ✅ Enabled        | Allows face/fingerprint sign-in             |
| Use PIN  minimum length 6           | ✅ Enabled        | PIN fallback when biometrics are unavailable|
| Use a Hardware Security Device (TPM)| ✅ Enabled        | Credentials secured in hardware TPM         |

![Hello-Config](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/03_AzureAD_Sync_%26_Endpoint_Security/Screenshots/Hello-Config-Intune.png)

---

### Step 3: Force Group Policy Update on Client Devices
1. On each Windows client device, open PowerShell as admin and run:
Powershell
gpupdate /force


2. Then reboot the device to apply the policy.

---

### Step 4: Register Windows Hello for Business on Client

1. Go to Settings → Accounts → Sign-in options.

2. Set up Windows Hello PIN.

3. Enable biometric sign-in if supported (fingerprint or facial recognition).

4. Confirm that Windows Hello sign-in works correctly.

### Step 5: Verify Device Registration Status

1. On the client device, open PowerShell and run:
powershell
dsregcmd /status

2. Ensure that the device shows as Hybrid Azure AD joined and Windows Hello authentication is active..
> Devices are hybrid Azure AD joined and authenticate without passwords, improving security and user experience.

---

### ✅  Full Cloud Deployment (Azure AD Join only)

### Overview

- Devices joined directly to Azure AD (no on-prem AD).  
- Managed via Microsoft Endpoint Manager (Intune).  
- Passwordless experience using biometrics and PIN secured by TPM.  
- Requires Azure AD Premium licenses.  
- Conditional Access enforces MFA and device compliance.

### Configure Windows Hello for Business in Intune

- In **Microsoft Endpoint Manager**, navigate to:  
  `Devices > Windows > Configuration profiles` → Create new profile  
- Platform: Windows 10 and later  
- Profile type: Identity protection  
- Settings:  
  - Enable Windows Hello for Business: Yes  
  - Use biometrics: Enabled  
  - Minimum PIN length: 6 characters  
  - Allow convenience PIN: As per policy  
  - Use TPM: Enabled  

- Assign to targeted user/device groups.


### References

- [Windows Hello Full Cloud Deployment](https://learn.microsoft.com/en-us/windows/security/identity-protection/hello-for-business/hello-identity-verification)  
- [Configure Windows Hello with Intune](https://learn.microsoft.com/en-us/mem/intune/configuration/device-profiles#windows-hello-for-business)  
- [Azure AD Conditional Access](https://learn.microsoft.com/en-us/azure/active-directory/conditional-access/overview)  

---

