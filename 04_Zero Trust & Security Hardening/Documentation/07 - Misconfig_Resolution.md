# 🔴  Security Misconfiguration Identified & Resolved

## ✅ 1. Disable Legacy Protocols (IMAP, POP3, SMTP)
### Impact
Even with MFA enabled, legacy protocols such as IMAP, POP3, and SMTP allow Basic Authentication which can be exploited to bypass modern authentication mechanisms. Disabling these protocols significantly reduces the risk of credential-based attacks.

---

### 0️⃣. Set PowerShell Execution Policy to allow scripts

- Open PowerShell as Administrator and run:

```powershell
Set-ExecutionPolicy RemoteSigned
```
- Then close the Administrator PowerShell window and open a new regular PowerShell session.
---

### 1️⃣. Install and import the Exchange Online Management module (if not installed)

```powershell
Install-Module -Name ExchangeOnlineManagement -Force
Import-Module ExchangeOnlineManagement
```
---

### 2️⃣. Connect to Exchange Online

```powershell
Connect-ExchangeOnline -UserPrincipalName your.email@domain.com
```
![Exchange_Connected](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/04_Zero%20Trust%20%26%20Security%20Hardening/Screenshots/Exchange_Connected.png)

---

### 3️⃣ Disable Basic Authentication for Legacy Protocols

- Basic Authentication exposes security risks and should be disabled for legacy protocols in Exchange Online.

#### Step 1: Create a new Authentication Policy to block Basic Authentication

```powershell
New-AuthenticationPolicy -Name "Block Basic Auth"
```

#### Step 2: Modify the policy if needed

This policy disables Basic Authentication for all legacy protocols.

```powershell
Set-AuthenticationPolicy -Identity "Block Basic Auth" `
    -AllowBasicAuthImap:$false `
    -AllowBasicAuthPop:$false `
    -AllowBasicAuthSmtp:$false
```

#### Step 3: Verify the policy settings

```powershell
Get-AuthenticationPolicy -Identity "Block Basic Auth" | Format-List *
```
![All_Basic_Auth_false](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/04_Zero%20Trust%20%26%20Security%20Hardening/Screenshots/All_Basic_Auth_false.png)

All `AllowBasicAuth` properties should be set to `False`.

---

#### Step 4: Assign the Authentication Policy to users
Replace <UserPrincipalName> with the user’s UPN.

```powershell
Set-User -Identity <UserPrincipalName> -AuthenticationPolicy "Block Basic Auth"
```

#### Step 5: Verify the policy assignment

```powershell
Get-User -Identity <UserPrincipalName> | Format-List AuthenticationPolicy
```
![Sophia_legacy_policy](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/04_Zero%20Trust%20%26%20Security%20Hardening/Screenshots/Sophia_legacy_policy.png)

---

### 4️⃣. Disable SMTP AUTH Globally
SMTP AUTH is a legacy protocol that can be exploited if enabled unnecessarily.

#### 4.1 Disable SMTP AUTH for the Entire Organization
```powershell
Set-TransportConfig -SmtpClientAuthenticationDisabled $true
```
#### 4.2 Verify SMTP AUTH Status
```powershell
Get-TransportConfig | Format-List SmtpClientAuthenticationDisabled
```
Ensure the output shows:
```yaml
SmtpClientAuthenticationDisabled : True
```

![Disable_SMTP](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/04_Zero%20Trust%20%26%20Security%20Hardening/Screenshots/disable_SMTP.png)

---

### 5️⃣. Disable IMAP and POP3 Protocols Per User
For additional security, disable IMAP and POP3 access on users' mailboxes who do not require it.

#### 5.1 Disable IMAP and POP3 for a Specific User

```powershell
Set-CASMailbox -Identity "user@example.com" -ImapEnabled $false -PopEnabled $false
```

#### 5.2 Disable IMAP and POP3 for All Users

```powershell
Get-Mailbox -ResultSize Unlimited | Set-CASMailbox -ImapEnabled $false -PopEnabled $false
```
#### 5.3 Verify IMAP & POP3 Status

```powershell
Get-CASMailbox -ResultSize Unlimited | Select Name, ImapEnabled, PopEnabled
```

![Imap_POP_Disabled](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/04_Zero%20Trust%20%26%20Security%20Hardening/Screenshots/imap_pop_disabled.png)


---

## ✅ 2. No Control Over Software Installations


### ⚠️ Risk

- **Malware and ransomware infections** via untrusted applications
- **Unpatched vulnerabilities** in outdated software versions
- **Shadow IT**, leading to loss of visibility and compliance issues
- **Increased attack surface** for lateral movement or privilege escalation

---

### Solution

1. **Microsoft Intune – Device Restriction Policies**
   - Blocked the ability to install Win32 apps from unknown sources
   - Allowed installations **only from the Microsoft Store** (optional for stricter environments)

2. **AppLocker – Application Whitelisting**
   - Created and deployed AppLocker rules via **Intune Configuration Profiles**
   - Only approved applications (e.g., Microsoft 365 apps, company tools) were whitelisted
   - Default-deny policy applied to unknown executables and installers

---


### 💎 Benefits
> "To reduce the attack surface, I restricted software installations to approved applications via Intune policies and AppLocker". 

- Reduced malware risk through strict application control
- Enforced security compliance and governance
- Increased endpoint hygiene and operational consistency
- Improved alignment with **Zero Trust** and **ISO/IEC 27001** controls on asset management

---



## 4. bitlocker active mais sans backup securisé :

   azure ad -> devoces -> clique sur la machine -> recovery keys

   i verified that bitlocker recovery keys were properly backed up to azure ad, ensuring data recovery and compliance.

## 5. pas dexpiration ou de rotation de mot de passe admin local

   laps -> integré a intune
---

## 6. pas de journalisation dacces ou activité

   activer audit log dans entra id
   activer sign in logs+ ennvoyer vers sentinel
---
