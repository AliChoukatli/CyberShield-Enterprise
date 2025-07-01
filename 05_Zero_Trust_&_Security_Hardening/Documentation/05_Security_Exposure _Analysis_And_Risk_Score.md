# 🔎 Security Exposure Analysis, Remediation & Risk Management

## 🎯 Objective

Reduce exposures reported by **Microsoft Defender for Endpoint (MDE)** through actions like **ASR rules**, Defender configuration, system updates, and document any accepted residual risks.

## 📝 Introduction

Effective exposure management helps reduce attack surfaces. This section shows a **real-world fix** for a high alert from MDE’s **TVM** dashboard.

You’ll follow step-by-step remediations mapped to Microsoft security recommendations, covering both **automated defenses** (e.g., ASR rules, PUA blocking, Controlled Folder Access) and **manual risk acceptance**, aligned with business and operational needs.

This structured approach reinforces Zero Trust principles and supports frameworks such as **NIST** and **ISO/IEC 27001**.

## 🔴 Index

1. [🔍 Initial Exposure Level Summary](#-initial-exposure-level-summary)

2. [🔐 Security Recommendations](#-security-recommendations)
   
   - [✅ Applied Remediation](#-applied-remediation)

     - [🧩 Update Microsoft Windows 11](#-1-update-microsoft-windows-11-os-and-built-in-applications)
     - [🚫 Turn on PUA Protection in Block Mode](#-2-turn-on-pua-protection-in-block-mode)
     - [📁 Set Controlled Folder Access](#-3-set-controlled-folder-access-to-enabled-or-block-mode)
     - [🚫 Block Credential Stealing from LSASS](#-4-block-credential-stealing-from-lsass-local-security-authority-subsystem)
     - [🌐 Enable Network Protection](#-5-enable-network-protection)
     - [🚫 Block Executables in Email - Intune](#-6-block-executable-content-from-email-client-and-webmail---intune-method)
     - [🚫 Block USB Executables - GPO](#-7-block-untrusted-and-unsigned-processes-from-usb-devices---gpo-method)
     - [🔎 Verify ASR Rules](#---how-to-verify-if-asr-rules-are-applied)

   - [🟡 Accepted Risk](#-accepted-risks)
     - [🔑 Min Password < 14](#-1-set-minimum-password-length-to-less-than-14-characters)

4. [🧾 Conclusion](#-conclusion)

---

## 🔍 Initial Exposure Level Summary
1. Go to the Microsoft 365 Defender portal:  [https://security.microsoft.com](https://security.microsoft.com)
   
- **Exposure Level**: High
- **Device**: `LTP-HLP01`

![LTP-HLP01_Score](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/05_Zero_Trust_%26_Security_Hardening/Screenshots/LTP-HLP01_Exposure_Level.png)



## 🔐 Security Recommendations 
- The following are prioritized security controls and remediations to address high-risk exposures detected by Microsoft Defender for Endpoint.

### 🔴 Two different types of responses were demonstrated:

- ✅ Applied Remediation
- 🟡 Risk acceptance 

![LTP-HLP01_Recommendations](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/05_Zero_Trust_%26_Security_Hardening/Screenshots/LTP-HLP01_Recommendations.png)

| Control                                                      | Risk Level | Impact   | Justification                                                                                    |
|--------------------------------------------------------------|------------|----------|--------------------------------------------------------------------------------------------------|
| 🔒 Update Microsoft Windows 11 (OS and apps)                | High        | High    | Critical security patches fix vulnerabilities and protect system integrity.                       |
| 🔒 Turn on PUA protection in block mode                     | High        | High    | Blocks potentially unwanted applications that may compromise security.                            |
| 🔒 Set controlled folder access to Block Mode               | High        | High     | Protects against ransomware by restricting unauthorized file changes.                            |
| 🔒 Block credential stealing from LSASS                     | High        | High    | Prevents theft of credentials (hashes) used in lateral movement and privilege escalation attacks. |
| 🔒 Enable Network Protection                                | Medium      | Medium  | Blocks network access to malicious domains and reduces attack surface.                            |
| 🔒 Block executable content from email client and webmail   | Medium      | Medium   | Prevents execution of malicious content delivered via email.                                     |
| 🔒 Block untrusted and unsigned processes from USB          | Medium      | Medium   | Protects from malware spreading via USB removable devices.                                       |


---

## ✅ Applied Remediation

### 🧩 1. Update Microsoft Windows 11 (OS and Built-in Applications)

#### **Description:** Ensure all Windows 11 system components and built-in apps are up-to-date.

#### **Purpose:** Regular OS updates patch critical vulnerabilities and mitigate exploitation risks.

![Req_win11_update](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/05_Zero_Trust_%26_Security_Hardening/Screenshots/Req_Win11update.png)

#### ✅ Remediation: 

Apply the latest Windows 11 security updates using enterprise patch management solutions (e.g., Microsoft Intune, WSUS, or SCCM).


---

### 🚫 2. Turn on PUA Protection in Block Mode

#### **Description:** Enables Microsoft Defender Antivirus to detect and block **Potentially Unwanted Applications (PUAs)**. These may include:
- Adware
- Crypto mining tools

#### **Purpose:** Blocking PUAs strengthens endpoint security by:
- Reducing attack surface from non-malicious but risky applications
- Preventing installation of apps that may degrade system performance or be used as vectors in larger attacks

![PUA_Req](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/05_Zero_Trust_%26_Security_Hardening/Screenshots/PUA_Req.png)

#### ✅ **Remediation** – PowerShell Script

PUA protection was enabled in **Block Mode** using the following script, executed on target systems:

```powershell
Set-MpPreference -PUAProtection 1
```
1 = Enable in Block Mode
(0 = Disable, 2 = Audit Mode)

To confirm the setting:

```powershell
Get-mpPreference | ft PUAProtection
```

![PUA_Fix](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/05_Zero_Trust_%26_Security_Hardening/Screenshots/PUA_Fix.png)

---

### 📁 3. Set Controlled Folder Access to Enabled or Block Mode

#### **Description:** Enable ransomware protection by locking critical folders against unauthorized access.

#### **Purpose:** Defends against ransomware attempting to encrypt sensitive user files.

![Folder_Req](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/05_Zero_Trust_%26_Security_Hardening/Screenshots/Folder_Req.png)

#### ✅ **Remediation**

- 1. Open Registry Editor
   - Press `Win + R`, type `regedit`, and press `Enter`.

- 2. Navigate to:
     
```reg
HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender
```
- 3. Create Required Keys (if not present)
  - Right-click on **Windows Defender** → `New` → `Key` → name it:
  - Windows Defender Exploit Guard
  - - Then right-click on **Windows Defender Exploit Guard** → `New` → `Key` → name it: `Controlled Folder Access`

- 4. Add the DWORD Value
  - Select the `Controlled Folder Access` key.
  - Right-click in the right pane → `New` → `DWORD (32-bit) Value`.
  - Name it:
`EnableControlledFolderAccess`
  - Set its value:
  - `1` = Enabled (Block Mode) ✅ **Recommended**

![Folder_fix](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/05_Zero_Trust_%26_Security_Hardening/Screenshots/Folder_fix.png)

---

### 🚫 4. Block Credential Stealing from LSASS (Local Security Authority Subsystem)

-  **Description** : This prevent credential theft by blocking unauthorized access to the LSASS.
-  **Purpose:** Prevent malware from dumping credentials from `lsass.exe` using tools like Mimikatz.
-  **Default Behavior:** Enabled in **Block Mode**.
- ⚠️ This rule does **not** support **Warn Mode**.
- ⚠️ If **LSA protection** is already enabled, this rule is **not applicable** and does not provide extra protection.


![lsaas_Req](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/05_Zero_Trust_%26_Security_Hardening/Screenshots/lsass_Req.png)

#### ✅ **Remediation**

- To enable this rule in **Block Mode**, add the following registry key and value: 

```reg
HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Windows Defender Exploit Guard\ASR\Rules
```
- ⚠️ If the path doesn't exist, manually create each subkey:
Windows Defender Exploit Guard > ASR > Rules

- Add the following **String Value** inside the `Rules` key:

| Name (String)                                      | Type           | Value  |
|----------------------------------------------------|----------------|--------|
| `9E6C4E1F-7D60-472F-BA1A-A39EF669E4B2`             | `String Value` | `"1"`  |

- `"1"` = Block Mode 🚫 

![lsaas_fix](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/05_Zero_Trust_%26_Security_Hardening/Screenshots/lsaas_Fix.png)

---

### 🌐 5. Enable Network Protection

#### **Description:** Network Protection helps protect devices by blocking connections to potentially harmful domains and IPs, using Microsoft Defender SmartScreen.

#### **Purpose:** Prevents users from accessing known malicious websites, reducing exposure to drive-by attacks or social engineering.

![NP_Req](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/05_Zero_Trust_%26_Security_Hardening/Screenshots/NP_Req.png)

#### ✅ **Remediation**

- To enable this rule in **Block Mode**, add the following registry key and value :

```reg
HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Windows Defender Exploit Guard\Network Protection
```

> If the path does not exist, you must **manually create the `Network Protection` key and the value**.



| Name                     | Type      | Value |
|--------------------------|-----------|-------|
| `EnableNetworkProtection` | `REG_DWORD` | `1`   |

- `1` = Enable Network Protection in Block Mode  

![NP_Fix](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/05_Zero_Trust_%26_Security_Hardening/Screenshots/NP_Fix.png)

---


### 🚫 6. Block Executable Content from Email Client and Webmail - Intune Method

#### **Description:** Prevent direct execution of embedded content or malicious attachments received via email.

#### **Purpose:** Email is a common initial attack vector. This control reduces phishing and malware payload delivery.

![Exe_Req](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/05_Zero_Trust_%26_Security_Hardening/Screenshots/Exe_Req.png)

#### ✅ **Remediation with Intune**

1. Go to the **Microsoft Intune Admin Center**: [https://intune.microsoft.com](https://intune.microsoft.com)
2. Navigate to:  
   `Endpoint Security` → `Attack Surface Reduction`
3. Click on **+ Create Policy**
   - Platform: **Windows**
   - Profile: **Attack surface reduction rules**
4. Configure the following:
   - Rule name: `Block executable content from email client and webmail`
   - Look for `Block executable content from email client and webmail`
   - Action: `Block`
5. Assign the policy to your **targeted devices Eg: Windows 10/11 Devices*

![Exe_email_opolicy_review](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/05_Zero_Trust_%26_Security_Hardening/Screenshots/Exe_Email_policy_intune.png)
   
7. Review + Create

> ✅ Once deployed, the rule will be enforced on all assigned devices.

![Exe_Fix](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/05_Zero_Trust_%26_Security_Hardening/Screenshots/Exe_Email_policy_Overview.png)

---

### 🚫 6.5 - Block Executable Content from Email Client and Webmail - Registery Method

![Exe_Fix](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/05_Zero_Trust_%26_Security_Hardening/Screenshots/Exe_Fix.png)

---

### 🚫 7. Block Untrusted and Unsigned Processes from USB Devices - GPO Method

**Description**: Blocks execution of untrusted or unsigned executable files originating from USB drives.

**Purpose**: Prevents malware infections and lateral movement through USB-based attacks, commonly used for delivering ransomware or trojans.

#### ✅ **Remediation:**

1. Open the **Group Policy Management Console (GPMC)** on a domain controller or management workstation.

2. Create a new GPO or edit an existing one linked to the target OU(s) or domain.

3. Navigate to:  
   `Computer Configuration` > `Preferences` > `Windows Settings` > `Registry`

4. Right-click **Registry**, select **New** > **Registry Item**.

5. Configure the new registry item as follows:

   - **Action:** Update  
   - **Hive:** HKEY_LOCAL_MACHINE  
   - **Key Path:** `SOFTWARE\Policies\Microsoft\Windows Defender\Windows Defender Exploit Guard\ASR\Rules`  
   - **Value name:** `b2b3f03d-6a65-4f7b-a9c7-1c7ef74a9ba4`
   - **Value type:** `REG_SZ`  
   - **Value data:** `1` (`"1"` enables the rule in **Block mode**)

![USB_GPO](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/05_Zero_Trust_%26_Security_Hardening/Screenshots/USB_GPO.png)

6. Click **OK** to save.

7. Close the Group Policy Editor and ensure the GPO is linked correctly.

8. On target machines, run `gpupdate /force` or wait for policy refresh

---

## 🔎 - How to Verify if ASR Rules Are Applied

This guide explains how to check whether **Microsoft Defender Attack Surface Reduction (ASR) rules** are active on a system, and to display each rule along with its configured action (`Block`, `Audit`, `Warn`, or `Disabled`).

You can run the following PowerShell script to get the list of ASR rules applied and their corresponding actions in a readable format.

### ▶️ PowerShell Script

```powershell
$ids = (Get-MpPreference).AttackSurfaceReductionRules_Ids
$actions = (Get-MpPreference).AttackSurfaceReductionRules_Actions

for ($i = 0; $i -lt $ids.Count; $i++) {
    [PSCustomObject]@{
        Rule_GUID = $ids[$i]
        Action    = switch ($actions[$i]) {
            0 { "Disabled" }
            1 { "Block" }
            2 { "Audit" }
            6 { "Warn" }
            Default { "Unknown" }
        }
    }
}

```

![ASR_verif](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/05_Zero_Trust_%26_Security_Hardening/Screenshots/ASR_Verif.png)

| GUID                                   | Nom de la règle ASR                                                         |
|---------------------------------------|------------------------------------------------------------------------------|
| 9E6C4E1F-7D60-472F-BA1A-A39EF669E4B2  | 🔒 Block Credential Stealing from LSASS (Local Security Authority Subsystem)    |
| BE9BA2D9-53EA-4CDC-84E5-9B1EEEE46550  | 🔒 Block Executable Content from Email Client and Webmail                      |
| b2b3f03d-6a65-4f7b-a9c7-1c7ef74a9ba4  | 🔒 Block Untrusted and Unsigned Processes from USB Devices                      |

---

## 🟡 Accepted Risks

| Control                                                  | Risk Level | Impact           | Justification                                                                                              | Decision  |
|----------------------------------------------------------|------------|----------------- |------------------------------------------------------------------------------------------------------------|-----------|
| Set Minimum Password Length to less than 14 characters   | Low        | Low              | Current policy requires 12 characters for compatibility; MFA and lockout mitigate risk.                    | Accepted 
| Disable 'Autoplay' for all drives                        | Low        | Low              | Modern Windows restrict autoplay by default; full disable may impact user experience with trusted devices. | Accepted  |
| Disable Defender Firewall notifications                  | Low        | Low              | Notifications off reduces user noise; monitoring remains via logs and centralized tools.                   | Accepted  |


### 🔑 1. Set 'Minimum Password Length' to less than 14 characters

**Risk Description:**  
The recommendation is to enforce a minimum password length of 14 or more characters. Shorter passwords increase the risk of brute force attacks and password guessing.

**Risk Acceptance:**  
"We accept the risk of using a minimum password length less than 14 characters because the current policy enforces a minimum of 12 characters.

**Justification:**  
- Implementation of Multi-Factor Authentication (MFA).  
- Account lockout thresholds configured to prevent brute force attempts.  
- Regular password change policies and user education on password strength.

![Passwd_Risk_Acc](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/05_Zero_Trust_%26_Security_Hardening/Screenshots/passwd_Risk_Accepted.png)

---


## ✅ Conclusion 

-  Identified vulnerabilities through Microsoft Defedner Recommendations.
-  Implemented prioritized remediation actions.  
-  Aligned with ISO 27001 & NIST standards.
