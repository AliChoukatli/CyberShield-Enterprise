# SecureIT-for-SMB
# 💼 SecureIT for SMB – Support IT & Cybersecurity Project

## 🎯 Project Overview
This project demonstrates a full implementation of IT support and cybersecurity for a fictional small business (25 employees), applying modern security practices based on the **Zero Trust model**, **ISO/IEC 27001**, and **NIST Cybersecurity Framework (CSF)**.

The environment uses:
- **Microsoft 365, Azure AD (Entra ID), Intune, and Sentinel**
- **BitLocker, MFA, Conditional Access**
- **Defender for Endpoint**
- **Automated scripting with PowerShell**

---

## 🧱 Infrastructure Overview
- Choix du tenant Microsoft 365 (E5 Trial possible)

- Paramétrage du domaine personnalisé (facultatif)

- Vue d’ensemble de l’architecture (schéma réseau, flux)

### 👥 Identity & Access Management (IAM)
- Azure AD users and groups
- Conditional Access based on device compliance & location
- MFA enforced for all accounts
- Role-Based Access Control (RBAC)

### 💻 Endpoint Management
- Windows 11 deployment with Windows Autopilot
- Configuration via Intune: apps, security baselines, BitLocker
- Update & patch management
- Defender for Endpoint active monitoring

### 🔐 Security Operations (SOC Lite)
- Integration with Microsoft Sentinel
- Collection of sign-in logs and security alerts
- Alert triage with KQL queries
- Basic playbook to auto-respond to high severity alerts

---

## 📜 Compliance Mapping

| Control | Implementation |
|--------|----------------|
| ISO/IEC 27001 A.9.2 – User Access | Azure AD + Conditional Access |
| ISO/IEC 27001 A.12.4 – Logging | Microsoft Sentinel, Defender |
| NIST CSF – PR.AC | Identity and access configured |
| NIST CSF – DE.CM | Continuous monitoring via Defender |
| NIST CSF – RS.RP | Alert response playbooks in Sentinel |

📄 [Full compliance mapping here](./Cybersecurity/Compliance_Mapping_ISO_NIST.md)

---

## 🔥 Zero Trust Implementation

| Principle | Implementation |
|----------|----------------|
| Verify explicitly | MFA + Device compliance + Sign-in risk |
| Least privilege | RBAC + Limited access |
| Assume breach | Endpoint isolation, logging, Defender for Endpoint alerts |

📄 [Zero Trust model documentation](./Cybersecurity/ZeroTrust_Model.md)

---

## ⚙️ PowerShell Scripts

In the `/Support_IT/PowerShell_Scripts` folder:
- `DeployOffice365.ps1`: auto-installs Office
- `Reset-UserPassword.ps1`: helpdesk password reset tool
- `Get-SecurityStatus.ps1`: exports security compliance status from Intune

---

## 📊 Sentinel Triage & Playbook

In `/Cybersecurity/Sentinel_Alerts_Triage`:
- Sample logs
- KQL query to filter high-severity alerts:
```kql
SecurityAlert 
| where Severity == "High" 
| where TimeGenerated > ago(7d)
```

## 🧪 Forensics & Incident Response
Use-case: Simulated phishing attack leading to endpoint compromise

🔍 Steps:

1 - Alert triggered in Microsoft Defender for Endpoint (phishing email opened).

2 - Sentinel receives log and generates an alert.

3 - Alert is triaged manually via KQL.

4 - Evidence collected using:

   - Windows Event Viewer (event ID 4104, 4624, 4688)

   - Autopsy (USB artifacts, browser history)

   - X-Ways or FTK Imager for disk imaging and analysis

5 - Affected user account disabled.

6 - Root cause documented in a forensic report.

## 📁 See details in /Incident_Response/Phishing_Alert_Playbook.pdf

## 📸 Screenshots available in /Screenshots/Forensics_Analysis/

## 📚 Tools Used 
![image](https://github.com/user-attachments/assets/6ea33308-aac0-439b-9b78-638dec1fc0e2)

### 👤 Author
   Ali Choukatli  
📧 alichoukatli@gmail.com  
🔗 LinkedIn : linkedin.com/in/ali-choukatli 


