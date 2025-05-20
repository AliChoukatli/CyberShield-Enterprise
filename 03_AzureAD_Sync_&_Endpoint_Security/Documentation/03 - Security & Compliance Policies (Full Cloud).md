Full Cloud

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

