# 03 - Security Compliance & Policies

Modern enterprise environments face constant threats targeting user identities, devices, and cloud resources. Implementing robust security policies—such as Conditional Access, Multi-Factor Authentication, and compliance enforcement—is critical to support Zero Trust principles and meet compliance requirements.

This section covers security compliance settings and policies essential to secure the environment and enforce best practices.

---

# 🔴 Security Policies Overview

| Policy Area                 | Description                                                        |
|----------------------------|--------------------------------------------------------------------|
| **Conditional Access (CA)**| Enforces granular access controls based on user, device, location, and risk level. |
| **Multi-Factor Authentication (MFA)** | Adds a second layer of verification to strengthen identity security.        |
| **Device Compliance**       | Ensures devices meet security baselines (patching, encryption, antivirus). |
| **Identity Protection**     | Uses risk detection and mitigation to prevent compromised accounts. |


# 🔴 Multi-Factor Authentication (MFA)

The project implements MFA using the following modern methods:

![Auth-Methods](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/03_AzureAD_Sync_%26_Endpoint_Security/Screenshots/Auth-Methods.png)


## 1. ✅  **Temporary Access Pass (TAP) – Recommended Settings**

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


## 👤  End-User MFA Experience: Temporary Access Pass Flow (Sophia Martinez)

This scenario demonstrates how a new employee, **Sophia Martinez**, securely registers her first authentication method using a **Temporary Access Pass (TAP)**.

---

### 🔹 Step 1: Admin generates TAP for new user

In Microsoft Entra ID (Azure AD), the admin navigates to:

**Users > Sophia Martinez > Authentication Methods > Add Auth Method > Temporary Access Pass**

Configuration example:

| Setting        | Value         |
|----------------|---------------|
| Lifetime       | 1 hour        |
| One-time use   | Yes           |
| Length         | 8 characters  |

![TAP-SOphia-Steps](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/03_AzureAD_Sync_%26_Endpoint_Security/Screenshots/TAP-Sophia-Steps.png)

The temporary password will be shown on the screen : 

![Temp-TAP-Details](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/03_AzureAD_Sync_%26_Endpoint_Security/Screenshots/Temp-TAP-Details.png)

---

### 🔹 Step 2: User signs in with TAP

At her first login, Sophia selects **“Sign in using Temporary Access Pass”**, and enters the code provided by the admin.

![Temp-TAP](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/03_AzureAD_Sync_%26_Endpoint_Security/Screenshots/Temp-TAP.png)

She is then prompted to set a new PIN since we configured alreadywindows Hello for business

![New-PIN](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/03_AzureAD_Sync_%26_Endpoint_Security/Screenshots/New-PIN.png)

---

##  Windows Hello for Business

### ✅ Hybrid Deployment (Azure AD + On-premises Active Directory)

### Prerequisites

- Windows Server 2016 or later for domain controllers
- Domain Verified
- Azure AD Connect configured for hybrid Azure AD join
- Windows 10/11 client device with TPM enabled and compatible with Windows Hello
- Administrative privileges to create and edit Group Policy Objects (GPO)

---

### Step 1: Verify Prerequisites on Client Device

- Open PowerShell as an administrator and run:

```powershell
dsregcmd /status
```
- Check the output:

  - AzureAdJoined or DomainJoined should be YES

  - Device State should indicate Hybrid Azure AD joined
 
![dsregcmd_status](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/03_AzureAD_Sync_%26_Endpoint_Security/Screenshots/dsregcmd_status_emp01.png)

- Also verify TPM status by running **tpm.msc**

![TPM](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/03_AzureAD_Sync_%26_Endpoint_Security/Screenshots/TPM.png)

> **Result:** TPM is present and ready (Hyper-V secure boot & TPM enabled)

---

### Step 2: Create and Configure the GPO for Windows Hello for Business

 1. Open Group Policy Management Console (GPMC) on your domain controller (gpmc.msc)

 2. Navigate to the appropriate Organizational Unit (OU) or domain.

3. Right-click → Create a GPO in this domain, and Link it here...

4.  Name the GPO (e.g., Windows Hello for Business - Key Trust).

5.  Edit the GPO:

  - Go to:
```rust
Computer Configuration → Policies → Administrative Templates → Windows Components → Windows Hello for Business
 ```
![Hello-GPO](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/03_AzureAD_Sync_%26_Endpoint_Security/Screenshots/Hello-GPO.png)

6. On each Windows client device, open PowerShell as admin and run:
```Powershell
gpupdate /force
```

