# Full Cloud Authentication & Security Setup

---

## Multi-Factor Authentication (MFA) – Modern Methods Overview

This project implements Multi-Factor Authentication (MFA) using multiple modern and secure methods to ensure strong user authentication in a full cloud environment.

### 1. Microsoft Authenticator App  
Used for push notifications and Time-based One-Time Passcodes (TOTP) as a second factor to secure user sign-in.

### 2. Temporary Access Pass (TAP) – Recommended Settings  
A temporary, time-limited passcode primarily used for initial MFA registration and recovery scenarios.

### 3. FIDO2 Security Keys (Passkeys)  
Although not deployed in this project, hardware-based FIDO2 security keys such as YubiKey can be registered in Microsoft Entra ID to enable passwordless hardware authentication, providing the highest level of security.

### 4. Windows Hello for Business  
Enables passwordless authentication by leveraging device biometrics (face, fingerprint) and PIN, secured by the FIDO2 protocol, for seamless and secure Windows login experience.

> **Note:**  
> This setup showcases a secure and passwordless MFA implementation combining Microsoft Authenticator and Windows Hello, both supporting FIDO2 standards.  
> For organizations requiring hardware-only passwordless authentication, FIDO2 security keys are recommended.

---

### Visual Summary

![Auth-Methods](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/03_AzureAD_Sync_%26_Endpoint_Security/Screenshots/Auth-Methods.png)

---

## Detailed MFA Configuration

### A. Microsoft Authenticator – Recommended Policy Settings

| Setting                                      | Value               | Description                                                                              |
|----------------------------------------------|---------------------|------------------------------------------------------------------------------------------|
| **Enabled & Target**                          | ✅ Enabled for All Users | MFA method is enabled and assigned to all relevant users                                |
| **Allow Authenticator OTP (TOTP)**            | ✅ Yes              | Supports one-time passcodes in addition to push notifications                           |
| **Require Number Matching for Push**          | ✅ Enabled          | Mitigates MFA fatigue by requiring user to verify matching number in notification       |
| **Show Application Name in Notifications**    | Microsoft-managed   | Displays app name in push notifications                                                 |
| **Show Geographic Location in Notifications** | Microsoft-managed   | Helps users detect unusual sign-in locations                                           |
| **Authenticator Companion Apps Usage**        | Microsoft-managed   | Controls usage on devices such as Apple Watch                                           |

![Authenticator-Policy](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/03_AzureAD_Sync_%26_Endpoint_Security/Screenshots/Authenticator-Policy.png)

---

### B. Temporary Access Pass (TAP) – Recommended Settings

| Setting             | Value      | Description                                                    |
|---------------------|------------|----------------------------------------------------------------|
| **Enabled & Target** | ✅ Enabled | TAP enabled for administrators or targeted groups             |
| **Minimum Lifetime** | 1 hour     | Minimum validity period for the pass                           |
| **Maximum Lifetime** | 8 hours    | Maximum allowed validity                                       |
| **Default Lifetime** | 1 hour     | Default duration when generating a new TAP                    |
| **One-Time Use**     | ✅ Yes     | Pass is valid for one sign-in only (security best practice)    |
| **Length**           | 8 characters | Length of the temporary access pass code                       |

> **Important:**  
> TAP is intended for administrator use only, typically during:  
> - Initial MFA bootstrap registration  
> - Recovery when other methods are unavailable  
> **Note:** TAP cannot be used for Self-Service Password Reset (SSPR).

![TAP-Policy](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/03_AzureAD_Sync_%26_Endpoint_Security/Screenshots/TAP-Policy.png)

---

### C. FIDO2 Security Key – Recommended Policy Settings

| Setting                     | Value     | Description                                                             |
|-----------------------------|-----------|-------------------------------------------------------------------------|
| **Allow Self-Service Setup** | ✅ Yes    | Users can register their own FIDO2 keys                                |
| **Enforce Attestation**      | ❌ No     | Not required unless device attestation verification is mandatory       |
| **Enforce Key Restrictions** | ✅ Yes    | Restricts use to approved FIDO2 keys                                   |
| **Restrict Specific Keys**   | Blocked   | Blocks certain keys by vendor AAGUID if needed                         |
| **Microsoft Authenticator**  | Not applicable | FIDO2 is a distinct method from Microsoft Authenticator               |

