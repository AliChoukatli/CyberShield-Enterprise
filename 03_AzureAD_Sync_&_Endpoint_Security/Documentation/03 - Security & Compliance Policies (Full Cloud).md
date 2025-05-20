# 03 Security Compliance & Policies

This section covers security compliance settings and policies essential to secure the environment and enforce best practices.

---

## Security Policies Overview

| Policy Area                 | Description                                                        |
|----------------------------|--------------------------------------------------------------------|
| **Conditional Access (CA)**| Enforces granular access controls based on user, device, location, and risk level. |
| **Multi-Factor Authentication (MFA)** | Adds a second layer of verification to strengthen identity security.        |
| **Device Compliance**       | Ensures devices meet security baselines (patching, encryption, antivirus). |
| **Identity Protection**     | Uses risk detection and mitigation to prevent compromised accounts. |

---

## Recommended Security Compliance Policies

### Conditional Access Policies

| Policy Name                    | Purpose                                             | Key Settings                                                         |
|-------------------------------|-----------------------------------------------------|----------------------------------------------------------------------|
| Block Legacy Authentication    | Block insecure protocols like IMAP, POP, SMTP      | Target: All users<br>Client apps: Legacy auth<br>Access: Block      |
| Require MFA for All Users      | Enforce MFA for all sign-ins                        | Target: All users<br>Access: Require MFA                            |
| Require Compliant Devices      | Allow access only from compliant or Azure AD joined devices | Target: All users<br>Device state: Require compliant or Azure AD joined<br>Access: Grant if compliant |
| Block Risky Sign-ins           | Block sign-ins flagged as risky                      | Target: All users<br>Sign-in risk: Medium or higher<br>Access: Block|

---

### Multi-Factor Authentication (MFA)

The project implements MFA using the following modern methods:

- **Microsoft Authenticator App:** Push notifications and OTP codes.  
- **Temporary Access Pass (TAP):** One-time pass for bootstrap and recovery scenarios, admin only.  
- **FIDO2 Security Keys:** Hardware keys (e.g., YubiKey) for passwordless strong authentication.

---

# Windows Hello for Business

---

## Hybrid Deployment (Azure AD + On-premises Active Directory)

### Overview

- Devices joined to on-premises Active Directory and synced to Azure AD via Azure AD Connect.  
- Uses internal PKI for certificate-based authentication.  
- Managed by Group Policy Objects (GPO) or Intune in hybrid mode.  
- Supports TPM, biometrics (face/fingerprint), and PIN.  
- Provides strong authentication integrated with local domain and cloud services.

### Key Configuration Points

- Enable Windows Hello for Business in Group Policy or Intune hybrid profile.  
- Configure PKI infrastructure to issue WHfB certificates.  
- Deploy policies enforcing PIN complexity and biometric usage.  
- Ensure Azure AD Connect sync is properly configured and up to date.

### References

- [Windows Hello for Business Hybrid Key Trust](https://learn.microsoft.com/en-us/windows/security/identity-protection/hello-for-business/hello-hybrid-key-trust)  
- [PKI Configuration for WHfB](https://learn.microsoft.com/en-us/windows/security/identity-protection/hello-for-business/hello-pki)  

---

## Full Cloud Deployment (Azure AD Join only)

### Overview

- Devices joined directly to Azure AD (no on-prem AD).  
- Managed via Microsoft Endpoint Manager (Intune).  
- Passwordless experience using biometrics and PIN secured by TPM.  
- Requires Azure AD Premium P1 or P2 licenses.  
- Conditional Access policies enforce access controls and MFA requirements.

### Step 1: Configure Windows Hello for Business in Intune

- Go to **Microsoft Endpoint Manager** portal → `Devices > Windows > Configuration profiles` → Create a new profile  
- Platform: Windows 10 and later  
- Profile type: Identity protection  
- Settings:  
  - Enable Windows Hello for Business: Yes  
  - Use biometrics: Enabled  
  - Minimum PIN length: 6 characters (recommended)  
  - Allow convenience PIN: As per security policy  
  - Use TPM: Enabled  

- Assign the profile to targeted user/device groups.

### Step 2: Implement Conditional Access Policies

| Policy                       | Description                                   | Key Settings                                          |
|------------------------------|----------------------------------------------|-------------------------------------------------------|
| Block Legacy Authentication  | Block insecure sign-in protocols              | Target: All users<br>Apps: All cloud apps<br>Condition: Legacy auth<br>Access: Block |
| Require MFA for All Users     | Enforce MFA on every sign-in                  | Target: All users<br>Apps: All cloud apps<br>Access: Require MFA |
| Require Compliant/Azure AD Joined Devices | Restrict access to managed devices only           | Target: All users<br>Condition: Device state compliant or Azure AD joined<br>Access: Grant if compliant |
| Block Risky Sign-ins          | Block sign-ins flagged risky by Microsoft Entra ID | Target: All users<br>Condition: Sign-in risk medium or higher<br>Access: Block |

### References

- [Windows Hello for Business Full Cloud Deployment](https://learn.microsoft.com/en-us/windows/security/identity-protection/hello-for-business/hello-identity-verification)  
- [Configure Windows Hello for Business with Intune](https://learn.microsoft.com/en-us/mem/intune/configuration/device-profiles#windows-hello-for-business)  
- [Azure AD Conditional Access](https://learn.microsoft.com/en-us/azure/active-directory/conditional-access/overview)  

---

