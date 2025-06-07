# 🛡️ Exposure Level Actions 

This document outlines actions taken to address a **High Exposure Level** reported in the Microsoft Defender for Endpoint (MDE) Threat & Vulnerability Management (TVM) dashboard.

Two different types of responses were demonstrated:

- ✅ 1. A remediation request 
- 🟡 2. A justified risk acceptance 

---

## 📊 Initial Exposure Summary

![LTP-HLP01_Score](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/04_Zero%20Trust%20%26%20Security%20Hardening/Screenshots/LTP-HLP01_Exposure_Level.png)

- **Exposure Level**: 🔴 High
- **Device**: `LTP-HLP01`
- **Recommendations**:
  1. Turn on PUA protection in block mode
  2. Windows 11 Update
  3. Update Microsoft Edge Chromium-based to version 137.0.3296.62
  4. Block Executable content from email client and webmail
  5. Block Credential Stealing (lssas.exe)
  6. Enable Network Protection
  7. Block untrusted and unsigned processes that run from USB (Protection contre infections via USB)
  8. Set controlled folder access to enabled or audit mode (

- Accepted:
  9. Digitally Sign Communications Policy
  
 
![LTP-HLP01_Recommendation](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/04_Zero%20Trust%20%26%20Security%20Hardening/Screenshots/LTP-HLP01_Recommendations.png)



# 🔒 Priority Remediations – Security Recommendations

Below is a list of high-priority remediation actions to apply immediately in order to reduce the organization's attack surface and strengthen endpoint security posture.

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


## 🟡 2. Risk Accepted – Digitally Sign Communications Policy

Another vulnerability was handled by accepting the risk, rather than applying the configuration immediately.

| Policy | Microsoft network client: Digitally sign communications (always) |
|--------|------------------------------------------------------------------|
| **Action** | Risk accepted |
| **Justification** | In a lab setup, this policy is not enforced to allow compatibility testing with legacy services. In a production environment, this setting would typically be enabled via Group Policy or Intune baseline. |
| **Status** | Documented and marked as accepted risk in Defender portal |

This demonstrates the ability to assess risk pragmatically and document security decisions for audit purposes.

---

## ✅ Summary

| Action Type | Item | Result |
|-------------|------|--------|
| Remediation | Windows 11 Update | ❌ Failed (Lab limitation) |
| Risk Accepted | Digitally sign communications | ✅ Documented justification |

In a real-world enterprise, both items would be tracked and managed as part of a broader vulnerability management program.

