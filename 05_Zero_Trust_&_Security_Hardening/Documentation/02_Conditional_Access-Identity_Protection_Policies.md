# 🔴 Conditional Access & Identity Protection Policies

---

## 🎯 Objective

This guide covers the implementation of Conditional Access (CA) and Identity Protection policies in Microsoft Entra ID (Azure AD). These policies enable IT administrators to enforce granular access controls based on user, device, location, and risk signals to protect cloud resources, implement Zero Trust security principles, and ensure compliance.

---

## 📝 Introduction

Conditional Access in Microsoft Entra ID provides a powerful mechanism to restrict or allow access to corporate resources based on configurable conditions such as device compliance, user risk level, location, and authentication method. Implementing CA policies helps reduce attack surfaces by enforcing Multi-Factor Authentication (MFA), blocking legacy authentication protocols, restricting access from unmanaged devices, and limiting sign-ins to trusted locations.

This document details key Conditional Access policies recommended for securing modern enterprise environments:

- Blocking legacy authentication protocols to prevent insecure sign-in methods  
- Requiring MFA for all administrative roles and users  
- Blocking portal access from unmanaged devices  
- Enforcing device compliance  
- Restricting access from unsupported geographic locations  

By following these guidelines, organizations can strengthen their identity security posture, protect privileged accounts, and align with industry best practices.

---

## 📘 Table of Contents