2. Then reboot the device to apply the policy.

---

### Step 3: Register Windows Hello for Business on Client

Go to **Settings → Accounts → Sign-in options**

1. Set up a **Windows Hello PIN**.
2. If supported, enable **biometric sign-in** (fingerprint or facial recognition).
3. Follow the on-screen instructions to complete setup.
4. Ensure the device allows passwordless sign-in using Hello credentials.

### Step 4 Verify Passwordless Sign-in is Enabled

1. Open **Settings** → **Accounts** → **Sign-in options**.
2. Confirm that **Windows Hello PIN** or **Biometric sign-in** (fingerprint or facial recognition) is set up.
3. Check under **Security settings** or **Sign-in options** that **Passwordless sign-in** or **Windows Hello** is enabled.

---

> ⚠️ Note: For Hybrid Azure AD Join scenarios, Windows Hello for Business configuration should be done via Group Policy (GPO).  
> The previous method using Intune’s "Identity Protection" profile is deprecated and no longer supported.

---

## ✅ Full Cloud Deployment (Azure AD Join only)

### Overview

- Devices are joined directly to Azure AD (no on-prem AD)
- Managed via Microsoft Intune (Microsoft Endpoint Manager)
- Passwordless sign-in using biometrics and PIN secured by TPM
- Requires Azure AD Premium P1 or P2 licenses
- Conditional Access used to enforce MFA and device compliance

---

## 🔧 Configure Windows Hello for Business via Intune

1. Go to **Microsoft Intune Admin Center**:  
   `https://intune.microsoft.com`

2. Navigate to:  
   **Endpoint security > Account protection** → Click **+ Create Policy**

3. Choose:

   - **Platform**: *Windows 10 and later*
   - **Profile**: *Account protection*

4. Click **Create**, then fill in:

   - **Name**: *Windows Hello for Business
   - **Description** (optional)

5. ## Recommended Settings
 
| Setting                                          | Recommended Value                                                                                                 
|--------------------------------------------------|-----------------------------|
| **Facial Features Use Enhanced Anti Spoofing**   | ✅ True     
| **Enable PIN Recovery**                          | ✅ True                 
| **Expiration**                                   | ✅ 90                     
| **PIN History**                                  | ✅ 5                       
| **Lowercase & Uppercase Letters**                | ✅ Required        
| **Minimum PIN Length**                           | ✅ 8                        
| **Maximum PIN Length**                           | ✅ 127                     
| **Special Characters**                           | ✅ Required                          
| **Require Security Device (TPM)**                | ✅ True                  
| **Use Certificate For On-Prem Auth**             | ✅ Enabled    

![Hello-Policy-Config](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/03_AzureAD_Sync_%26_Endpoint_Security/Screenshots/Hello-Policy-Config.png)

6. Click **Next**, assign to appropriate user or device groups.

7. Complete and click **Create**.

![Hello-Policy](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/03_AzureAD_Sync_%26_Endpoint_Security/Screenshots/Hello-Policy.png)

---

## 👤 End-User MFA Experience: Windows Hello for Business (Sophia Martinez)

Once the policy is applied, users will:

1. Go to **Settings → Accounts → Sign-in options**
2. Click **Set up** under **PIN (Windows Hello)**

![Hello-Verif](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/03_AzureAD_Sync_%26_Endpoint_Security/Screenshots/Hello-Verif.png)

5. Optionally enable **Fingerprint** or **Face Recognition**, if available

> ✅ The device is now fully cloud-joined and uses passwordless sign-in with TPM-backed credentials.

![Hello-Set](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/03_AzureAD_Sync_%26_Endpoint_Security/Screenshots/hello-set.png)


By enforcing granular Conditional Access rules, multi-factor authentication, and secure passwordless sign-in options like FIDO2 and Windows Hello for Business, this configuration strengthens both security posture and user experience—while aligning with industry best practices and compliance standards.

---

## 3. ✅  **Microsoft Authenticator App – Recommended Settings**

