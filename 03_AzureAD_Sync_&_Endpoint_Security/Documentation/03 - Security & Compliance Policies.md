#  Authentication Methods  & Compliance Policies

This project implements Multi-Factor Authentication (MFA) using multiple modern methods:

1. **Microsoft Authenticator App**  
   Used for push notifications and one-time passcodes (OTP) as a second factor for secure login.

2. **Temporary Access Pass (TAP) – Recommended Settings**

3. **FIDO2 Security Keys**  
   Although not used in this project setup, physical FIDO2 security keys (e.g., YubiKey USB devices) can also be registered and used for authentication in Microsoft Entra ID (Previously AzureAD).  
   These hardware keys provide a high level of security and are commonly used in enterprise environments.

4. **Windows Hello**  
   Provides a passwordless experience by leveraging built-in biometric sensors (face or fingerprint) and PIN on Windows devices.  
   Windows Hello uses the **FIDO2 protocol** to secure authentication without the need for passwords.

> **Note:**  
> This setup demonstrates a passwordless and strong MFA implementation using Microsoft Authenticator and Windows Hello, both of which support the FIDO2 standard.  
> For full hardware-based passwordless authentication, organizations typically deploy physical FIDO2 keys like YubiKey.

![Auth-Methods](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/03_AzureAD_Sync_%26_Endpoint_Security/Screenshots/Auth-Methods.png)

---

# 🔐 Multi-Factor Authentication (MFA) – Recommended Methods

## ✅ A. Microsoft Authenticator – Recommended Settings

| Setting                                            | Recommended Value       | Description                                                                                   |
|----------------------------------------------------|--------------------------|-----------------------------------------------------------------------------------------------|
| **Enable and Target**                              | ✅ Enabled               | Method is enabled for users                                                                   |
| **Target**                                         | 🎯 All users             | Include all users or a specific security group                                                |
| **Allow use of Microsoft Authenticator OTP**       | ✅ Yes                  | Allows use of TOTP codes from the app in addition to push notifications                      |
| **Require number matching for push notifications** | ✅ Enabled (mandatory)   | Prevents MFA fatigue attacks by requiring users to enter the number shown on the screen      |
| **Show application name in notifications**         | ☁️ Microsoft-managed     | App name will be shown in push/passwordless notifications when rolled out by Microsoft       |
| **Show geographic location in notifications**      | ☁️ Microsoft-managed     | Location info is shown to help users detect suspicious logins                                |
| **Authenticator on companion apps**                | ☁️ Microsoft-managed     | Controls the use of Authenticator on devices like Apple Watch or other paired apps           |

![Authenticator-Policy](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/03_AzureAD_Sync_%26_Endpoint_Security/Screenshots/Authenticator-Policy.png)

---


## ✅ B. Temporary Access Pass (TAP) – Recommended Settings

| Setting                   | Recommended Value  | Description                                                                                   |
|---------------------------|--------------------|-----------------------------------------------------------------------------------------------|
| **Enable and Target**     | ✅ Enabled         | TAP is enabled for targeted users or groups                                                   |
| **Minimum lifetime**      | 1 hour             | Minimum duration the pass is valid                                                            |
| **Maximum lifetime**      | 8 hours            | Maximum allowed validity for a TAP                                                            |
| **Default lifetime**      | 1 hour             | Default value assigned when generating a TAP                                                  |
| **One-time use**          | ✅ Yes             | Pass is valid for only one sign-in (recommended for security)                                 |
| **Length**                | 8 characters       | Length of the Temporary Access Pass code (minimum recommended for security)                   |

> **Important Notes:**  
> - TAP is used only by administrators, typically during:  
> &nbsp;&nbsp;- MFA registration (bootstrap)  
> &nbsp;&nbsp;- Recovery when other methods are unavailable  
> > **Note:** TAP is not usable for Self-Service Password Reset (SSPR)

![TAP-Policy](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/03_AzureAD_Sync_%26_Endpoint_Security/Screenshots/TAP-Policy.png)

