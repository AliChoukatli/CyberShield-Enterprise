# Security Misconfiguration Identified & Resolved

## 1. Disable Legacy Protocols (IMAP, POP3, SMTP) and PowerShell Access in Exchange Online

### Impact
Even with MFA enabled, legacy protocols such as IMAP, POP3, and SMTP allow Basic Authentication which can be exploited to bypass modern authentication mechanisms. Disabling these protocols significantly reduces the risk of credential-based attacks.

---

### 0️⃣. Set PowerShell Execution Policy to allow scripts

Open PowerShell as Administrator and run:

```powershell
Set-ExecutionPolicy RemoteSigned
```

### 1️⃣. Install and import the Exchange Online Management module (if not installed)

```powershell
Install-Module -Name ExchangeOnlineManagement -Force
Import-Module ExchangeOnlineManagement
```


### 2️⃣. Connect to Exchange Online

```powershell
Connect-ExchangeOnline -UserPrincipalName your.email@domain.com
```
---

### 3️⃣. Disable Basic Authentication for Legacy Protocols

Microsoft has deprecated Basic Authentication for IMAP, POP3, and SMTP to improve security. While many tenants have this disabled by default, verify and enforce it explicitly.

#### 3.1 Create or Update an Authentication Policy to Block Basic Auth

```powershell
Set-AuthenticationPolicy -Identity "Block Basic Auth" `
  -AllowBasicAuthImap $false `
  -AllowBasicAuthPop $false `
  -AllowBasicAuthSmtp $false
```
#### 3.2 Assign the Authentication Policy to Users

To assign the policy to all mailbox users:
```powershell
Get-User -Filter {RecipientTypeDetails -eq 'UserMailbox'} | Set-User -AuthenticationPolicy "Block Basic Auth"
```

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

### 6️⃣. Disable PowerShell Access for Users
To prevent the use of legacy PowerShell remoting that could be abused, disable PowerShell access if it is not needed.

#### 6.1 Disable Remote PowerShell Access for a User
```powershell
Set-CASMailbox -Identity "user@example.com" -RemotePowerShellEnabled $false
```

#### 6.2 Disable Remote PowerShell Access for All Users
```powershell
Get-Mailbox -ResultSize Unlimited | Set-CASMailbox -RemotePowerShellEnabled $false
```











---

## 2. unused guest account sor inactive users still enabled 

Get-azureaduser etc poiwershell

---

## 3. pasd de control sur les insallations logicielles

-> to reduce the attack surface, i restriced software installations to approved applications via intune policeis and applocker.

----

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