| Setting                                            | Recommended Value       | Description                                                                                   |
|----------------------------------------------------|--------------------------|-----------------------------------------------------------------------------------------------|
| **Enable and Target**                              | ✅ Enabled               | Method is enabled for users                                                                   |
| **Target**                                         | 🎯 All users             | Include all users or a specific security group                                                |
| **Allow use of Microsoft Authenticator OTP**       | ✅ Yes                  | Allows use of TOTP codes from the app in addition to push notifications                      |
| **Require number matching for push notifications** | ✅ Enabled (mandatory)   | Prevents MFA fatigue attacks by requiring users to enter the number shown on the screen      |
| **Show application name in notifications**         | ☁️ Microsoft-managed     | App name shown in push/passwordless notifications                                            |
| **Show geographic location in notifications**      | ☁️ Microsoft-managed     | Location info shown to detect suspicious logins                                             |
| **Authenticator on companion apps**                | ☁️ Microsoft-managed     | Controls use on devices like Apple Watch                                                    |


## 👤 End-User MFA Experience: Microsoft Authenticator Flow (Sophia Martinez)

This example demonstrates a typical end-user multi-factor authentication (MFA) flow in a Microsoft 365 cloud-only environment.  
The scenario features **Sophia Martinez**, an employee at CyberShield, logging in securely using **Microsoft Authenticator** with number matching and biometric confirmation.

---

### 🔹 Step 1: Microsoft Authenticator App Setup Prompt  
After entering her corporate email address, Sophia is prompted to configure the **Microsoft Authenticator App** as part of her initial sign-in experience.

> _“Start by getting the app.”_

![Sophia MFA 1](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/03_AzureAD_Sync_%26_Endpoint_Security/Screenshots/Sophia-Auth.png)

She clicks **Next**, and is then asked to enter her **Microsoft account password** to continue.

---

### 🔹 Step 2: Number Matching Prompt Displayed  
Once the password is verified, a **number matching prompt** appears on the screen.  

![MFA-Number-Matching](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/03_AzureAD_Sync_%26_Endpoint_Security/Screenshots/MFA-number-matching.png)

Sophia opens the **Microsoft Authenticator App** on her mobile device and selects her corporate account.

---

### 🔹 Step 3: Number Matching and Biometric Verification  
In the app, Sophia is prompted to enter the number shown on the login screen:

![Phone_N-Matching](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/03_AzureAD_Sync_%26_Endpoint_Security/Screenshots/Phone_N-Matching.png)

After entering the correct number, she approves the request using her **fingerprint** or **device passcode**.

---

### 🔹 Step 4: Successful Authentication  
Upon successful verification, access is granted:

![Sophia MFA Success](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/03_AzureAD_Sync_%26_Endpoint_Security/Screenshots/Sophia-MFA-successful.png)

> 🔒 This MFA flow protects against phishing, token theft, and MFA fatigue attacks by combining number matching and biometric confirmation.
---

### 🔑 Key Takeaways:
- Microsoft Authenticator enforces a modern, phishing-resistant MFA experience.
- Number matching ensures the user is physically present at the time of sign-in.
- Biometric or PIN-based confirmation ensures that only the legitimate user can approve the login.

---
## 4. ✅  **FIDO2 Security Key (Passkey) – Recommended Settings**

| Setting                     | Recommended Value | Description                                                                 |
|----------------------------|-------------------|-----------------------------------------------------------------------------|
| Allow self-service set up  | ✅ Yes            | Users can register their own FIDO2 keys                                    |
| Enforce attestation        | ✅ Yes           | Not required unless verified device metadata needed                         |
| Enforce key restrictions   | ✅ Yes            | Prevent use of unapproved or unknown FIDO2 keys                            |
| Restrict specific keys     | 🔒 Block          | Block specific keys by vendor AAGUID                                       |
| Microsoft Authenticator    | ❌ No             | Separate passwordless method, can be enabled alongside FIDO2               |

---

> ⚠️ Disclaimer: Due to the absence of a physical FIDO2 key, the Microsoft Authenticator method was enabled solely for demonstration purposes. The registration and sign-in steps illustrated below reflect the FIDO2 process as documented by Microsoft, but use the Authenticator interface to simulate user interaction.

![FIDO2 Policy](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/03_AzureAD_Sync_%26_Endpoint_Security/Screenshots/Fido2-Policy.png)

---

## 👤 End-User Experience: FIDO2 Security Key (Sophia Martinez)

Sophia is required to register and use a **FIDO2 security key** as part of her passwordless authentication methods. This key allows strong, phishing-resistant authentication.

### 🔹 Step 1: Add FIDO2 Security Key via Security Info Portal

