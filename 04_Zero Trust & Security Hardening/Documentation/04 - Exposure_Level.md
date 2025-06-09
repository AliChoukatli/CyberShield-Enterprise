# 🛡️ Exposure Level  

This document outlines actions taken to address a **High Exposure Level** reported in the Microsoft Defender for Endpoint (MDE) Threat & Vulnerability Management (TVM) dashboard.

Two different types of responses were demonstrated:

- ✅ 1. A remediation request 
- 🟡 2. A justified risk acceptance 

---

## 📊 Initial Exposure Summary

- **Exposure Level**: 🔴 High
- **Device**: `LTP-HLP01`

![LTP-HLP01_Score](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/04_Zero%20Trust%20%26%20Security%20Hardening/Screenshots/LTP-HLP01_Exposure_Level.png)

##  Security Recommendations - Priority Remediations

| Control                                                      | Risk Level | Impact   | Justification                                                                                    | Decision   |
|--------------------------------------------------------------|------------|----------|--------------------------------------------------------------------------------------------------|-------------|
| 🔒 Update Microsoft Windows 11 (OS and apps)                | High        | High    | Critical security patches fix vulnerabilities and protect system integrity.                       | Remediate  |
| 🔒 Turn on PUA protection in block mode                     | High        | High    | Blocks potentially unwanted applications that may compromise security.                            | Remediate  |
| 🔒 Set controlled folder access to enabled/audit mode       | High        | High     | Protects against ransomware by restricting unauthorized file changes.                            | Remediate  |
| 🔒 Block executable content from email client and webmail   | Medium      | Medium   | Prevents execution of malicious content delivered via email.                                     | Remediate  |
| 🔒 Block credential stealing from LSASS                     | High        | High    | Prevents theft of credentials (hashes) used in lateral movement and privilege escalation attacks. | Remediate  |
| 🔒 Enable Network Protection                                | Medium      | Medium  | Blocks network access to malicious domains and reduces attack surface.                            | Remediate  |
| 🔒 Block untrusted and unsigned processes from USB          | Medium      | Medium   | Protects from malware spreading via USB removable devices.                                       | Remediate  |
| 🔒 Update Microsoft Edge Chromium-based                     | Medium      | High    | Browser updates patch exploitable vulnerabilities frequently targeted by attackers.               | Remediate  |

![LTP-HLP01_Recommendations](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/04_Zero%20Trust%20%26%20Security%20Hardening/Screenshots/LTP-HLP01_Recommendations.png)

---

## 🧰 Update Microsoft Windows 11 (OS and Built-in Applications)

![Req_win11_update](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/04_Zero%20Trust%20%26%20Security%20Hardening/Screenshots/Req_Win11update.png)

🔍 **Description:**  
Ensure all Windows 11 system components and built-in apps are up-to-date.

🔍 **Justification:**  
Regular OS updates patch critical vulnerabilities and mitigate exploitation risks.

✅ **Remediation** : Update Win 11



---

## 🧰 Turn on PUA Protection in Block Mode

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

## 🧰 Set Controlled Folder Access to Enabled (or Audit Mode)


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

## 🧰 Block Executable Content from Email Client and Webmail

![Exe_Req](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/04_Zero%20Trust%20%26%20Security%20Hardening/Screenshots/Exe_Req.png)

🔍 **Description:**  
Prevent direct execution of embedded content or malicious attachments received via email.

🔍 **Justification:**  
Email is a common initial attack vector. This control reduces phishing and malware payload delivery.

✅ **Remediation**

- **Documentation:** [Microsoft Learn](https://learn.microsoft.com/en-us/defender-endpoint/attack-surface-reduction-rules-reference?view=o365-worldwide#block-executable-content-from-email-client-and-webmail)

- To enable this rule in **Block Mode**, add the following registry key and value :

```reg
HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Windows Defender Exploit Guard\ASR\Rules
```
⚠️ If the path does not exist, you must **manually create each subkey** in this order: `Windows Defender Exploit Guard > ASR > Rules`

- Add the following **String Value** inside the `Rules` key:
- 
| Name (String)                                      | Type           | Value  |
|----------------------------------------------------|----------------|--------|
| `BE9BA2D9-53EA-4CDC-84E5-9B1EEEE46550`            | `String Value` | `"1"`  |


![Exe_Fix](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/04_Zero%20Trust%20%26%20Security%20Hardening/Screenshots/Exe_Fix.png)

---


---

## 🧰 Block Credential Stealing from LSASS (Local Security Authority Subsystem)

![lsaas_Req](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/04_Zero%20Trust%20%26%20Security%20Hardening/Screenshots/lsass_Req.png)

- 🔍 **Description** : This prevent credential theft by blocking unauthorized access to the LSASS.
- 🔍 **Purpose:** Prevent malware from dumping credentials from `lsass.exe` using tools like Mimikatz.
- 🔍 **Applicable when:** You can't enable **LSA Protection** or **Credential Guard** on all devices due to compatibility issues.
- 🔍 **Default Behavior:** Enabled in **Block Mode**.
- ⚠️ **Warning:** This rule does **not** support **Warn Mode**.
- ⚠️ If **LSA protection** is already enabled, this rule is **not applicable** and does not provide extra protection.

---

✅ **Remediation

To enable this rule in **Block Mode**, add the following registry key and value: 

```reg
HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Windows Defender Exploit Guard\ASR\Rules
```
- ⚠️ If the path doesn't exist, manually create each subkey:
Windows Defender Exploit Guard > ASR > Rules

Add the following **String Value** inside the `Rules` key:

| Name (String)                                      | Type           | Value  |
|----------------------------------------------------|----------------|--------|
| `9E6C4E1F-7D60-472F-BA1A-A39EF669E4B2`             | `String Value` | `"1"`  |

- `"1"` = Block Mode ✅  

![lsaas_fix](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/04_Zero%20Trust%20%26%20Security%20Hardening/Screenshots/lsaas_Fix.png)

---

## 🧰 Enable Network Protection

**Description:**  
Enforce Microsoft Defender SmartScreen to block access to dangerous domains and phishing infrastructure.

**Justification:**  
Prevents users from accessing known malicious websites, reducing exposure to drive-by attacks or social engineering.


| Field                | Value                                     |
|----------------------|-------------------------------------------|
| **Target**           | LTP-HLP01                                 |
| **Due Date**         | June 6, 2025                              |
| **Priority**         | High                                      |  

---

## 🧰 Block Untrusted and Unsigned Processes from USB Devices

🔍 **Description:**  
Block unknown or unsigned executables that attempt to run from USB storage.

🔍 **Justification:**  
Mitigates risks related to USB-borne malware and unauthorized software execution.

---

## 🧰 Update Microsoft Edge (Chromium-based) to Version 137.0.3296.62

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