---

## ✅  C. FIDO2 Security Key (Passkey) – Recommended Settings

| Setting                     | Recommended Value | Description                                                                 |
|----------------------------|-------------------|-----------------------------------------------------------------------------|
| Allow self-service set up  | ✅ Yes            | Allows users to register their own FIDO2 security keys                      |
| Enforce attestation        | ❌ No             | Not required unless you need verified device metadata                      |
| Enforce key restrictions   | ✅ Yes            | Prevents use of unapproved or unknown FIDO2 keys                           |
| Restrict specific keys     | 🔒 Block          | Blocks specific keys by AAGUID (only if you want to restrict certain vendors) |
| Microsoft Authenticator    | ❌ No             | Not applicable for FIDO2; Microsoft Authenticator is a separate method     |

![Fido2-Policy](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/03_AzureAD_Sync_%26_Endpoint_Security/Screenshots/FIDO2-Policy.png)

---

### 🔗 For more information, refer to the official Microsoft documentation:

  - [FIDO2 Security Keys in Microsoft Entra ID](https://learn.microsoft.com/en-us/entra/identity/authentication/how-to-enable-passkey-fido2)

  - [Microsoft Authenticator App](https://learn.microsoft.com/en-us/entra/identity/authentication/concept-authentication-authenticator-app)

  - [Temporary Access Pass (TAP)](https://learn.microsoft.com/en-us/entra/identity/authentication/howto-authentication-temporary-access-pass)

---


## ✅ D. Windows Hello for Business – Hybrid Key Trust Deployment Guide

This guide explains how to configure **Windows Hello for Business** in a **hybrid environment** (on-premises Active Directory + Azure AD) using the **Key Trust model**.

---

### Prerequisites

- Windows Server 2016 or later for domain controllers
- Azure AD Connect configured for hybrid Azure AD join
- Windows 10/11 client device with TPM enabled and compatible with Windows Hello
- Administrative privileges to create and edit Group Policy Objects (GPO)

---

### Step 1: Verify Prerequisites on Client Device

- Open PowerShell as an administrator and run:

```powershell
dsregcmd /status
```
- Check the output:

  - AzureAdJoined or DomainJoined should be YES

  - Device State should indicate Hybrid Azure AD joined

- Also verify TPM status by running **tpm.msc**

![TPM](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/03_AzureAD_Sync_%26_Endpoint_Security/Screenshots/TPM.png)

✅ Result: TPM is present and ready (Hyper-V secure boot & TPM enabled)

---

### Step 2: Create and Configure the GPO for Windows Hello for Business

 1. Open Group Policy Management Console (GPMC) on your domain controller (gpmc.msc)

 2. Navigate to the appropriate Organizational Unit (OU) or domain.

3. Right-click → Create a GPO in this domain, and Link it here...

4.  Name the GPO (e.g., Windows Hello for Business - Key Trust).

5.  Edit the GPO:

  - Go to:
```rust
Computer Configuration → Policies → Administrative Templates → Windows Components → Windows Hello for Business
```

- Enable these policies:

  - Use Windows Hello for Business → Enabled

  - Use biometrics → Enabled

  - Configure PIN complexity → Configure as needed (e.g., minimum length 6)

  - Use a Hardware Security Device (TPM) → Enabled
 
![Hello-GPO](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/03_AzureAD_Sync_%26_Endpoint_Security/Screenshots/Hello-GPO.png)


---

### Step 3: Force Group Policy Update on Client Devices
1. On each Windows client device, open PowerShell as admin and run:
```Powershell
gpupdate /force
```

2. Then reboot the device to apply the policy.

---

### Step 4: Register Windows Hello for Business on Client

1. Go to Settings → Accounts → Sign-in options.

2. Set up Windows Hello PIN.

3. Enable biometric sign-in if supported (fingerprint or facial recognition).

4. Confirm that Windows Hello sign-in works correctly.

### Step 5: Verify Device Registration Status

1. On the client device, open PowerShell and run:
```powershell
dsregcmd /status
```
2. Ensure that the device shows as Hybrid Azure AD joined and Windows Hello authentication is active.

#### Windows Hello for Business – Hybrid Key Trust Deployment

This configuration enables passwordless authentication using Windows Hello for Business in a hybrid Active Directory and Azure AD environment, leveraging the Key Trust model.

| Setting                          | Recommended Value | Description                                 |
|---------------------------------|-------------------|---------------------------------------------|
| Use Windows Hello for Business   | ✅ Enabled        | Enables Hello sign-in on hybrid devices     |
| Use biometrics                  | ✅ Enabled        | Allows face/fingerprint sign-in             |
| Use PIN                         | ✅ Enabled        | PIN fallback when biometrics are unavailable |
| Trust model                     | Key Trust         | No certificate infrastructure required; simpler setup |
| Require TPM                    | ✅ Enabled        | Credentials secured in hardware TPM         |

> Devices are hybrid Azure AD joined and authenticate without passwords, improving security and user experience.

---

![Windows Hello for Business GPO Screenshot](./Screenshots/windows-hello-gpo.png)


---



Step 7: Capture Screenshot
Take a screenshot of the configured GPO policies and add it to your repository under /Screenshots/windows-hello-gpo.png.
Additional Notes
The Key Trust model is preferred for hybrid environments as it requires no PKI infrastructure.

This configuration aligns with Microsoft’s recommended best practices for hybrid Windows Hello deployments.

For further reading, see the official Microsoft documentation:
Windows Hello for Business deployment
















---
## 🎯 Conditional Access Policies

**Objective:** Define conditions and controls for secure sign-in and resource access.

### ✅ Key Policies to Implement:

### 1. **Block Legacy Authentication**
- Prevent sign-ins using outdated protocols (e.g., IMAP, POP).
- Policy settings:
  - **Users:** All users.
  - **Cloud apps:** All cloud apps.
  - **Conditions:** Client apps > Legacy authentication clients.
  - **Access controls:** Block access.

📸 *Insert screenshot: Legacy auth block policy.*

---

### 2. **Require MFA for All Users**
- Prompt MFA when accessing sensitive resources.

- **Users:** All users or targeted group.
- **Cloud apps:** Office 365 or All cloud apps.
- **Conditions:** Include all locations; exclude trusted locations if needed.
- **Access controls:** Grant access > Require MFA.

📸 *Insert screenshot: Conditional Access MFA policy.*

---

### 3. **Require Compliant or Hybrid Azure AD Joined Device**
- Restrict access only from trusted, managed devices.

- **Users:** All users.
- **Cloud apps:** All cloud apps.
- **Conditions:** Device state > Require compliant or hybrid Azure AD joined.
- **Access controls:** Grant access > Require device to be compliant.

📸 *Insert screenshot: Compliant device policy.*

---

### 4. **Block Access from Risky Sign-Ins**
- Automatically block sign-ins flagged as risky by Microsoft Entra ID.

- **Users:** All users.
- **Conditions:** Sign-in risk > Medium and above.
- **Access controls:** Block access.

📸 *Insert screenshot: Sign-in risk policy.*

---

## 📊 Monitoring & Reporting

- Use **Microsoft Entra Sign-in Logs** and **Audit Logs** to monitor the effects of your policies.
- Set up **alerts** via Microsoft Defender or Microsoft Sentinel to track policy violations or risk detections.

📸 *Insert screenshot: Sign-in logs or alert dashboard.*

---

## ✅ Summary

| Policy | Purpose | Status |
|--------|---------|--------|
| MFA for all users | Stronger authentication | ✅ Enabled |
| Block legacy authentication | Prevent insecure access | ✅ Enabled |
| Conditional Access: MFA | Enforce MFA in real-world | ✅ Enabled |
| Device compliance access | Secure endpoints only | ✅ Enabled |
| Block risky sign-ins | Stop known threats | ✅ Enabled |

---

**Next Step →** Phase04 - Endpoint Security & Device Compliance