Sophia visits [https://myprofile.microsoft.com](https://myprofile.microsoft.com) and navigates to:

> **Security Info** → **Add sign-in method** → Selects `Security Key`

![Security-Key](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/03_AzureAD_Sync_%26_Endpoint_Security/Screenshots/Security-Key.png)

She is prompted to choose the type of key:

- USB Key (e.g., YubiKey)
- NFC Key

---

### 🔹 Step 2: Register the Key

After choosing USB, Sophia is asked to: 

1. Insert the key into a USB port.

![Insert-Key](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/03_AzureAD_Sync_%26_Endpoint_Security/Screenshots/Insert-Key.png)

2. Windows will check the device
3. Create or enter the PIN for the key
4. Touch the key sensor to confirm

> 🧪 *This step requires physical interaction with the key (touching the sensor). Since no physical key was used, this demonstration reflects the expected process.*

![PassKey-Saved](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/03_AzureAD_Sync_%26_Endpoint_Security/Screenshots/Passkey-Saved.png)

5. Once complete, she gives the key a **custom name** (e.g., "Sophia Key")

![Sophia-Key](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/03_AzureAD_Sync_%26_Endpoint_Security/Screenshots/Sofia-Key.png)

---

### 🔹 Step 3: Sign-in using Security Key

The next time Sophia signs in, she selects:

> **"Sign-in options"** → **Use security key**

![Signin-Options](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/03_AzureAD_Sync_%26_Endpoint_Security/Screenshots/Signin-Options.png)

1. Inserts her key  
2. Enters the key PIN

![Sophia-KeyPIN](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/03_AzureAD_Sync_%26_Endpoint_Security/Screenshots/Sophia-KeyPIN.png)

3. Touches the key when prompted

![Signin-Key](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/03_AzureAD_Sync_%26_Endpoint_Security/Screenshots/Signin-key.png)


> ✅ Result: Secure Passwordless Login

Access is granted using **strong phishing-resistant authentication**

![Sign-In_ACtivity](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/03_AzureAD_Sync_%26_Endpoint_Security/Screenshots/Sign-in_Activity.png)

> 🔐 FIDO2 offers hardware-backed protection against password theft, phishing, and MFA fatigue.

🔗 For official guidance on FIDO2 setup and supported authentication methods, refer to the Microsoft documentation:
> [FIDO2 registration steps – Microsoft Learn](https://learn.microsoft.com/en-us/entra/identity/authentication/how-to-enable-passkey-fido2)

---

### ✅ Final State: Secure Authentication Profile (Sophia Martinez)

| Authentication Method        | Status         | Purpose                         |
|-----------------------------|----------------|---------------------------------|
| Temporary Access Pass (TAP) | ✔️ Completed   | Initial sign-in                 |
| WHfB PIN (TPM-backed)       | ✔️ Enrolled    | Passwordless sign-in on device |
| Microsoft Authenticator MFA | ✔️ Enrolled    | Second factor                   |
| FIDO2 Security Key          | ⬜️ Optional    | Hardware passwordless option    |

![Sophia-Auth_Methods](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/03_AzureAD_Sync_%26_Endpoint_Security/Screenshots/Sophia-Auth_Methods.png)

---

### 🔐 Compliance Mapping

| Security Standard         | Control ID / Section        | Implementation in this Project                           |
|---------------------------|-----------------------------|----------------------------------------------------------|
| ISO/IEC 27001             | A.9.4.2 – Secure log-on     | MFA via Conditional Access & Authenticator App           |
| NIST SP 800-53 Rev. 5     | IA-2 – Identification & Auth| FIDO2 Keys, Temporary Access Pass, Number Matching MFA   |
| CIS Critical Security Controls | Control 16 – Application Security | Device Compliance, Windows Hello for Business |

Sophia now has a secure, modern identity that supports **Zero Trust principles**, including **phishing resistance**, **passwordless access**, and **strong user verification**.

---


# 🔴 Conditional Access Policies – Recommended Settings

Conditional Access (CA) in Microsoft Entra ID enables IT admins to enforce policies that restrict or allow access to cloud resources based on conditions such as device state, user risk, and app types. These policies implement Zero Trust principles and are critical to securing identity infrastructure.

---

## ✅ 1. Block Legacy Authentication

**Purpose:** Prevent the use of outdated and insecure authentication protocols such as IMAP, POP3, SMTP AUTH, and MAPI that do not support modern security features like Multi-Factor Authentication (MFA).

> 📌 **Note:** Microsoft no longer provides a dedicated "Legacy Authentication" setting under Authentication Methods in Entra ID. You must now block legacy authentication using Exchange Online settings and Conditional Access alternatives.

---

### 🔒 Option A — Disable Legacy Protocols via Exchange Online (Recommended)

Modern security best practices recommend disabling legacy authentication protocols such as POP, IMAP, MAPI, ActiveSync, and SMTP basic auth, which do not support modern authentication (MFA, Conditional Access, etc.).

#### 🛠️ Prerequisites

Before running the commands, make sure you:

1. Have the **Exchange Online Management Module (EXO V2)** installed.
2. Are connected to Exchange Online PowerShell with appropriate permissions.

To connect, open PowerShell and run:

```powershell
Connect-ExchangeOnline -UserPrincipalName your_admin@domain.com
```
> Replace your_admin@domain.com with your actual admin account.

#### Disable Legacy Protocols for a Single Mailbox
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

#### Disable Legacy Protocols for All Mailboxes
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

#### Verify Status
Run the following to confirm that the protocols are disabled:

```powershell
Get-CASMailbox -ResultSize Unlimited | Select Name, UserPrincipalName, PopEnabled, ImapEnabled, MAPIEnabled, ActiveSyncEnabled, SmtpClientAuthenticationDisabled
```


### 🛡️ Option B — Use Conditional Access to Block Legacy Authentication

Microsoft has reintroduced a simplified option to block legacy authentication clients in Conditional Access.

#### 🧭 Steps:

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

### 📊 Monitor Legacy Usage (Sign-in Logs)

1. Go to: `Monitoring > Sign-in logs`
2. Add filter: **Client app**
3. Look for sign-ins using:
   - Legacy authentication clients
   - Other clients (e.g., non-modern)

---


## ✅ 2. Require MFA for All Users

**Purpose**: Enforce Multi-Factor Authentication (MFA) to protect user sign-ins from credential theft and phishing.

### 🧭 How to Configure:

1. Go to **Microsoft Entra Admin Center** > **Protection** > **Conditional Access**
2. Click **+ New policy**
3. Name it: `Require MFA for All Users`
4. Under **Assignments** > **Users**, select **All users** (or a pilot group)
5. Under **Cloud apps**, select **All cloud apps**
6. Leave **Conditions** empty (optional: configure risk-based conditions)
7. Under **Access controls** > **Grant**, choose:
   - **Grant access**
   - Check **Require multi-factor authentication**
8. Enable the policy
9. Click **Create**

📸 **Screenshot Instructions**:
- Screenshot of **Assignments**: All users, all apps
- Screenshot of **Access controls**: Grant access + Require MFA

---

## ✅ 3. Require Compliant or Azure AD Joined Devices

**Purpose**: Ensure that only secure, managed, and compliant devices can access organizational resources.

### 🧭 How to Configure:

1. Go to **Microsoft Entra Admin Center** > **Protection** > **Conditional Access**
2. Click **+ New policy**
3. Name the policy: `Require Compliant Devices`
4. Under **Assignments** > **Users**, select **All users**
5. Under **Cloud apps**, choose **All cloud apps**
6. Under **Conditions**:
   - Go to **Device platforms** > *Configure* (Optional: include Windows, macOS, iOS, Android)
   - Go to **Device state** > *Configure*
     - Select **Require Hybrid Azure AD joined** or **Require compliant device**
7. Under **Access controls** > **Grant**, choose:
   - **Grant access**
   - Check **Require device to be marked as compliant**
8. Enable the policy
9. Click **Create**

📸 **Screenshot Instructions**:
- Screenshot of **Device state** configuration
- Screenshot of **Grant access** settings with compliant device selected

---

## ✅ 4. Block Risky Sign-ins

**Purpose**: Block sign-ins that Microsoft detects as risky (e.g. unfamiliar location, impossible travel, credential leaks).

### 🧭 How to Configure:

1. Go to **Microsoft Entra Admin Center** > **Protection** > **Conditional Access**
2. Click **+ New policy**
3. Name it: `Block Risky Sign-ins`
4. Under **Assignments** > **Users**, select **All users**
5. Under **Cloud apps**, choose **All cloud apps**
6. Under **Conditions**:
   - Go to **Sign-in risk** > *Configure*
   - Choose **Medium and above**
7. Under **Access controls** > **Grant**, choose:
   - **Block access**
8. Enable the policy
9. Click **Create**

📸 **Screenshot Instructions**:
- Screenshot of **Sign-in risk condition**
- Screenshot of **Access controls** set to block

---

> 💡 **Tip**: Always test Conditional Access policies on a pilot group or break-glass account before enforcing them globally to prevent accidental lockouts.

