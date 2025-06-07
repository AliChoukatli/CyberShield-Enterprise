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
- **Detected Issues**:
  1. Outdated Windows 11 build
  2. Network client: Digitally sign communications (always) – Not configured
  3. BitLocker not enabled
  4. RDP access enabled
  5. Defender AV not fully configured
 
![LTP-HLP01_Recommendation](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/04_Zero%20Trust%20%26%20Security%20Hardening/Screenshots/LTP-HLP01_Recommendations.png)

---

## ✅ 1. A remediation request 

### 🛠️ 1. Windows 11 Update

**Notes**

| Field                | Value                                     |
|----------------------|-------------------------------------------|                       |
| **Target**           |  LTP-HLP01                                |
| **Due Date**         | June 6, 2025                              |
| **Priority**         | High                                      |      

![Req_win11_update](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/04_Zero%20Trust%20%26%20Security%20Hardening/Screenshots/Req_Win11update.png)

---

### 🛠️ 2. Block Executable content from email client and webmail

**Notes**

| Field                | Value                                     |
|----------------------|-------------------------------------------|
| **Target**           | LTP-HLP01                                 |
| **Due Date**         | June 6, 2025                              |
| **Priority**         | High                                      |      


![Blcok_Exe_Email](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/04_Zero%20Trust%20%26%20Security%20Hardening/Screenshots/Block_exec_Email.png)

---

### 🛠️ 3. Enable Network Protection

**Notes:**

| Field                | Value                                     |
|----------------------|-------------------------------------------|
| **Target**           | LTP-HLP01                                 |
| **Due Date**         | June 6, 2025                              |
| **Priority**         | High                                      |      

![Req_NP](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/04_Zero%20Trust%20%26%20Security%20Hardening/Screenshots/Req_NP.png)


---

### 🛠️ 4. Block Credential Stealing (lssas.exe)

**Notes:**

| Field                | Value                                     |
|----------------------|-------------------------------------------|
| **Target**           | LTP-HLP01                                 |
| **Due Date**         | June 6, 2025                              |
| **Priority**         | High                                      |      

![Req_Block_Cred](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/04_Zero%20Trust%20%26%20Security%20Hardening/Screenshots/Req_Block_Cred.png)

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

