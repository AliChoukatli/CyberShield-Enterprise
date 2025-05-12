# 🛡️ CyberShield Entreprise - Small Business Simulation (25 Users)

This project simulates the implementation of a secure, cloud-based IT environment for a fictional small business with 25 employees. It follows modern best practices including the Zero Trust model, ISO/IEC 27001, and the NIST Cybersecurity Framework (CSF), using Microsoft 365, Azure AD (Entra ID), Intune, Microsoft Defender, and Sentinel.

> **Company Context:**  
> *CyberShield Entreprise is a fictional SMB in the financial services sector. Due to handling sensitive customer data, security and compliance are top priorities.*

---

## 📑 Index

1. [📐 Architecture & Objectives](#-architecture--objectives)
2. [📁 Project Structure](#-project-structure)
3. [🧩 Tools & Services](#-tools--services)
4. [🚀 How to Use This Project (Phases)](#-how-to-use-this-project-phases)
5. [🔐 Zero Trust Implementation](#-zero-trust-implementation-integrated)
6. [⚙️ PowerShell Tools (Support IT)](#️-powershell-tools-support-it)
7. [🧪 Incident Response Simulation](#-incident-response-simulation)
8. [📊 Security Posture: Before & After](#-security-posture-before--after)
9. [✅ Compliance Mapping (Summary)](#-compliance-mapping-summary)
10. [📄 License](#️-license)

---

## 📐 Architecture & Objectives

<p align="center">
  <img src="https://github.com/AliChoukatli/SecureIT-for-SMB/blob/main/Architecture/Architecture.png" alt="Architecture" width="600"/>
</p>

**Objectives:**

- Deploy a modern cloud IT infrastructure
- Apply cybersecurity best practices (Zero Trust, ISO/NIST)
- Manage identities, endpoints, and security operations
- Simulate phishing and incident response workflows
- Automate common IT support tasks using PowerShell

---

## 📁 Project Structure

```bash
CyberShield-Enterprise/
│
├── 01_Installation & Domain Join/
│   ├── Documentation/
│   │   ├── Domain_Controller_Configuration.md
│   │   ├── Workstation_Configuration.md
│   │   └── Domain_Join_Steps.md
│   ├── Scripts/
│   │   ├── Server_Join_Script.ps1
│   │   └── Workstation_Join_Script.ps1
│   └── Screenshots/
│       ├── whoami-hlp01.png
│       └── whoami-emp01.png
│
├── 02_Active Directory Integration/
│   ├── Documentation/
│   │   ├── OU_Structure.md
│   │   ├── User_Management.md
│   │   └── Access_Control.md
│   ├── Scripts/
│   │   ├── Create_OU_Script.ps1
│   │   └── User_Group_Management_Script.ps1
│   └── Screenshots/
│       ├── OU_Structure_Example.png
│       └── Group_Permissions_Example.png
│
├── 03_AzureAD Sync & Endpoint Security/
│   ├── Documentation/
│   │   ├── Hybrid_Join_Guide.md
│   │   ├── Intune_Configuration.md
│   │   └── Security_Policies.md
│   ├── Scripts/
│   │   ├── AzureAD_Join_Script.ps1
│   │   └── Intune_Enrollment_Script.ps1
│   └── Screenshots/
│       ├── AzureAD_Connect_Screenshot.png
│       └── Device_Management_Example.png
│
├── 04_Security Hardening/
│   ├── Documentation/
│   │   ├── Administrator_Account_Hardening.md
│   │   ├── MFA_Enforcement.md
│   │   └── Conditional_Access_Configuration.md
│   ├── Scripts/
│   │   ├── Rename_Administrator_Script.ps1
│   │   └── MFA_Policy_Script.ps1
│   └── Screenshots/
│       ├── MFA_Enforcement_Screenshot.png
│       └── Conditional_Access_Rules_Screenshot.png
│
├── 05_Backup & Recovery Preparation/
│   ├── Documentation/
│   │   ├── Backup_Strategy.md
│   │   ├── Recovery_Plan.md
│   │   └── Test_Recovery_Procedure.md
│   ├── Scripts/
│   │   ├── Backup_Script.ps1
│   │   └── Restore_Script.ps1
│   └── Screenshots/
│       ├── Backup_Procedure_Screenshot.png
│       └── Recovery_Test_Screenshot.png
│
├── 06_Sentinel & Defender Integration/
│   ├── Documentation/
│   │   ├── Defender_Endpoint_Integration.md
│   │   ├── Sentinel_Configuration.md
│   │   └── Alert_Rules_Setup.md
│   ├── Scripts/
│   │   ├── Defender_Endpoint_Config.ps1
│   │   └── Sentinel_Log_Integration.ps1
│   └── Screenshots/
│       ├── Defender_Endpoint_Screenshot.png
│       └── Sentinel_Alert_Rules_Screenshot.png
│
├── 07_Phishing Simulation & User Awareness/
│   ├── Documentation/
│   │   ├── Phishing_Simulation_Guide.md
│   │   ├── Awareness_Training_Suggestions.md
│   │   └── User_Vulnerability_Report.md
│   ├── Screenshots/
│       ├── Phishing_Simulation_Results.png
│       └── Awareness_Training_Example.png
│
├── 08_Forensics Post-Attack/
│   ├── Documentation/
│   │   ├── Incident_Response_Plan.md
│   │   ├── Forensic_Analysis_Guide.md
│   │   └── Attack_Timeline.md
│   ├── Scripts/
│   │   ├── Log_Collection_Script.ps1
│   │   └── IoC_Search_Script.ps1
│   └── Screenshots/
│       ├── Forensics_Screenshot.png
│       └── Attack_Timeline_Screenshot.png
│
├── 09_Post-Incident Recovery & Integrity Check/
│   ├── Documentation/
│   │   ├── Recovery_Guidelines.md
│   │   ├── Integrity_Check_Procedure.md
│   │   └── Service_Functionality_Test.md
│   ├── Scripts/
│   │   ├── Integrity_Check_Script.ps1
│   │   └── Service_Test_Script.ps1
│   └── Screenshots/
│       ├── Integrity_Check_Results.png
│       └── Service_Functionality_Screenshot.png
│
├── 10_Compliance Mapping (ISO/NIST)/
│   ├── Documentation/
│   │   ├── Compliance_Mapping_Guide.md
│   │   ├── ISO_27001_Annex_A.md
│   │   └── NIST_CSF_Controls.md
│   └── Screenshots/
│       ├── Compliance_Report_Example.png
│       └── Gap_Analysis_Example.png
│
└── README.md
```
---

## 🔐 **Zero Trust Implementation (Integrated)**

| Principle         | Implementation                                     |
|-------------------|----------------------------------------------------|
| Verify explicitly | MFA, device compliance, and sign-in risk policies |
| Least privilege   | RBAC with limited access permissions              |
| Assume breach     | Endpoint monitoring, isolation, security alerts   |


## ⚙️ **PowerShell Tools (Support IT)**

| Script Name              | Purpose                                        |
|--------------------------|------------------------------------------------|
| DeployOffice365.ps1      | Auto-install Office for new endpoints          |
| Reset-UserPassword.ps1   | Helpdesk password reset tool                   |
| Get-SecurityStatus.ps1   | Export security compliance status from Intune  |


## 🧪 **Incident Response Simulation**

**Use Case:** A user opens a phishing email → endpoint is compromised → alert is triggered

**Workflow:**

1. Defender detects a malicious file from phishing
2. Sentinel logs the alert and triggers high severity
3. Triage done using KQL and log review
4. Forensic evidence collected:
   - Windows Event Viewer (IDs: 4104, 4624, 4688)
   - Browser/USB artifacts (noted only)
5. User account disabled and isolated
6. Incident_Response/Phishing_Simulation_Steps [Phishing Simulation Steps](Incident_Response/Phishing_Simulation_Steps.md).

## **Security Posture: Before & After**

| **Aspect**                  | **Before Hardening**                     | **After Hardening**                              |
|----------------------------|------------------------------------------|--------------------------------------------------|
| **MFA**                    | Not enabled                              | Enforced via Conditional Access                  |
| **Device Compliance**      | Not evaluated                            | Enforced via Intune Compliance Policies          |
| **BitLocker**              | Disabled                                 | Enabled and enforced                             |
| **Admin Account Usage**    | Used for login                           | Limited, with user-level privileges              |
| **Windows Defender Settings** | Default settings                     | Custom security baselines applied                |
| **Audit Logs**             | Not collected                            | Centralized via Sentinel                         |



## 📄 **Compliance Mapping (Summary)**

| Framework         | Control ID         | Implementation Example                      |
|-------------------|--------------------|---------------------------------------------|
| ISO/IEC 27001     | A.9.2 – User Access| Azure AD, Conditional Access                |
| ISO/IEC 27001     | A.12.4 – Logging   | Microsoft Defender, Sentinel Logs           |
| NIST CSF          | PR.AC – Access Ctrl| Identity and Role-Based Access Setup        |
| NIST CSF          | DE.CM – Monitoring | Defender for Endpoint Continuous Monitoring |
| NIST CSF          | RS.RP – Response   | Sentinel Alert Triage and Response          |

🔗 **Full version available in** [Mapping_ISO_NIST.xlsx](./Mapping_ISO_NIST.xlsx)



## 🗂️ License

MIT License
