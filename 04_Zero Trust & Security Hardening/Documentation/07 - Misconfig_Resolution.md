# 🔴  Security Misconfiguration Identified & Resolved

🔴 1. Disable Legacy Protocols (IMAP, POP3, SMTP)

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
![Exchange_Connected](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/04_Zero%20Trust%20%26%20Security%20Hardening/Screenshots/Exchange_Connected.png)

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
![All_Basic_Auth_false](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/04_Zero%20Trust%20%26%20Security%20Hardening/Screenshots/All_Basic_Auth_false.png)

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
![Sophia_legacy_policy](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/04_Zero%20Trust%20%26%20Security%20Hardening/Screenshots/Sophia_legacy_policy.png)

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

![Disable_SMTP](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/04_Zero%20Trust%20%26%20Security%20Hardening/Screenshots/disable_SMTP.png)

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

![Imap_POP_Disabled](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/04_Zero%20Trust%20%26%20Security%20Hardening/Screenshots/imap_pop_disabled.png)


## 🔴 2. No Control Over Software Installations

📍 **Goal:** Prevent users from installing unauthorized software (.msi or .exe)

---

### ⚠️ Risk

- Malware and ransomware infections via untrusted applications  
- Unpatched vulnerabilities in outdated software  
- Increased attack surface for lateral movement or privilege escalation  

---

## ✅ Combined Solution Strategy

To fully control software installations, **two layers of protection are required**:

1. 🔒 **Block Windows Installer (.msi)** — via Intune Settings Catalog  
2. 🔒 **Block unauthorized `.exe` installers** — via AppLocker rules in Intune  

> ❗ **Note:** Using only one method leaves gaps — `.msi` blocking doesn't stop `.exe` files like `chrome_installer.exe`. Likewise, AppLocker alone won't prevent Windows Installer usage. **Both are needed for robust protection.**

---

### 🔒 1. Block Windows Installer (.msi)

**Platform:** Windows 10 and later  
**Profile type:** Settings Catalog

### Configuration Steps:

- Go to: `Intune Admin Center → Devices → Configuration profiles → + Create profile`
- In the Settings picker, search:
  - `Windows Components > Windows Installer > Turn off Windows Installer`  
    → Set to **Enabled**  
    → Choose: **Always**
- Also add:
  - `Administrative Templates > Start Menu and Taskbar > Remove Run menu from Start Menu`  
    → Set to **Enabled** (optional hardening)

---

### 🔒 2.  Block Specific Installers and Applications with AppLocker (Recommended)

  ### 1. Open Group Policy Management Console

- Press `Win + R`, type `gpmc.msc`, and press Enter.

### 2. Create or Edit a GPO

- Right-click your target Organizational Unit (OU) or domain.
- Select **Create a GPO in this domain, and Link it here...** or edit an existing GPO.

### 3. Navigate to AppLocker Settings

- Go to:  
  `Computer Configuration > Policies > Windows Settings > Security Settings > Application Control Policies > AppLocker`

### 4. Configure Rule Collections

You will see four rule collections:

- Executable Rules
- Windows Installer Rules
- Script Rules
- Packaged app Rules

### 5. Create Default Rules (Recommended)

- Right-click each rule collection and select **Create Default Rules**.  
  These allow all files in `Program Files` and `Windows` folders by default.

### 6. Create Custom Rules

- To block or allow specific apps:
  - Right-click a rule collection (e.g., Executable Rules) → **Create New Rule...**
  - Use the wizard to select:
    - **Action**: Allow or Deny
    - **Conditions**: Publisher, Path, or File Hash
  - For example, to block `chrome_installer.exe`, create a Deny rule based on the file path or hash.

### 7. Set Enforcement Mode

- Right-click **AppLocker** in the left pane → **Properties**.
- Choose to enforce rules or audit only for each rule collection.

### 8. Start Application Identity Service on Clients

- On each client machine, run `services.msc`.
- Find **Application Identity** service.
- Set Startup type to **Automatic** and start the service.

---

## Testing and Deployment

- Deploy the GPO to the target computers.
- Test in **Audit mode** to monitor what would be blocked without enforcing.
- After testing, switch enforcement mode to **Enforce** to block unauthorized apps.

---

## Additional Notes

- AppLocker policies only apply on Enterprise and Education editions of Windows.
- Always backup existing policies before making changes.
- Use event logs (`Event Viewer > Applications and Services Logs > Microsoft > Windows > AppLocker`) to troubleshoot.

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
