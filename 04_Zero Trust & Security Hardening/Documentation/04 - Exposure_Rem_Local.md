# Security Exposure Analysis, Remediation & Risk Management

## 🔴 Index

This document outlines actions taken to address a **High Exposure Level** reported in the Microsoft Defender for Endpoint (MDE) Threat & Vulnerability Management (TVM) dashboard.

1. 🔒 [Initial Exposure Level Summary](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/04_Zero%20Trust%20&%20Security%20Hardening/Documentation/04%20-%20Exposure_Rem_Local.md#-initial-exposure-summary)
2. 🔒 [Security Recommendations ](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/04_Zero%20Trust%20&%20Security%20Hardening/Documentation/04%20-%20Exposure_Rem_Local.md#-security-recommendations)
1. 🔒 [Update Microsoft Windows 11 (OS and Built-in Applications)](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/04_Zero%20Trust%20&%20Security%20Hardening/Documentation/04%20-%20Exposure_Rem_Local.md#-1-update-microsoft-windows-11-os-and-built-in-applications)
2. 🔒 [Turn on PUA Protection in Block Mode](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/04_Zero%20Trust%20&%20Security%20Hardening/Documentation/04%20-%20Exposure_Rem_Local.md#-2-turn-on-pua-protection-in-block-mode)
3. 🔒 [Set Controlled Folder Access to Enabled (or Audit Mode)](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/04_Zero%20Trust%20&%20Security%20Hardening/Documentation/04%20-%20Exposure_Rem_Local.md#-3-set-controlled-folder-access-to-enabled-or-audit-mode)
4. 🔒 [Block Credential Stealing from LSASS (Local Security Authority Subsystem)](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/04_Zero%20Trust%20&%20Security%20Hardening/Documentation/04%20-%20Exposure_Rem_Local.md#5--block-credential-stealing-from-lsass-local-security-authority-subsystem)
5. 🔒 [Enable Network Protection](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/04_Zero%20Trust%20&%20Security%20Hardening/Documentation/04%20-%20Exposure_Rem_Local.md#6--enable-network-protection)
6. 🔒 [Block Executable Content from Email Client and Webmail - Intune Method](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/04_Zero%20Trust%20&%20Security%20Hardening/Documentation/04%20-%20Exposure_Rem_Local.md#-4-block-executable-content-from-email-client-and-webmail)
7. 🔒 [Block Untrusted and Unsigned Processes from USB Devices - GPO Method](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/04_Zero%20Trust%20&%20Security%20Hardening/Documentation/04%20-%20Exposure_Rem_Local.md#7--block-untrusted-and-unsigned-processes-from-usb-devices---gpo-method)

---

## 🔴 Initial Exposure Level Summary

- **Exposure Level**: High
- **Device**: `LTP-HLP01`

![LTP-HLP01_Score](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/04_Zero%20Trust%20%26%20Security%20Hardening/Screenshots/LTP-HLP01_Exposure_Level.png)

##  🔴 Security Recommendations 
- The following are prioritized security controls and remediations to address high-risk exposures detected by Microsoft Defender for Endpoint. It guides on how to mitigate vulnerabilities and enhance endpoint protection.

![LTP-HLP01_Recommendations](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/04_Zero%20Trust%20%26%20Security%20Hardening/Screenshots/LTP-HLP01_Recommendations.png)

| Control                                                      | Risk Level | Impact   | Justification                                                                                    |
|--------------------------------------------------------------|------------|----------|--------------------------------------------------------------------------------------------------|
| 🔒 Update Microsoft Windows 11 (OS and apps)                | High        | High    | Critical security patches fix vulnerabilities and protect system integrity.                       |
| 🔒 Turn on PUA protection in block mode                     | High        | High    | Blocks potentially unwanted applications that may compromise security.                            |
| 🔒 Set controlled folder access to enabled/audit mode       | High        | High     | Protects against ransomware by restricting unauthorized file changes.                            |
| 🔒 Block executable content from email client and webmail   | Medium      | Medium   | Prevents execution of malicious content delivered via email.                                     |
| 🔒 Block credential stealing from LSASS                     | High        | High    | Prevents theft of credentials (hashes) used in lateral movement and privilege escalation attacks. |
| 🔒 Enable Network Protection                                | Medium      | Medium  | Blocks network access to malicious domains and reduces attack surface.                            |
| 🔒 Block untrusted and unsigned processes from USB          | Medium      | Medium   | Protects from malware spreading via USB removable devices.                                       |
| 🔒 Update Microsoft Edge Chromium-based                     | Medium      | High    | Browser updates patch exploitable vulnerabilities frequently targeted by attackers.               |


Two different types of responses were demonstrated:

- ✅ Applied Remediation
- 🟡 Risk acceptance 
---

## ✅ Applied Remediation

### 🧰 1. Update Microsoft Windows 11 (OS and Built-in Applications)

![Req_win11_update](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/04_Zero%20Trust%20%26%20Security%20Hardening/Screenshots/Req_Win11update.png)

Description:
Ensure all Windows 11 system components and built-in apps are up-to-date.

Justification:
Regular OS updates patch critical vulnerabilities and mitigate exploitation risks.

Remediation: Update Win 11

---

### 🧰 2. Turn on PUA Protection in Block Mode

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

3## 🧰 3. Set Controlled Folder Access to Enabled (or Audit Mode)


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

## 4. 🧰 Block Credential Stealing from LSASS (Local Security Authority Subsystem)

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
## 5. 🧰 Enable Network Protection

![NP_Req](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/04_Zero%20Trust%20%26%20Security%20Hardening/Screenshots/NP_Req.png)

### Prerequisites

Before enabling Network Protection, ensure the following are active:

- Microsoft Defender Antivirus running  
- Real-time protection enabled  
- Cloud-delivered protection enabled
  
![Cloud_Protect_Enable](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/04_Zero%20Trust%20%26%20Security%20Hardening/Screenshots/Cloud_Protect_enable.png)

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


## 🧰 6. Block Executable Content from Email Client and Webmail - Intune Method

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
   - Platform: **Windows 10 and later**
   - Profile: **Attack surface reduction rules**
4. Configure the following:
   - Rule name: `Block executable content from email client and webmail`
   - GUID: `BE9BA2D9-53EA-4CDC-84E5-9B1EEEE46550`
   - Action: `Block`
5. Assign the policy to your **targeted devices or groups**
6. Review + Create

✅ Once deployed, the rule will be enforced on all assigned devices.

![Exe_Fix](

---

## 7. 🧰 Block Untrusted and Unsigned Processes from USB Devices - GPO Method](

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
   - **Value name:** `3B576869-A4EC-4529-8536-B80A7769E899`  
   - **Value type:** `REG_SZ`  
   - **Value data:** `1`

6. Click **OK** to save.

7. Close the Group Policy Editor and ensure the GPO is linked correctly.

8. On target machines, run `gpupdate /force` or wait for policy refresh.

---

## Additional Notes

- If the registry path does not exist, the system will create it during policy application.
- `"1"` enables the rule in **Block mode**.
- To audit only without blocking, use `"2"` instead (Audit mode).
- This ASR rule requires Microsoft Defender Antivirus and Exploit Guard enabled.

---

This configuration helps to prevent malware execution from USB devices by blocking untrusted or unsigned processes.










## 8. 🧰 Update Microsoft Edge (Chromium-based) to Version 137.0.3296.62

🔍 **Description:**  
Update the Microsoft Edge browser to the latest stable version.

🔍 **Justification:**  
Web browsers are prime targets for exploits; updates fix known vulnerabilities and improve resilience.

![Edge+Version](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/04_Zero%20Trust%20%26%20Security%20Hardening/Screenshots/edge_version.png)

---

> 🛡️ Apply these configurations via Intune, GPO, or PowerShell to harden your environment against common threats. Document remediation steps and monitor Defender recommendations regularly.


---


## 🟡 Accepted Risks

| Control                                         | Risk Level | Impact               | Justification                                                                                              | Decision  |
|-------------------------------------------------|------------|----------------------|------------------------------------------------------------------------------------------------------------|-----------|
| Disable 'Autoplay' for all drives               | Low        | Low                  | Modern Windows restrict autoplay by default; full disable may impact user experience with trusted devices. | Accepted  |
| Interactive logon: Machine inactivity limit     | Low        | Low to Medium        | In physically secured environments, this control can be redundant with other auto-lock measures.           | Accepted  |
| Disable Defender Firewall notifications         | Low        | Low                  | Notifications off reduces user noise; monitoring remains via logs and centralized tools.                   | Accepted  |


## 1. Disable 'Autoplay' for all drives

- **Risk Level:** Low  
- **Impact:** Low  
- **Justification:**  
  Les versions modernes de Windows restreignent déjà l'exécution automatique (autoplay) pour la plupart des périphériques.  
  Désactiver complètement l'autoplay peut nuire à l'expérience utilisateur notamment avec des périphériques USB légitimes (clés USB, disques externes).  
- **Decision:** Risk Accepted

---

## 2. Interactive logon: Machine inactivity limit (1-900 seconds)

- **Risk Level:** Low  
- **Impact:** Low to Medium  
- **Justification:**  
  Dans les environnements d'entreprise sécurisés physiquement (badge, contrôle d'accès), cette limitation d'inactivité peut être redondante avec d'autres contrôles comme la mise en veille automatique ou verrouillage d'écran.  
- **Decision:** Risk Accepted (avec contrôles compensatoires)

---

## 3. Disable Microsoft Defender Firewall notifications when programs are blocked

- **Risk Level:** Low  
- **Impact:** Low  
- **Justification:**  
  La désactivation des notifications ne modifie pas le blocage des programmes malveillants mais peut réduire le bruit perçu par l'utilisateur.  
  La visibilité reste possible via les journaux d'événements et la surveillance centralisée.  
- **Decision:** Risk Accepted

---

*Note : Ces décisions d'acceptation de risque doivent être réévaluées régulièrement en fonction de l'évolution du contexte de sécurité et des contrôles en place.*
