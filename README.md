# 🛡️ CyberShield Entreprise - Small Business Simulation (25 Users)

This project simulates the implementation of a secure, cloud-based IT environment for a fictional small business with 25 employees. It follows modern best practices including the Zero Trust model, ISO/IEC 27001, and the NIST Cybersecurity Framework (CSF), using Microsoft 365, Azure AD (Entra ID), Intune, Microsoft Defender, and Sentinel.

> **Company Context:**  
> *CyberShield Entreprise is a fictional SMB in the financial services sector. Due to handling sensitive customer data, security and compliance are top priorities.*

---
## 📑 Index

1.## 📑 Index

1. [🎯 Global Project Objective](#-global-project-objective)
2. [🏢 Target Environment](#-target-environment)
3. [📐 Architecture & Objectives](#-architecture--objectives)
4. [📂 How to Navigate the Folders](#-how-to-navigate-the-folders)
5. [📁 Project Structure](#-project-structure)
6. [🧩 Tools & Services](#-tools--services)
7. [🚀 How to Use This Project (Phases)](#-how-to-use-this-project-phases)
8. [🔐 Zero Trust Implementation](#-zero-trust-implementation-integrated)
9. [⚙️ PowerShell Tools (Support IT)](#️-powershell-tools-support-it)
10. [🧪 Incident Response Simulation](#-incident-response-simulation)
11. [📊 Security Posture: Before & After](#-security-posture-before--after)
12. [✅ Compliance Mapping (Summary)](#-compliance-mapping-summary)
13. [📄 License](#️-license)

---

## 📐 Architecture & Objectives

**CyberShield Entreprise** simulates the deployment of a modern, secure IT infrastructure for a fictional small business with 25 employees. The goal is to implement a cloud-based IT environment following cybersecurity best practices such as the **Zero Trust model**, **ISO/IEC 27001**, and the **NIST Cybersecurity Framework (CSF)**, leveraging **Microsoft 365**, **Azure AD**, **Intune**, **Defender**, and **Sentinel**.

**Project Goals:**

- Deploy a modern cloud IT infrastructure
- Apply cybersecurity best practices (Zero Trust, ISO/NIST)
- Manage identities, endpoints, and security operations
- Simulate phishing and incident response workflows
- Automate common IT support tasks using PowerShell

<p align="center">
  <img src="https://github.com/AliChoukatli/SecureIT-for-SMB/blob/main/Architecture/Architecture.png" alt="Architecture" width="600"/>
</p>

---

## 🏢 Target Environment

| Element                | Description                                                           |
|------------------------|-----------------------------------------------------------------------|
| **Company Type**       | Small Business (Financial Sector)                                     |
| **User Base**          | 25 employees across multiple departments                              |
| **Core Infrastructure**| 1 Domain Controller, 1 File Server, 3 Windows 11 workstations          |
| **Technologies**       | Microsoft 365, Entra ID (Azure AD), Intune, Defender, Sentinel        |
| **Security Standards** | Zero Trust Model, ISO/IEC 27001, NIST Cybersecurity Framework (CSF)   |
| **OS Used**            | Windows Server 2022, Windows 11 Pro                                   |
| **Management Tools**   | PowerShell scripts, Group Policy, Intune, Entra portal                |


## 📂 How to Navigate the Project

Each folder in this repository corresponds to a **phase of the project**, aligned with key milestones in the secure IT deployment lifecycle.

Inside each folder, you will typically find:
- `Documentation/` – Guides and procedures
- `Scripts/` – PowerShell scripts used
- `Screenshots/` – Visual proof of implementation

> Example:  
> `03_AzureAD Sync & Endpoint Security/Documentation/Intune_Configuration.md` shows policy setup for device compliance.

---

## 🔗 Project Phase Index

| Phase | Description |
|-------|-------------|
| [00_IT Support & Helpdesk](./00_IT%20Support%20&%20Helpdesk) | Simulated user support tools and troubleshooting scripts |
| [01_Installation & Domain Join](./01_Installation%20&%20Domain%20Join) | Installation of server/workstations and local domain join |
| [02_Active Directory Integration](./02_Active%20Directory%20Integration) | OU structure, user & group management, NTFS permissions |
| [03_AzureAD Sync & Endpoint Security](./03_AzureAD%20Sync%20&%20Endpoint%20Security) | Hybrid join, Intune policies, BitLocker, Windows Defender |
| [04_Security Hardening](./04_Security%20Hardening) | MFA, Conditional Access, GPO segmentation, auditing |
| [05_Backup & Recovery Preparation](./05_Backup%20&%20Recovery%20Preparation) | Backup strategy, test restores, disaster readiness |
| [06_Sentinel & Defender Integration](./06_Sentinel%20&%20Defender%20Integration) | SIEM setup, alert rules, Defender for Endpoint |
| [07_Phishing Simulation & User Awareness](./07_Phishing%20Simulation%20&%20User%20Awareness) | User training, simulated phishing, vulnerability reporting |
| [08_Forensics Post-Attack](./08_Forensics%20Post-Attack) | Log review, IOC detection, incident timeline |
| [09_Post-Incident Recovery & Integrity Check](./09_Post-Incident%20Recovery%20&%20Integrity%20Check) | Service recovery validation and integrity checks |
| [10_Compliance Mapping (ISO-NIST)](./10_Compliance%20Mapping%20(ISO-NIST)) | Mapping to ISO 27001 & NIST CSF controls |

---

## 📁 Project Structure

```bash
CyberShield_Enterprise/
├── 00_IT_Support_and_Helpdesk/                   # Support team workflows & troubleshooting
│   ├── Documentation/                             # Guides and procedures for support staff
│   │   ├── Support_Tools_Overview.md             # Overview of remote assistance and helpdesk tools
│   │   ├── First_Level_Troubleshooting.md        # Step-by-step common issues resolution guide
│   │   ├── Ticket_Simulation_Log.md               # Example logs simulating ticket handling scenarios
│   ├── Scripts/                                   # Automation scripts for common support tasks
│   │   ├── Network_Troubleshooting.ps1            # PowerShell script for network diagnostics
│   │   └── Connectivity_Checker.ps1               # Script to verify network connectivity status
│   └── Resources/                                 # Additional materials for support use
│       ├── Remote_Assistance_Tools.md             # Details on software used for remote help
│       └── Support_Flowchart.png                   # Visual workflow for support escalation

├── 01_Installation_and_Domain_Join/              # Initial setup and domain joining steps
│   ├── Documentation/                             # Written guides for installation/configuration
│   │   ├── Domain_Controller_Configuration.md     # Setting up and configuring the domain controller
│   │   ├── Workstation_Configuration.md           # Standard workstation setup documentation
│   │   └── Domain_Join_Steps.md                    # Step-by-step instructions for joining devices to domain
│   ├── Scripts/                                   # Scripts automating installation and join processes
│   │   ├── Server_Join_Script.ps1                  # Script to automate domain join for servers
│   │   └── Workstation_Join_Script.ps1             # Script to join workstations to domain
│   └── Screenshots/                               # Visual proof of steps/configuration

├── 02_Active_Directory_Integration/              # Managing AD structure and access control
│   ├── Documentation/                             # AD design and user/group management
│   │   ├── OU_Structure.md                         # Design and organization of Organizational Units (OUs)
│   │   ├── User_Management.md                      # Procedures for creating and managing user accounts
│   │   └── Access_Control.md                        # Group policies and permissions management
│   ├── Scripts/                                   # Scripts for AD automation
│   │   ├── Create_OU_Script.ps1                     # Script to create OUs programmatically
│   │   └── User_Group_Management_Script.ps1          # Script for user and group automation
│   └── Screenshots/                               # Screenshots of AD consoles, OU trees, permissions

├── 03_AzureAD_Sync_and_Endpoint_Security/        # Cloud identity & device management with compliance
│   ├── Documentation/                             # Cloud join and endpoint protection best practices
│   │   ├── Hybrid_Join_Guide.md                    # Guide to configuring Hybrid Azure AD join
│   │   ├── Intune_Configuration.md                  # Intune setup for device enrollment and management
│   │   ├── Device_Compliance_Policies.md            # Compliance policy definitions for endpoint security
│   │   ├── Endpoint_Security_Policies.md            # Endpoint protection policies including Defender
│   │   └── Security_Baselines.md                     # Microsoft security baselines applied on devices
│   ├── Scripts/                                   # Scripts related to Azure AD join and Intune enrollment
│   │   ├── AzureAD_Join_Script.ps1                   # Automate Azure AD join tasks
│   │   └── Intune_Enrollment_Script.ps1               # Automate device enrollment to Intune
│   └── Screenshots/                               # Visuals showing device compliance and endpoint management

├── 04_Zero_Trust_and_Security_Hardening/          # Core security policies and Zero Trust implementation
│   ├── Documentation/                             # Zero Trust principles and hardening procedures
│   │   ├── MFA_Enforcement.md                       # MFA policy deployment and enforcement details
│   │   ├── Conditional_Access_Configuration.md      # Configuration of Conditional Access policies
│   │   ├── Privileged_Account_Hardening.md          # Securing admin and privileged accounts
│   │   ├── GPO_Segmentation_Principle.md             # Group Policy design for network segmentation
│   │   └── Advanced_Auditing_Configuration.md        # Auditing and logging configurations for security
│   ├── Scripts/                                   # Automation of security policy enforcement
│   │   ├── Rename_Administrator_Script.ps1           # Script to rename default admin accounts
│   │   └── MFA_Policy_Script.ps1                       # Script to enforce MFA via policies
│   └── Screenshots/                               # Policy and enforcement confirmation screenshots

├── 05_Backup_Recovery_and_Business_Continuity/    # Backup strategy and disaster recovery planning
│   ├── Documentation/                             # Backup and recovery process documents
│   │   ├── Backup_Strategy.md                        # Backup types, schedules, and tools used
│   │   ├── Recovery_Plan.md                          # Step-by-step recovery procedures
│   │   └── Test_Recovery_Procedure.md                 # Documentation of recovery drills/tests
│   ├── Scripts/                                   # Backup and restore automation scripts
│   │   ├── Backup_Script.ps1                          # Automates backup tasks
│   │   └── Restore_Script.ps1                         # Automates restore procedures
│   └── Screenshots/                               # Proof of successful backup/restore runs

├── 06_Microsoft_Defender_and_Sentinel_Integration/ # Endpoint protection and security monitoring setup
│   ├── Documentation/                             # Defender and Sentinel deployment guides
│   │   ├── Defender_Endpoint_Integration.md           # How Defender is deployed and configured
│   │   ├── Sentinel_Configuration.md                   # Setting up Microsoft Sentinel for SIEM
│   │   └── Alert_Rules_Setup.md                         # Custom alert rules and incident response setup
│   ├── Scripts/                                   # Scripts to configure Defender and Sentinel
│   │   ├── Defender_Endpoint_Config.ps1                 # Automate Defender deployment/config
│   │   └── Sentinel_Log_Integration.ps1                  # Integrate logs to Sentinel workspace
│   └── Screenshots/                               # Dashboards and alert rule screenshots

├── 07_Phishing_Simulation_and_User_Awareness/       # Security awareness and phishing simulations
│   ├── Documentation/                             # Guides and reports on user training
│   │   ├── Phishing_Simulation_Guide.md               # How to run phishing campaigns
│   │   ├── Awareness_Training_Suggestions.md           # Best practices for end-user training
│   │   └── User_Vulnerability_Report.md                 # Report on user susceptibility results
│   └── Screenshots/                               # Campaign results and training examples

├── 08_Forensics_Post_Attack/                         # Incident investigation and forensic analysis
│   ├── Documentation/                             # Procedures and tools for forensic analysis
│   │   ├── Incident_Response_Plan.md                  # Plan for responding to security incidents
│   │   ├── Forensic_Analysis_Guide.md                 # Step-by-step forensic investigation procedures
│   │   └── Attack_Timeline.md                           # Timeline and root cause analysis
│   ├── Scripts/                                   # Scripts for log collection and IOC search
│   │   ├── Log_Collection_Script.ps1                    # Automate event/log collection
│   │   └── IoC_Search_Script.ps1                         # Search for Indicators of Compromise
│   └── Screenshots/                               # Screenshots from forensic tools and reports

├── 09_Post_Incident_Recovery_and_Integrity_Check/    # Restore services and verify system integrity
│   ├── Documentation/                             # Guidelines for post-incident recovery
│   │   ├── Recovery_Guidelines.md                      # Best practices for recovery after incidents
│   │   ├── Integrity_Check_Procedure.md                # Methods to verify system integrity post-attack
│   │   └── Service_Functionality_Test.md                # Testing restored services for functionality
│   ├── Scripts/                                   # Automation for integrity checks and tests
│   │   ├── Integrity_Check_Script.ps1                   # Scripts to verify file and system integrity
│   │   └── Service_Test_Script.ps1                       # Scripts to test service availability
│   └── Screenshots/                               # Evidence of recovery and system health

├── 10_Compliance_Mapping_ISO_NIST/                   # Mapping cybersecurity controls to standards
│   ├── Documentation/                             # Compliance documentation and mapping guides
│   │   ├── Compliance_Mapping_Guide.md                 # How controls map to ISO 27001 and NIST CSF
│   │   ├── ISO_27001_Annex_A.md                          # Annex A control catalog documentation
│   │   └── NIST_CSF_Controls.md                           # NIST CSF control framework details
│   └── Screenshots/                               # Compliance reports and gap analysis visuals

└── README.md                                       # Project overview, goals, and instructions

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