![Fido2-Policy](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/03_AzureAD_Sync_%26_Endpoint_Security/Screenshots/FIDO2-Policy.png)

---

### Further Reading & Official Documentation

- [FIDO2 Security Keys in Microsoft Entra ID](https://learn.microsoft.com/en-us/entra/identity/authentication/how-to-enable-passkey-fido2)  
- [Microsoft Authenticator App Overview](https://learn.microsoft.com/en-us/entra/identity/authentication/concept-authentication-authenticator-app)  
- [Temporary Access Pass (TAP) Usage](https://learn.microsoft.com/en-us/entra/identity/authentication/howto-authentication-temporary-access-pass)  

---

# Windows Hello for Business – Full Cloud Deployment (Azure AD Join)

---

### Prerequisites

- Devices are **Azure AD Joined only** (no on-premises Active Directory).  
- Compatible Windows 10/11 devices with TPM support.  
- Microsoft Intune managing devices.  
- Azure AD Premium P1 or P2 licenses for Conditional Access and MFA.

---

### Step 1: Configure Windows Hello for Business via Microsoft Intune

1. In the **Microsoft Endpoint Manager Admin Center**:  
   `Devices > Windows > Configuration profiles` → **Create profile**  
   - Platform: Windows 10 and later  
   - Profile type: Identity protection  

2. Configure the following Windows Hello for Business settings:  
   - **Enable Windows Hello for Business**: Yes  
   - **Use biometrics**: Enabled  
   - **Minimum PIN length**: 6 characters (recommended)  
   - **Allow convenience PIN**: According to organizational policy  
   - **Use TPM**: Enabled (if supported by device)  

3. Assign this profile to the appropriate user or device groups.

---

### Step 2: Implement Conditional Access (CA) Policies for Full Cloud Environment

| Policy                              | Purpose                                               | Key Configuration                                                              |
|------------------------------------|-------------------------------------------------------|--------------------------------------------------------------------------------|
| **Block Legacy Authentication**    | Block insecure protocols (IMAP, POP, SMTP, etc.)      | Users: All users<br>Apps: All cloud apps<br>Condition: Legacy authentication<br>Access: Block |
| **Require MFA for All Users**      | Enforce strong authentication on all sign-ins        | Users: All users<br>Apps: All cloud apps<br>Access: Require MFA                |
| **Require Compliant or Azure AD Joined Device** | Restrict access to managed or compliant devices only | Users: All users<br>Apps: All cloud apps<br>Condition: Device state → compliant or Azure AD joined<br>Access: Grant if compliant |
| **Block Access from Risky Sign-ins** | Block sign-ins detected as risky by Microsoft Entra ID | Users: All users<br>Condition: Sign-in risk medium or higher<br>Access: Block   |

---

### Step 3: Multi-Factor Authentication (MFA) Enforcement

- Enforce MFA for all users in Microsoft Entra ID using:  
  - Microsoft Authenticator app (push & OTP)  
  - Temporary Access Pass (TAP) for admin scenarios  
  - FIDO2 security keys for hardware passwordless authentication  

---

### References

- [Windows Hello for Business Deployment Guide](https://learn.microsoft.com/en-us/windows/security/identity-protection/hello-for-business/hello-identity-verification)  
- [Azure AD Conditional Access Overview](https://learn.microsoft.com/en-us/azure/active-directory/conditional-access/overview)  
- [Azure AD Multi-Factor Authentication](https://learn.microsoft.com/en-us/azure/active-directory/authentication/concept-mfa-howitworks)  
- [Temporary Access Pass (TAP) Documentation](https://learn.microsoft.com/en-us/azure/active-directory/authentication/howto-authentication-temporary-access-pass)  
- [FIDO2 Security Keys in Microsoft Entra ID](https://learn.microsoft.com/en-us/azure/active-directory/authentication/howto-enable-passkey-fido2)  

---

