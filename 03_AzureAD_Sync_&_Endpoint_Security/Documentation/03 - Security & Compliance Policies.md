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
| Enforce attestation        | ❌ No             | Not required unless verified device metadata needed                         |
| Enforce key restrictions   | ✅ Yes            | Prevent use of unapproved or unknown FIDO2 keys                            |
| Restrict specific keys     | 🔒 Block          | Block specific keys by vendor AAGUID                                       |
| Microsoft Authenticator    | ❌ No             | Separate passwordless method, can be enabled alongside FIDO2   |

![FIDO2 Policy](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/03_AzureAD_Sync_%26_Endpoint_Security/Screenshots/FIDO2-Policy.png)

---

> ⚠️ Disclaimer: Due to the absence of a physical FIDO2 key, the Microsoft Authenticator method was enabled solely for demonstration purposes. The registration and sign-in steps illustrated below reflect the FIDO2 process as documented by Microsoft, but use the Authenticator interface to simulate user interaction.

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

---

### ✅ Result: Secure Passwordless Login

Access is granted using **strong phishing-resistant authentication**

![Sign-In_ACtivity](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/03_AzureAD_Sync_%26_Endpoint_Security/Screenshots/Sign-in_Activity.png)

> 🔐 FIDO2 offers hardware-backed protection against password theft, phishing, and MFA fatigue.

---
🔗 For official guidance on FIDO2 setup and supported authentication methods, refer to the Microsoft documentation:
> [FIDO2 registration steps – Microsoft Learn](https://learn.microsoft.com/en-us/entra/identity/authentication/how-to-enable-passkey-fido2)

---

### ✅ Final State: Secure Authentication Profile  

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



---

# 🔴 **Conditional Access Policies - Recommended Settings**

| Policy Name                    | Purpose                                             | Key Settings                                                         |
|-------------------------------|-----------------------------------------------------|----------------------------------------------------------------------|
| Block Legacy Authentication    | Block insecure protocols like IMAP, POP, SMTP      | Target: All users<br>Client apps: Legacy auth<br>Access: Block      |
| Require MFA for All Users      | Enforce MFA for all sign-ins                        | Target: All users<br>Access: Require MFA                            |
| Require Compliant Devices      | Allow access only from compliant or Azure AD joined devices | Target: All users<br>Device state: Require compliant or Azure AD joined<br>Access: Grant if compliant |
| Block Risky Sign-ins           | Block sign-ins flagged as risky                      | Target: All users<br>Sign-in risk: Medium or higher<br>Access: Block|

