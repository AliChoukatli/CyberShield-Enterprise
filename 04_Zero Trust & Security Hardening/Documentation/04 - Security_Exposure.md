# Security Exposure Analysis, Remediation & Risk Management

## 🔴 Index

This document outlines actions taken to address a **High Exposure Level** reported in the Microsoft Defender for Endpoint (MDE) Threat & Vulnerability Management (TVM) dashboard.

1. 🔒 [Initial Exposure Level Summary](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/04_Zero%20Trust%20&%20Security%20Hardening/Documentation/04%20-%20Exposure_Rem_Local.md#-initial-exposure-level-summary)

2. 🔒 [Security Recommendations ](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/04_Zero%20Trust%20&%20Security%20Hardening/Documentation/04%20-%20Exposure_Rem_Local.md#-security-recommendations)
   - ✅ [Applied Remediation](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/04_Zero%20Trust%20&%20Security%20Hardening/Documentation/04%20-%20Exposure_Rem_Local.md#-applied-remediation)
     
      - [Update Microsoft Windows 11 (OS and Built-in Applications)](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/04_Zero%20Trust%20%26%20Security%20Hardening/Documentation/04%20-%20Security_Exposure.md#-update-microsoft-windows-11-os-and-built-in-applications)
      - [Turn on PUA Protection in Block Mode](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/04_Zero%20Trust%20%26%20Security%20Hardening/Documentation/04%20-%20Security_Exposure.md#-turn-on-pua-protection-in-block-mode)
      - [Set Controlled Folder Access to Enabled or Block Mode](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/04_Zero%20Trust%20&%20Security%20Hardening/Documentation/04%20-%20Security_Exposure.md#-set-controlled-folder-access-to-enabled-or-block-mode)
      - [Block Credential Stealing from LSASS (Local Security Authority Subsystem)](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/04_Zero%20Trust%20&%20Security%20Hardening/Documentation/04%20-%20Security_Exposure.md#-block-credential-stealing-from-lsass-local-security-authority-subsystem)
      - [Enable Network Protection](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/04_Zero%20Trust%20&%20Security%20Hardening/Documentation/04%20-%20Security_Exposure.md#-enable-network-protection)
      - [Block Executable Content from Email Client and Webmail - Intune Method](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/04_Zero%20Trust%20&%20Security%20Hardening/Documentation/04%20-%20Security_Exposure.md#-block-executable-content-from-email-client-and-webmail---intune-method)
      - [Block Untrusted and Unsigned Processes from USB Devices - GPO Method](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/04_Zero%20Trust%20&%20Security%20Hardening/Documentation/04%20-%20Security_Exposure.md#-block-untrusted-and-unsigned-processes-from-usb-devices---gpo-method)
      - [How to Verify if ASR Rules Are Applied](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/04_Zero%20Trust%20&%20Security%20Hardening/Documentation/04%20-%20Security_Exposure.md#-how-to-verify-if-asr-rules-are-applied)
        
   - 🟡 Risk acceptance
     - Disable Defender Firewall notifications
     - Interactive logon: Machine inactivity limit  
3. 🔒 Conclusion
     
---

## 🔴 Initial Exposure Level Summary
1. Go to the Microsoft 365 Defender portal:  [https://security.microsoft.com](https://security.microsoft.com)
   
- **Exposure Level**: High
- **Device**: `LTP-HLP01`

![LTP-HLP01_Score](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/04_Zero%20Trust%20%26%20Security%20Hardening/Screenshots/LTP-HLP01_Exposure_Level.png)

## 🔴 Two different types of responses were demonstrated:

- ✅ Applied Remediation
- 🟡 Risk acceptance 

##  🔴 Security Recommendations 
- The following are prioritized security controls and remediations to address high-risk exposures detected by Microsoft Defender for Endpoint.

![LTP-HLP01_Recommendations](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/04_Zero%20Trust%20%26%20Security%20Hardening/Screenshots/LTP-HLP01_Recommendations.png)

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

### 🧰 Update Microsoft Windows 11 (OS and Built-in Applications)

![Req_win11_update](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/04_Zero%20Trust%20%26%20Security%20Hardening/Screenshots/Req_Win11update.png)

Description:
Ensure all Windows 11 system components and built-in apps are up-to-date.

Justification:
Regular OS updates patch critical vulnerabilities and mitigate exploitation risks.

Remediation: Update Win 11

---

### 🧰 Turn on PUA Protection in Block Mode

![PUA_Req](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/04_Zero%20Trust%20%26%20Security%20Hardening/Screenshots/PUA_Req.png)

🔍 **Description:** 
Enables Microsoft Defender Antivirus to detect and block **Potentially Unwanted Applications (PUAs)**. These may include:
- Adware
- Crypto mining tools

🔍 **Justification:**
Blocking PUAs strengthens endpoint security by:
- Reducing attack surface from non-malicious but risky applications
- Preventing installation of apps that may degrade system performance or be used as vectors in larger attacks

✅ **Remediation Method** – PowerShell Script

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

![PUA_Fix](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/04_Zero%20Trust%20%26%20Security%20Hardening/Screenshots/PUA_Fix.png)

---

### 🧰 Set Controlled Folder Access to Enabled or Block Mode


![Folder_Req](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/04_Zero%20Trust%20%26%20Security%20Hardening/Screenshots/Folder_Req.png)

🔍 **Description:**  
Enable ransomware protection by locking critical folders against unauthorized access.

🔍 **Justification:**  
Defends against ransomware attempting to encrypt sensitive user files.


✅ **Remediation**

#### 1. Open Registry Editor
- Press `Win + R`, type `regedit`, and press `Enter`.

#### 2. Navigate to:
```reg
HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender
```

#### 3. Create Required Keys (if not present)
- Right-click on **Windows Defender** → `New` → `Key` → name it:
Windows Defender Exploit Guard


- Then right-click on **Windows Defender Exploit Guard** → `New` → `Key` → name it: `Controlled Folder Access`

#### 4. Add the DWORD Value
- Select the `Controlled Folder Access` key.
- Right-click in the right pane → `New` → `DWORD (32-bit) Value`.
- Name it:
`EnableControlledFolderAccess`
- Set its value:
- `1` = Enabled (Block Mode) ✅ **Recommended**
---

![Folder_fix](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/04_Zero%20Trust%20%26%20Security%20Hardening/Screenshots/Folder_fix.png)

---

### 🧰 Block Credential Stealing from LSASS (Local Security Authority Subsystem)

![lsaas_Req](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/04_Zero%20Trust%20%26%20Security%20Hardening/Screenshots/lsass_Req.png)

- 🔍 **Description** : This prevent credential theft by blocking unauthorized access to the LSASS.
- 🔍 **Purpose:** Prevent malware from dumping credentials from `lsass.exe` using tools like Mimikatz.
- 🔍 **Applicable when:** You can't enable **LSA Protection** or **Credential Guard** on all devices due to compatibility issues.
- 🔍 **Default Behavior:** Enabled in **Block Mode**.
- ⚠️ This rule does **not** support **Warn Mode**.
- ⚠️ If **LSA protection** is already enabled, this rule is **not applicable** and does not provide extra protection.

---

✅ **Remediation**

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

- `"1"` = Block Mode ✅  

![lsaas_fix](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/04_Zero%20Trust%20%26%20Security%20Hardening/Screenshots/lsaas_Fix.png)

---
### 🧰 Enable Network Protection

![NP_Req](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/04_Zero%20Trust%20%26%20Security%20Hardening/Screenshots/NP_Req.png)

Before enabling Network Protection, ensure the following are active:

- Microsoft Defender Antivirus running  
- Real-time protection enabled  
- Cloud-delivered protection enabled

🔍 **Description:**  
Network Protection helps protect devices by blocking connections to potentially harmful domains and IPs, using Microsoft Defender SmartScreen.

🔍 **Justification:**  
Prevents users from accessing known malicious websites, reducing exposure to drive-by attacks or social engineering.

✅ **Remediation**

- To enable this rule in **Block Mode**, add the following registry key and value :

```reg
HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Windows Defender Exploit Guard\Network Protection
```

> If the path does not exist, you must **manually create the `Network Protection` key and the value**.



| Name                     | Type      | Value |
|--------------------------|-----------|-------|
| `EnableNetworkProtection` | `REG_DWORD` | `1`   |

- `1` = Enable Network Protection in Block Mode  

![NP_Fix](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/04_Zero%20Trust%20%26%20Security%20Hardening/Screenshots/NP_Fix.png)

---


### 🧰 Block Executable Content from Email Client and Webmail - Intune Method

![Exe_Req](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/04_Zero%20Trust%20%26%20Security%20Hardening/Screenshots/Exe_Req.png)

🔍 **Description:**  
Prevent direct execution of embedded content or malicious attachments received via email.

🔍 **Justification:**  
Email is a common initial attack vector. This control reduces phishing and malware payload delivery.

✅ **Remediation with Intune**

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

![Exe_email_opolicy_review](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/04_Zero%20Trust%20%26%20Security%20Hardening/Screenshots/Exe_Email_policy_intune.png)
   
7. Review + Create

✅ Once deployed, the rule will be enforced on all assigned devices.

![Exe_Fix](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/04_Zero%20Trust%20%26%20Security%20Hardening/Screenshots/Exe_Email_policy_Overview.png)

---

### 🧰 Block Untrusted and Unsigned Processes from USB Devices - GPO Method

This guide explains how to enable the Attack Surface Reduction (ASR) rule that blocks untrusted and unsigned processes from running from USB devices by setting the corresponding registry key via Group Policy Object (GPO).

## Steps to configure via GPO

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

![USB_GPO](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/04_Zero%20Trust%20%26%20Security%20Hardening/Screenshots/USB_GPO.png)

6. Click **OK** to save.

7. Close the Group Policy Editor and ensure the GPO is linked correctly.

8. On target machines, run `gpupdate /force` or wait for policy refresh.

---


## ✅ How to Verify if ASR Rules Are Applied

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

![ASR_verif](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/04_Zero%20Trust%20%26%20Security%20Hardening/Screenshots/ASR_Verif.png)

| GUID                                   | Nom de la règle ASR                                                         |
|---------------------------------------|------------------------------------------------------------------------------|
| 9E6C4E1F-7D60-472F-BA1A-A39EF669E4B2  | 🔒 Block Credential Stealing from LSASS (Local Security Authority Subsystem)    |
| BE9BA2D9-53EA-4CDC-84E5-9B1EEEE46550  | 🔒 Block Executable Content from Email Client and Webmail                      |
| b2b3f03d-6a65-4f7b-a9c7-1c7ef74a9ba4  | 🔒 Block Untrusted and Unsigned Processes from USB Devices                      |


---


## 🟡 Accepted Risks

| Control                                         | Risk Level | Impact               | Justification                                                                                              | Decision  |
|-------------------------------------------------|------------|----------------------|------------------------------------------------------------------------------------------------------------|-----------|
| Disable 'Autoplay' for all drives               | Low        | Low                  | Modern Windows restrict autoplay by default; full disable may impact user experience with trusted devices. | Accepted  |
| Interactive logon: Machine inactivity limit     | Low        | Low to Medium        | In physically secured environments, this control can be redundant with other auto-lock measures.           | Accepted  |
| Disable Defender Firewall notifications         | Low        | Low                  | Notifications off reduces user noise; monitoring remains via logs and centralized tools.                   | Accepted  |


# ✅ Risk Acceptance – Microsoft Defender Firewall Notifications (Domain Profile)

## 🔍 Description

This document outlines a risk acceptance decision regarding the disabling of Microsoft Defender Firewall notifications when programs are blocked on domain-joined machines.

In certain managed enterprise environments, such notifications are unnecessary and can confuse non-technical users. Instead, centralized monitoring is used for all firewall events via Microsoft Defender for Endpoint and SIEM integration.

---

## 🎛️ Technical Implementation

### Group Policy Configuration (GPO)

- **Policy Name**: Turn off notifications when the firewall blocks a new app  
- **Path**:
Computer Configuration →
Administrative Templates →
Windows Defender Firewall →
Domain Profile →
Turn off notifications when the firewall blocks a new app
- **Setting**: `Enabled` ✅

> This setting disables all toast notifications when Microsoft Defender Firewall blocks a new application on domain profile networks.

---

## 🧾 Risk Acceptance Details

| Field               | Value                                                                 |
|---------------------|-----------------------------------------------------------------------|
| **Recommendation**  | Enable firewall notifications for blocked apps (Defender for Endpoint) |
| **Risk Decision**   | Exception (Risk Accepted)                                             |
| **Justification**   | Notifications are disabled on domain-joined machines operating in kiosk or locked-down mode. Centralized logging is enabled through Defender for Endpoint and Microsoft Sentinel. There is no user action required locally. |
| **Risk Owner**      | Ali Choukatli (IT Security Lead)                                      |
| **Approval Date**   | 2025-06-10                                                            |
| **Review Date**     | 2025-09-10 (90 days)                                                  |
| **Mitigation**      | Centralized monitoring via MDE and SIEM; firewall remains enabled and strictly configured. |
| **Implementation Method** | Group Policy Object (GPO) applied via Active Directory OU targeting specific device groups. |

---

## 🛡️ Monitoring & Follow-Up

- This exception has been documented in the organization's **Risk Register**.
- A review will be conducted before the expiration date.
- Firewall events are continuously monitored using:
- Microsoft Defender for Endpoint
- Microsoft Sentinel
- Windows Event Forwarding

---

## 📸 Defender for Endpoint – Exception Request

> Simulated example (no actual screenshot shown here):

Security Recommendation: "Enable notifications when firewall blocks a new app"
Requested action: "Exception"
Justification: "Intentionally disabled in kiosk environments with SIEM-based monitoring"
Duration: 90 days
Approver: IT Security Lead
