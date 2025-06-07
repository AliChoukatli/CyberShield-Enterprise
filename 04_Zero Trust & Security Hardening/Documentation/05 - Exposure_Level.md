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

##  Priority Remediations – Security Recommendations

1. 🔒 Turn on PUA protection in block mode.
2. 🔒 Windows 11 Update.
3. 🔒 Update Microsoft Edge Chromium-based to version 137.0.3296.62
4. 🔒 Block Executable content from email client and webmail.
5. 🔒 Block Credential Stealing (lssas.exe).
6. 🔒 Enable Network Protection.
7. 🔒 Block untrusted and unsigned processes that run from USB (Protection contre infections via USB).
8. 🔒 Set controlled folder access to enabled or audit mode.

---

### ✅ Turn on PUA Protection in Block Mode

**Description:**  
Blocks Potentially Unwanted Applications (PUAs) that may contain adware, mining tools, bundlers, or software that introduces security risks.

**Justification:**  
Helps prevent low-trust applications from compromising system integrity.

---

### ✅ Update Microsoft Windows 11 (OS and Built-in Applications)

**Description:**  
Ensure all Windows 11 system components and built-in apps are up-to-date.

**Justification:**  
Regular OS updates patch critical vulnerabilities and mitigate exploitation risks.


| Field                | Value                                     |
|----------------------|-------------------------------------------|                       
| **Target**           |  LTP-HLP01                                |
| **Due Date**         | June 6, 2025                              |
| **Priority**         | High                                      |      

![Req_win11_update](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/04_Zero%20Trust%20%26%20Security%20Hardening/Screenshots/Req_Win11update.png)

---

---

### ✅ Update Microsoft Edge (Chromium-based) to Version 137.0.3296.62

**Description:**  
Update the Microsoft Edge browser to the latest stable version.

**Justification:**  
Web browsers are prime targets for exploits; updates fix known vulnerabilities and improve resilience.

---

### ✅ Block Credential Stealing from LSASS (Local Security Authority Subsystem)

**Description:**  
Enable ASR rule to block credential dumping attempts on `lsass.exe`.

**Justification:**  
Protects against techniques used in credential theft attacks (e.g., Mimikatz) that enable lateral movement or privilege escalation.

| Field                | Value                                     |
|----------------------|-------------------------------------------|
| **Target**           | LTP-HLP01                                 |
| **Due Date**         | June 6, 2025                              |
| **Priority**         | High                                      |      

---

### ✅ Enable Network Protection

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

### ✅ Set Controlled Folder Access to Enabled (or Audit Mode)

**Description:**  
Enable ransomware protection by locking critical folders against unauthorized access.

**Justification:**  
Defends against ransomware attempting to encrypt sensitive user files.

---

### ✅ Block Executable Content from Email Client and Webmail

**Description:**  
Prevent direct execution of embedded content or malicious attachments received via email.

**Justification:**  
Email is a common initial attack vector. This control reduces phishing and malware payload delivery.


| Field                | Value                                     |
|----------------------|-------------------------------------------|
| **Target**           | LTP-HLP01                                 |
| **Due Date**         | June 6, 2025                              |
| **Priority**         | High                                      |      

---

### ✅ Block Untrusted and Unsigned Processes from USB Devices

**Description:**  
Block unknown or unsigned executables that attempt to run from USB storage.

**Justification:**  
Mitigates risks related to USB-borne malware and unauthorized software execution.

---

> 🛡️ Apply these configurations via Intune, GPO, or PowerShell to harden your environment against common threats. Document remediation steps and monitor Defender recommendations regularly.


---


## 🟡 Accepted Risks

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
