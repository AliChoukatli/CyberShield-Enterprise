
# 🔴 Security Controls Implementation

## 🎯 Objective

Implement critical security controls to harden Windows endpoints against common attack vectors, including **unauthorized local admin rights**, **uncontrolled software installation**, and **legacy protocol abuse**. These configurations reinforce Zero Trust principles and minimize the risk of privilege escalation, malware infection, and credential theft.

## 📝 Introduction

Misconfigurations such as default local admin privileges, open installer access, and legacy protocol exposure are major entry points for attackers. This section guides you through the remediation of these risks using a layered defense strategy combining **Microsoft Intune**, **Group Policy Objects (GPO)**, and **Exchange Online PowerShell**.

You'll implement:
- Local administrator rights restriction via **Intune policies**
- Software installation control using both **Intune** and **AppLocker GPO**
- Deactivation of **legacy protocols** (IMAP, POP3, SMTP) that bypass MFA

Each step includes a validated configuration, screenshots, and PowerShell commands to ensure enterprise-grade endpoint protection.

---

## 🚫 **1. Restrict Local Administrator Rights on Azure AD Joined Devices**

### 🚨 **Problem**
By default, when a device is **Azure AD Joined**, the first user who signs in becomes a **local administrator**.

### 🎯 **Goal :** Prevent all Azure AD users from automatically becoming local administrators on Windows devices. Only allow members of a specific Azure AD group (e.g., "Local Admins") to have local admin rights.

### ✅ Solution

#### 3.1– Create an Azure AD Group for Local Admins

1. Go to **Microsoft Entra Admin Center**.
2. Create a **Security Group**:
   - **Name**: `Local Admins`
   - **Description**: Users allowed to be local administrators on endpoints
   - Membership Type: Assigned 
3. Add the appropriate users (e.g., Ali).

#### 3.2 – Configure Intune Policy

1. Open **Microsoft Intune Admin Center**.
2. Navigate to:
   
```yaml
Endpoint security → Account protection → + Create policy
```

3. Configure the policy:
   - **Platform**: Windows 10 and later
   - **Profile**: Local user group membership

4. Set up the configuration:

   - **Group**: `Administrators`
   - **Action**: `Replace`  
   - **Members**: Select your Azure AD group `Local Admins`

5. Assign this policy to the targeted group of devices (e.g., all corporate Windows endpoints).

![Local_Admin_intune_policy](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/05_Zero_Trust_%26_Security_Hardening/Screenshots/Local_Admin_intune_policy.png)

#### 3.3 – Verify on a Device

1. Restart the targeted machine.
2. Open:
   
```yaml
Computer Management → Local Users and Groups → Groups → Administrators
```
![Local_Ali](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/05_Zero_Trust_%26_Security_Hardening/Screenshots/Local_Ali.png)

---

## 🚫 **2. Turn off Software Installations**

### 🚨Problem
- Malware and ransomware infections via untrusted applications  
- Unpatched vulnerabilities in outdated software  
- Increased attack surface for lateral movement or privilege escalation  

### 🎯 **Goal :**
Prevent users from installing unauthorized software (.msi or .exe)

✅ Combined Solution Strategy

To fully control software installations, **two layers of protection are required**:

1. 🔒 **Block Windows Installer (.msi)** — via Intune Settings Catalog  
2. 🔒 **Block unauthorized `.exe` installers** — via AppLocker rules with GPO  

> ❗ **Note:** Using only one method leaves gaps — `.msi` blocking doesn't stop `.exe` files like `chrome_installer.exe`. Likewise, AppLocker alone won't prevent Windows Installer usage. **Both are needed for robust protection.**

---

### 🔒 2.1 - Block Windows Installer with Intune (.msi)

- Go to: `Intune Admin Center → Devices → Configuration profiles → + Create profile`
- **Platform:** Windows 10 and later  
  **Profile type:** Settings Catalog
- In the Settings picker, search:
  - `Windows Components > Windows Installer > Turn off Windows Installer`  
    → Set to **Enabled**  
    → Choose: **Always**
- Also add:
  - `Administrative Templates > Start Menu and Taskbar > Remove Run menu from Start Menu`  
    → Set to **Enabled** (optional hardening)

  ![msi_policy](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/05_Zero_Trust_%26_Security_Hardening/Screenshots/Restr_Softw_policy_intune.png)

---

### 🔒 2.2 - Block Specific Installers and Applications with GPO (Recommended)

1. Open Group Policy Management Console

- Press `Win + R`, type `gpmc.msc`, and press Enter.

2. Create or Edit a GPO

- Right-click your target Organizational Unit (OU) or domain.
- Select **Create a GPO in this domain, and Link it here...** or edit an existing GPO.

3. Navigate to AppLocker Settings

- Go to:  
  `Computer Configuration > Policies > Windows Settings > Security Settings > Application Control Policies > AppLocker`

4. Configure Rule Collections

You will see four rule collections:
- Right-click a rule collection (e.g., Executable Rules) → **Create New Rule...**

