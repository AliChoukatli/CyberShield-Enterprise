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


---

🔴 2. No Control Over Software Installations

📍 Goal: Block users from installing unauthorized software (.msi)

⚠️ Risk

- **Malware and ransomware infections** via untrusted applications
- **Unpatched vulnerabilities** in outdated software versions
- **Increased attack surface** for lateral movement or privilege escalation

✅ Solution

## Specific Settings Configuration in Intune

### 1. Turn off Windows Installer (Always)

- Search in the category:  
  `Windows Components > Windows Installer > Turn off Windows Installer`  
- Set this setting to **Enabled**  
- Choose the **Always** option

---

### 2. Remove Run menu from Start Menu

- Navigate to:  
  `Administrative Templates > Start Menu and Taskbar > Remove Run menu from Start Menu`  
- Set this policy to **Enabled**

---

🔴 3. Block Specific Software Installers via AppLocker in Intune

This guide explains how to block specific applications (e.g., `chrome_installer.exe`, `ZoomInstaller.exe`) using **AppLocker** policies deployed through Microsoft Intune.

📋 Prerequisites
- **Application Identity service** must be enabled and running on target devices

🛠️ Steps to Deploy AppLocker in Intune

1. **Open Microsoft Intune Admin Center**
   - Go to:  
     `Endpoint security` → `Attack surface reduction` → **+ Create Policy**

2. **Configure the Profile**
   - **Platform:** Windows 10 and later  
   - **Profile:** AppLocker (Windows 10 and later)

3. **Define AppLocker Rules**
   - Under **Executable Rules**:
     - **Deny Rule:** Block specific installers by name  
       Example:
       - `chrome_installer.exe`
       - `ZoomInstaller.exe`
     - **Allow Rules:** Whitelist only approved paths like:  
       - `C:\Program Files\Microsoft Office\`
       - `C:\Program Files (x86)\YourCompanyApp\`
   - Under **Windows Installer Rules**:
     - Deny `.msi` execution from unknown sources
   - Under **Script Rules**:
     - Block `.ps1`, `.vbs`, etc., unless signed and trusted
   - Set the **Default behavior** to: **Deny all** (only allow what is explicitly permitted)

4. **Deploy the Policy**
   - Assign the policy to a **pilot device group** (e.g., test users or non-admin workstations)

5. **Testing Phase**
   - Start with **Audit Mode** to see which apps would be blocked
   - Monitor via:  
     `Intune > Reports > AppLocker policy status`

6. **Enforce the Policy**
   - Once verified, switch to **Enforce Mode** to actively block execution

---

### 📌 Notes

- AppLocker is powerful but must be tested carefully to avoid breaking legitimate apps.
- For organizations using **Windows Pro**, AppLocker is not available — consider using **Microsoft Defender Application Control (WDAC)** instead.
- If you need to block unsigned `.exe` or scripts more broadly, WDAC offers more advanced capabilities.

---

### 🔍 Monitoring & Maintenance

- Check **Event Viewer** on endpoints:  
  `Applications and Services Logs > Microsoft > Windows > AppLocker`
- Review policy health in:  
  `Intune Admin Center > Endpoint security > AppLocker > Reports`


  - etc.

---

This configuration allows you to:  
- Block installations via Windows Installer (.msi)  
- Remove the "Run" menu from the Start Menu to limit quick access to installation tools  
- Explicitly block common setup executables from running

For more comprehensive control over allowed applications, it is recommended to also use AppLocker or WDAC.
---

### 2. AppLocker – Application Whitelisting

📍 **Goal:** Only allow execution of approved applications.

##### 🧭 Prerequisites:
- Devices must be **Windows 10/11 Enterprise or Education**
- The **Application Identity service** must be running

##### 🧭 Steps:
1. In Intune, go to **Endpoint security** → **Attack surface reduction** → **+ Create policy**
   - Platform: *Windows 10 and later*
   - Profile: *AppLocker (Windows 10 and later)*

2. Define AppLocker rules:
   - **Executable Rules**: Allow only approved paths (e.g., `C:\Program Files\Microsoft Office\`)
   - **Windows Installer Rules**: Block `.msi` files from unknown sources
   - **Script Rules**: Block PowerShell or VBS unless signed and trusted
   - Set default behavior to **Deny** all other software

3. Assign the policy to the same pilot group

4. Use **Audit Mode first**, then switch to **Enforce Mode** once verified (this helps avoid business disruptions).

5. Monitor policy effectiveness in **Intune > Reports > AppLocker policy status**

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
