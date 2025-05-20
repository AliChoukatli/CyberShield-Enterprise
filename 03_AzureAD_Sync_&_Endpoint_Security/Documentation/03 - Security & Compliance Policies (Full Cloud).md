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


<p align="center">
  <img src="https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/03_AzureAD_Sync_%26_Endpoint_Security/Screenshots/Authenticator-Policy.png" alt="Authenticator Policy" width="80%" style="max-height: 50px; object-fit: contain;" />
</p>


![Authenticator](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/03_AzureAD_Sync_%26_Endpoint_Security/Screenshots/Authenticator-Policy.png)

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

## ✅ Hybrid Deployment (Azure AD + On-premises Active Directory)

### Overview

- Devices joined to on-premises Active Directory and synced with Azure AD via Azure AD Connect.  
- Uses internal PKI for certificate-based authentication.  
- Managed by Group Policy Objects (GPO) or Intune hybrid.  
- Supports TPM, biometrics (face/fingerprint), and PIN.  
- Strong authentication integrated with local domain and cloud.

###  Key Configuration Points

- Enable Windows Hello for Business in GPO or Intune hybrid profile.  
- Configure PKI for WHfB certificates.  
- Deploy PIN complexity and biometrics policies.  
- Ensure Azure AD Connect sync up to date.

### References

- [Windows Hello Hybrid Key Trust](https://learn.microsoft.com/en-us/windows/security/identity-protection/hello-for-business/hello-hybrid-key-trust)  
- [PKI Configuration for WHfB](https://learn.microsoft.com/en-us/windows/security/identity-protection/hello-for-business/hello-pki)  

---

## ✅  Full Cloud Deployment (Azure AD Join only)

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