5. To block or allow specific apps:
  - Use the wizard to select:
    - **Action**: Deny
    - **Conditions**: Path 
  - For example, to block `chrome_installer.exe`, create a Deny rule based on the file path (eg: C:\Users\*\Downloads\chrome_installer.exe)

![chrome_block_GPO](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/05_Zero_Trust_%26_Security_Hardening/Screenshots/chrome_block_GPO.png)

8. Start Application Identity Service on Clients

- On each client machine, run `services.msc`.
- Find **Application Identity** service.

![Application_Identity_Auto](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/05_Zero_Trust_%26_Security_Hardening/Screenshots/Application_Identity_Auto.png)
  
- Set Startup type to **Automatic** and start the service.

---

## Testing and Deployment

- Deploy the GPO to the target computers.
- Test in **Audit mode** to monitor what would be blocked without enforcing.

![AppLocker_Enforcement](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/05_Zero_Trust_%26_Security_Hardening/Screenshots/AppLocker_Enforcement.png)

- After testing, switch enforcement mode to **Enforce** to block unauthorized apps.

---

## 3. Disable Legacy Protocols (IMAP, POP3, SMTP)

 Impact
 
Even with MFA enabled, legacy protocols such as IMAP, POP3, and SMTP allow Basic Authentication which can be exploited to bypass modern authentication mechanisms. Disabling these protocols significantly reduces the risk of credential-based attacks.

---

0️⃣. Set PowerShell Execution Policy to allow scripts

- Open PowerShell as Administrator and run:

```powershell
Set-ExecutionPolicy RemoteSigned
```
- Then close the Administrator PowerShell window and open a new regular PowerShell session.
---

1️⃣. Install and import the Exchange Online Management module (if not installed)

```powershell
Install-Module -Name ExchangeOnlineManagement -Force
Import-Module ExchangeOnlineManagement
```
---

2️⃣. Connect to Exchange Online

```powershell
Connect-ExchangeOnline -UserPrincipalName your.email@domain.com
```
![Exchange_Connected](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/05_Zero_Trust_%26_Security_Hardening/Screenshots/Exchange_Connected.png)

---

3️⃣ Disable Basic Authentication for Legacy Protocols

- Basic Authentication exposes security risks and should be disabled for legacy protocols in Exchange Online.

3.1 Create a new Authentication Policy to block Basic Authentication

```powershell
New-AuthenticationPolicy -Name "Block Basic Auth"
```

3.2 Modify the policy if needed

This policy disables Basic Authentication for all legacy protocols.

```powershell
Set-AuthenticationPolicy -Identity "Block Basic Auth" `
    -AllowBasicAuthImap:$false `
    -AllowBasicAuthPop:$false `
    -AllowBasicAuthSmtp:$false
```

3.3 Verify the policy settings

```powershell
Get-AuthenticationPolicy -Identity "Block Basic Auth" | Format-List *
```
![All_Basic_Auth_false](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/05_Zero_Trust_%26_Security_Hardening/Screenshots/All_Basic_Auth_false.png)

All `AllowBasicAuth` properties should be set to `False`.

---

3.4 Assign the Authentication Policy to users
Replace <UserPrincipalName> with the user’s UPN.

```powershell
Set-User -Identity <UserPrincipalName> -AuthenticationPolicy "Block Basic Auth"
```

3.5 Verify the policy assignment

```powershell
Get-User -Identity <UserPrincipalName> | Format-List AuthenticationPolicy
```
![Sophia_legacy_policy](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/05_Zero_Trust_%26_Security_Hardening/Screenshots/Sophia_legacy_policy.png)

---

4️⃣. Disable SMTP AUTH Globally
SMTP AUTH is a legacy protocol that can be exploited if enabled unnecessarily.

4.1 Disable SMTP AUTH for the Entire Organization
```powershell
Set-TransportConfig -SmtpClientAuthenticationDisabled $true
```
4.2 Verify SMTP AUTH Status
```powershell
Get-TransportConfig | Format-List SmtpClientAuthenticationDisabled
```
Ensure the output shows:
```yaml
SmtpClientAuthenticationDisabled : True
```

![Disable_SMTP](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/05_Zero_Trust_%26_Security_Hardening/Screenshots/disable_SMTP.png)

---

5️⃣. Disable IMAP and POP3 Protocols Per User
For additional security, disable IMAP and POP3 access on users' mailboxes who do not require it.

5.1 - Disable IMAP and POP3 for a Specific User

```powershell
Set-CASMailbox -Identity "user@example.com" -ImapEnabled $false -PopEnabled $false
```
5.2 - Disable IMAP and POP3 for All Users

```powershell
Get-Mailbox -ResultSize Unlimited | Set-CASMailbox -ImapEnabled $false -PopEnabled $false
```
5.3 - Verify IMAP & POP3 Status

```powershell
Get-CASMailbox -ResultSize Unlimited | Select Name, ImapEnabled, PopEnabled
```

![Imap_POP_Disabled](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/05_Zero_Trust_%26_Security_Hardening/Screenshots/imap_pop_disabled.png)

---

## 🔚 Conclusion 

Legacy protocols and local admin rights misconfigurations were identified and remediated.
Systems are now hardened against unauthorized access and unapproved software installations.