1. ✅ [Block Legacy Authentication](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/04_Zero%20Trust%20&%20Security%20Hardening/Documentation/02%20-%20Conditionnal_Access.md#-1-block-legacy-authentication)
   
 - [Option A — Disable Legacy Protocols via Exchange Online (Recommended)](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/04_Zero%20Trust%20&%20Security%20Hardening/Documentation/02%20-%20Conditionnal_Access.md#-option-a--disable-legacy-protocols-via-exchange-online-recommended)

 - [Option B - Use Conditional Access to Block Legacy Authentication](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/04_Zero%20Trust%20&%20Security%20Hardening/Documentation/02%20-%20Conditionnal_Access.md#-option-b--use-conditional-access-to-block-legacy-authentication)

2. ✅ [Require MFA for All Admin Roles](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/04_Zero%20Trust%20&%20Security%20Hardening/Documentation/02%20-%20Conditionnal_Access.md#-2-require-mfa-for-all-admin-roles)

3. ✅ [Block Admin Portal Access from Unmanaged Devices](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/04_Zero%20Trust%20&%20Security%20Hardening/Documentation/02%20-%20Conditionnal_Access.md#-3-block-admin-portal-access-from-unmanaged-devices)
   
4. ✅ [Require MFA for All Users](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/04_Zero%20Trust%20&%20Security%20Hardening/Documentation/02%20-%20Conditionnal_Access.md#-4-require-mfa-for-all-users)
   
5. ✅ [Require Compliant Devices](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/04_Zero%20Trust%20&%20Security%20Hardening/Documentation/02%20-%20Conditionnal_Access.md#-5-require-compliant-devices)
   
6. ✅ [Block Access from Unsupported Countries](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/04_Zero%20Trust%20&%20Security%20Hardening/Documentation/02%20-%20Conditionnal_Access.md#-6-block-access-from-unsupported-countries)
   
---

## ✅ 1. Block Legacy Authentication

### 🎯 Objective

Prevent the use of outdated and insecure authentication protocols such as IMAP, POP3, SMTP AUTH, and MAPI that do not support modern security features like Multi-Factor Authentication (MFA).

> ⚠️ **Note:** Microsoft no longer provides a dedicated "Legacy Authentication" setting under Authentication Methods in Entra ID. You must now block legacy authentication using Exchange Online settings and Conditional Access alternatives.

---

### Option A — Disable Legacy Protocols via Exchange Online (Recommended)

- Install and connect with Exchange Online PowerShell Module (EXO V2).
- Disable legacy protocols on mailboxes individually or globally.
- Verify settings post-configuration.

---

Modern security best practices recommend disabling legacy authentication protocols such as POP, IMAP, MAPI, ActiveSync, and SMTP basic auth, which do not support modern authentication (MFA, Conditional Access, etc.).
Before running the commands, make sure you:

1. Have the **Exchange Online Management Module (EXO V2)** installed.
2. Are connected to Exchange Online PowerShell with appropriate permissions.

#### 🔹 To connect, open PowerShell and run:

```powershell
Connect-ExchangeOnline -UserPrincipalName your_admin@domain.com
```
> Replace your_admin@domain.com with your actual admin account.

#### 🔹 Disable Legacy Protocols for a Single Mailbox
Use this command to disable legacy protocols on one specific user:
```powershell
Set-CASMailbox user@domain.com `
  -PopEnabled $false `
  -ImapEnabled $false `
  -MAPIEnabled $false `
  -ActiveSyncEnabled $false `
  -SmtpClientAuthenticationDisabled $true
```
> Replace user@domain.com with the actual user's email.

#### 🔹Disable Legacy Protocols for All Mailboxes
Apply the same settings to all users in the organization:
```powershell
Get-CASMailbox -ResultSize Unlimited | Set-CASMailbox `
  -PopEnabled $false `
  -ImapEnabled $false `
  -MAPIEnabled $false `
  -ActiveSyncEnabled $false `
  -SmtpClientAuthenticationDisabled $true
```
✅ If no errors are shown, the command has run successfully.

#### 🔹 Verify Status
Run the following to confirm that the protocols are disabled:

```powershell
Get-CASMailbox -ResultSize Unlimited | Select Name, UserPrincipalName, PopEnabled, ImapEnabled, MAPIEnabled, ActiveSyncEnabled, SmtpClientAuthenticationDisabled
```
![Disable Legacy Protocols-PS](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/03_AzureAD_Sync_%26_Endpoint_Security/Screenshots/Disable%20Legacy%20Protocols-PS.png)

### Option B — Use Conditional Access to Block Legacy Authentication

- Create a new CA policy targeting legacy authentication clients only.
- Block access.
- Enable and test carefully to avoid lockouts.

(Full instructions with PowerShell commands and screenshots above.)

---

Microsoft has reintroduced a simplified option to block legacy authentication clients in Conditional Access.

### 🧭 How to Configure:

1. Go to: [https://entra.microsoft.com](https://entra.microsoft.com)
2. Navigate to: `Protection > Conditional Access`
3. Click **+ New policy**
4. Name the policy: **Block Legacy Authentication**
5. Under **Assignments > Users**, select: **All users**
   - (Optional) Exclude break-glass accounts
6. Under **Assignments > Cloud apps**, select: **All cloud apps**
7. Under **Conditions > Client apps**:
   - Click **Configure = Yes**
   - Select only:
     - **Legacy authentication clients**
       - ✅ **Exchange ActiveSync clients**
       - ✅ **Other clients**
       - ❌ **Do not select**: Browser, Mobile apps and desktop clients, or Modern authentication clients
8. Under **Access controls > Grant**, select:
     - ❌ **Block access**
9. Enable the policy: **On**
10. Click **Create**

![Block_Legacy-Policy](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/03_AzureAD_Sync_%26_Endpoint_Security/Screenshots/Block_Legacy-Policy.png)

> ⚠️ This Conditional Access policy helps block basic authentication (IMAP, POP, SMTP AUTH, etc.), but you should also disable these protocols in Exchange Online for full protection.

---

## ✅ 2. Require MFA for All Admin Roles

### 🎯 Objective

Protect all privileged accounts by enforcing MFA.

- Target directory roles assigned to admins.
- Apply CA policy requiring MFA for access to all cloud apps.

---

### 🧭 How to Configure:

1. Go to **Microsoft Entra Admin Center** > **Protection** > **Conditional Access**  
2. Click **+ New policy**  
3. Name the policy: `Require MFA for Admins`  
4. Under **Assignments** > **Users**, click Select **users and groups**
5. Select **Directory roles**  
6. Choose all administrative roles (e.g. Global administrator, Security administrator,Conditional Access administrator, Intune Administrator etc.)
7. Under **Target Resources**, select all cloud apps
8. Leave **Conditions** empty (optional: configure risk-based conditions)  
9. Under **Access controls** > **Grant**, select:  
   - **Grant access**  
   - Check **Require multi-factor authentication**  
11. Enable the policy  
12. Click **Create**

![MFA-All_Admin](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/03_AzureAD_Sync_%26_Endpoint_Security/Screenshots/MFA-All_Admin.png)

> ⚠️ This policy ensures that all privileged accounts are protected by MFA, reducing the risk of compromise.

---

## ✅ 3. Block Admin Portal Access from Unmanaged Devices

### 🎯 Objective

Restrict administrative portal access (Microsoft Entra, Intune, M365 Admin Center) to only compliant, managed devices.

- Target all users.
- Grant access only if device is compliant.
- Block otherwise.


## 🧭 How to Configure

1. Go to: [https://entra.microsoft.com](https://entra.microsoft.com)
2. Navigate to: `Protection > Conditional Access`
3. Click **+ New policy**
4. Name the policy: `Block Admin Portal Access from Unmanaged Devices`

---

### 🔹 Assignments

- **Users**:  
  - Choose `All users`  

- **Target Resources > Cloud Apps or Actions**:  
  - Select: **Microsoft Admin Portals**  
    *(Includes Microsoft Entra, Intune, M365 Admin Center, Defender Portal, etc.)*
    
5. Under **Access controls > Grant**, select:
   - ✅ **Grant access**
   - ✅ **Require device to be marked as compliant**
   - ❌ Uncheck all other options
   - Click **Select**
   - **Enable policy** to `On`
   - Click **Create**


![Admin_Portal_Policy](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/03_AzureAD_Sync_%26_Endpoint_Security/Screenshots/Admin_Portal_Policy.png)

---


## ✅ 4. Require MFA for All Users

### 🎯 Objective

Enhance security by requiring MFA for all sign-ins.

- Target all or pilot users.
- Apply CA policy requiring MFA for all cloud app access.

**Purpose**: Enforce Multi-Factor Authentication (MFA) to protect user sign-ins from credential theft and phishing.

### 🧭 How to Configure:

1. Go to **Microsoft Entra Admin Center** > **Protection** > **Conditional Access**
2. Click **+ New policy**
3. Name it: `Require MFA for All Users`
4. Under **Assignments** > **Users**, select **All users** (or a pilot group)
5. Under **Target Resources**, select **All cloud apps**
6. Leave **Conditions** empty (optional: configure risk-based conditions)
7. Under **Access controls** > **Grant**, choose:
   - **Grant access**
   - Check **Require multi-factor authentication**
8. Enable the policy
9. Click **Create**

![MFA-Policy](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/03_AzureAD_Sync_%26_Endpoint_Security/Screenshots/MFA-Policy.png)

---

## ✅ 5. Require Compliant Devices

### 🎯 Objective

Ensure access is only granted from devices that meet compliance requirements (e.g., managed by Intune, compliant with security policies).

**Purpose**: Ensure that only secure, managed, and compliant devices can access organizational resources.

### 🧭 How to Configure:

1. Go to **Microsoft Entra Admin Center** > **Protection** > **Conditional Access**
2. Click **+ New policy**
3. Name the policy: `Require Compliant Devices`
4. Under **Assignments** > **Users**, select **All users**
5. Under **Target Resources**, choose **All cloud apps**
6. Under **Conditions**:
   - Go to **Device platforms** > *Configure* (include Windows, macOS)
7. Under **Access controls** > **Grant**, choose:
   - **Grant access**
   - Check **Require device to be marked as compliant**
8. Enable the policy
9. Click **Create**

![Compliance_Devices_Policy](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/03_AzureAD_Sync_%26_Endpoint_Security/Screenshots/Compliance_Devices_Policy.png)

---

## ✅ 6. Block Access from Unsupported Countries

### 🎯 Objective

Limit sign-in access to trusted geographic regions.

- Define trusted countries in Named Locations.
- Create CA policy to block access from other locations.
- Exclude break-glass accounts to prevent lockout.

---

**Purpose:**  
Restrict access to organizational resources from untrusted or high-risk geographic locations by allowing only selected trusted countries.

This policy helps mitigate the risk of unauthorized access from regions where your organization has no presence or operational need.

---

### 🛡️ Step 1 — Define Trusted Locations

Before creating the Conditional Access policy, define your trusted countries in Microsoft Entra:

1. Go to: [https://entra.microsoft.com](https://entra.microsoft.com)
2. Navigate to: **Protection > Risky Activities > Named locations**
3. Click **+ Countries location**
4. Name it: `Trusted Countries`
5. Select countries you trust (e.g., ✅ France, ✅ Canada, ✅ Netherlands, ✅ USA)
6. Click **Create**

![Trusted_Locations](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/03_AzureAD_Sync_%26_Endpoint_Security/Screenshots/Trusted_Locations.png)

> 💡 You can later reuse this location group in other Conditional Access policies.

---

### 🛡️ Step 2 — Create the Conditional Access Policy

1. Go to: [https://entra.microsoft.com](https://entra.microsoft.com)
2. Navigate to: **Protection > Conditional Access**
3. Click **+ New policy**
4. Name it: `Block Access from Unsupported Countries`

#### 🔹 Assignments:
- **Users**: `All users` *(or pilot group)*
- **Cloud apps**: `All cloud apps`

#### 🔹 Conditions:
- **Locations**:
  - Set **Configure** to ✅ **Yes**
  - **Include**: `Any location`
  - **Exclude**: `Trusted Countries` *(created earlier)*

#### 🔹 Access controls:
- Under **Grant**:
  - Choose ❌ `Block access`

5. Enable the policy: ✅ **On**
6. Click **Create**

![Block_Countries](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/03_AzureAD_Sync_%26_Endpoint_Security/Screenshots/Block_Countries.png)

> ⚠️ **Tip:** Be careful not to lock yourself out. Exclude break-glass accounts or test on a pilot group before applying it to all users.

---

## 🔴 Conditionnal Access Summary

![All_Condi_Policy](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/03_AzureAD_Sync_%26_Endpoint_Security/Screenshots/All_Condi_policy.png)


---

## 🔚 Conclusion

Implementing Conditional Access and Identity Protection policies is a foundational step toward a robust Zero Trust security model. These policies mitigate risks from compromised credentials, unauthorized devices, and risky geographic locations by enforcing strong authentication and device compliance requirements.

By systematically blocking legacy authentication, requiring MFA for privileged and regular users, restricting access to managed devices, and limiting sign-ins by geography, organizations can significantly reduce their attack surface and enhance overall security posture.

Regularly review and update these policies to adapt to evolving threats and maintain compliance with industry standards.
