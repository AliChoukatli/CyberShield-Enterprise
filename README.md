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
├── 00_Architecture/                             # Contains architecture-related diagrams and documentation
│   ├── Diagrams/                               # Network architecture diagrams
│   ├── Before_After/                           # Before and after architecture comparisons
│   └── README.md                               # Documentation of the architecture
│
├── Implementation_Phases/                      # Main folder for implementation phases
│   ├── Phase_01_Installation_Join_Domain/       # Details for Phase 1: Installation & Domain Join
│   ├── Phase_02_Domain_Integration_User_Management/ # Details for Phase 2: Domain Integration & User Management
│   ├── Phase_03_Helpdesk_Network_Troubleshooting/ # Details for Phase 3: Helpdesk & Network Troubleshooting
│   ├── Phase_04_AzureAD_Sync_Endpoint_Security/ # Details for Phase 4: Azure AD Sync & Endpoint Security
│   ├── Phase_05_AD_Security_Hardening/         # Details for Phase 5: Active Directory Security Hardening
│   ├── Phase_06_Backup_Recovery_Preparation/   # Details for Phase 6: Backup & Recovery Preparation
│   ├── Phase_07_Sentinel_Defender_Integration/ # Details for Phase 7: Sentinel & Defender Integration
│   ├── Phase_08_Phishing_Simulation_User_Awareness/ # Details for Phase 8: Phishing Simulation & User Awareness
│   ├── Phase_09_Forensics_Post_Attack/          # Details for Phase 9: Forensics Post-Attack
│   ├── Phase_10_Post_Incident_Recovery_Integrity_Check/ # Details for Phase 10: Post-Incident Recovery & Integrity Check
│   └── Phase_11_Compliance_Mapping_ISO_NIST/    # Details for Phase 11: Compliance Mapping (ISO/NIST)
│
├── 01_Zero_Trust_Security/                     # Contains Zero Trust policies and implementation
│   ├── MFA_Configuration/                      # Multi-factor Authentication setup
│   ├── Conditional_Access/                     # Conditional Access policies
│   ├── Device_Compliance/                      # Device compliance policies
│   └── README.md                               # Explanation of Zero Trust implementation
│
├── 02_Sentinel_Security_Operations/            # Contains Sentinel configurations, alerts, and playbooks
│   ├── Alerts/                                 # Sentinel alert handling configurations
│   ├── Playbooks/                              # Sentinel playbooks for automation
│   ├── KQL_Queries/                            # Custom KQL queries for monitoring
│   └── README.md                               # Documentation for Sentinel integration and alert management
│
├── 03_Forensics_Analysis/                      # Forensic analysis after incidents
│   ├── Event_Logs/                             # Event logs collected post-attack
│   ├── Evidence/                               # Forensic evidence and artifacts
│   └── README.md                               # Explanation of forensic analysis workflow
│
├── 04_IT_Support/                             # IT support scripts and troubleshooting tools
│   ├── Scripts/                                # Common scripts (password resets, troubleshooting, etc.)
│   ├── Troubleshooting/                        # Network troubleshooting guides and tools
│   └── README.md                               # IT support guide and tools overview
│
├── 05_Compliance_NIST_ISO/                     # Documentation for ISO/NIST compliance mapping
│   ├── ISO_27001_Mapping/                      # ISO/IEC 27001 controls and implementation
│   ├── NIST_CSF_Mapping/                       # NIST CSF controls and implementation
│   └── README.md                               # Summary of compliance mapping
│
├── 06_Phishing_Simulation/                     # Phishing simulation and user awareness training
│   ├── Phishing_Emails/                        # Sample phishing emails
│   ├── User_Training/                          # User awareness training materials
│   ├── Defender_Logs/                          # Logs from Microsoft Defender related to phishing
│   └── README.md                               # Overview of phishing simulation process and lessons learned
│
├── 07_Final_Documentation/                     # Final reports, conclusions, and cleanup
│   ├── Final_Report/                           # Summary of the entire implementation and findings
│   ├── Export_PDF/                             # Final exported PDF documentation
│   ├── Conclusion_Reports/                     # Detailed conclusions and lessons learned
│   └── README.md                               # Documentation for final project cleanup and summary
│
└── LICENSE                                      # Project license (e.g., MIT License)

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
