# **🛡️ IT Support & Cybersecurity Project – Small Business Simulation (25 Users)**

This project simulates the implementation of a secure, cloud-based IT environment for a fictional small business with 25 employees. It follows modern best practices including the Zero Trust model, ISO/IEC 27001, and the NIST Cybersecurity Framework (CSF), using Microsoft 365, Azure AD (Entra ID), Intune, Microsoft Defender, and Sentinel.

## 📑 Index

1. [Introduction](introduction)
2. [Objectives](https://github.com/AliChoukatli/SecureIT-for-SMB/tree/main?tab=readme-ov-file#-objectives)
3. [Tools](https://github.com/AliChoukatli/SecureIT-for-SMB/tree/main?tab=readme-ov-file#-tools)
4. [How to Use This Project](https://github.com/AliChoukatli/SecureIT-for-SMB/tree/main?tab=readme-ov-file#-how-to-use-this-project)
5. [Project Structure](https://github.com/AliChoukatli/SecureIT-for-SMB/blob/main/README.md#-project-structure)
6. [Zero Trust Implementation](https://github.com/AliChoukatli/SecureIT-for-SMB/tree/main?tab=readme-ov-file#-zero-trust-implementation-integrated)
7. [Compliance Mapping (Summary)](https://github.com/AliChoukatli/SecureIT-for-SMB/tree/main?tab=readme-ov-file#-compliance-mapping-summary)
8. [Incident Response Simulation](https://github.com/AliChoukatli/SecureIT-for-SMB/tree/main?tab=readme-ov-file#-incident-response-simulation)
9. [PowerShell Tools (Support IT)](https://github.com/AliChoukatli/SecureIT-for-SMB/tree/main?tab=readme-ov-file#%EF%B8%8F-powershell-tools-support-it)
10. [License](https://github.com/AliChoukatli/SecureIT-for-SMB/tree/main?tab=readme-ov-file#%EF%B8%8F-license)

## **🧱 Objectives**

- Deploy a modern cloud IT infrastructure
- Apply cybersecurity best practices (Zero Trust, ISO/NIST)
- Manage identities, endpoints, and security operations
- Simulate a phishing attack and incident response workflow
- Automate common IT support tasks using PowerShell

## 🧩 **Tools**

| Area                | Tools & Services                                                   |
|---------------------|--------------------------------------------------------------------|
| IAM                 | Microsoft 365, Azure AD (Entra ID), MFA, Conditional Access       |
| Endpoint Management  | Windows 11, Intune, BitLocker, Microsoft Defender for Endpoint    |
| Security Monitoring  | Microsoft Sentinel, KQL, Security Alerts, Logs                    |
| Automation           | PowerShell scripting                                              |
| Frameworks Applied   | ISO/IEC 27001, NIST CSF, Zero Trust                               |
  

## 🔧 **How to Use This Project**

A 10-step guide to deploy and secure your SMB infrastructure.

- [**Step 1**: Installation & Base Configuration](https://github.com/AliChoukatli/SecureIT-for-SMB/blob/main/Implementation%20Phases/Phase_1.md)         # Windows Server, AD DS, DNS, static IPs, domain join
- [**Step 2**: AD User & Group Support](https://github.com/AliChoukatli/SecureIT-for-SMB/blob/main/Implementation%20Phases/Phase_2.md)                   # Création et gestion des comptes, groupes, GPO, droits
- [**Step 3**: Helpdesk & Network Troubleshooting](https://github.com/AliChoukatli/SecureIT-for-SMB/blob/main/Implementation%20Phases/Phase_5.md)        # Support IT : accès distant, ipconfig, drivers, outils
- [**Step 4:** Endpoint Security & Device Management](https://github.com/AliChoukatli/SecureIT-for-SMB/blob/main/Implementation%20Phases/Phase_2.md)     # Join Intune, compliance, scripts, config device                 
- [**Step 5**: Zero Trust (MFA, CA, BitLocker)](https://github.com/AliChoukatli/SecureIT-for-SMB/blob/main/Implementation%20Phases/Phase_3.md)           # MFA, accès conditionnel, chiffrement, hardening
- [**Step 6**: Sentinel & Defender Integration](https://github.com/AliChoukatli/SecureIT-for-SMB/blob/main/Implementation%20Phases/Phase_6.md)           # Monitoring, alertes, règles KQL, automatisation     
- [**Step 7**: Phishing Simulation](https://github.com/AliChoukatli/SecureIT-for-SMB/blob/main/Implementation%20Phases/Phase_7.md)                       # Email piégé, Event Viewer, analyse Defender
- [**Step 8**: Post-Attack Forensics](https://github.com/AliChoukatli/SecureIT-for-SMB/blob/main/Implementation%20Phases/Phase_8.md)                     # Logs, artefacts, Event ID, rapport d’incident 
- [**Step 9**: ISO/NIST Compliance Mapping](https://github.com/AliChoukatli/SecureIT-for-SMB/blob/main/Implementation%20Phases/Phase_9.md)               # Alignement ISO 27001 / NIST CSF, gouvernance
- [**Step 10**: Cleanup & Final Documentation](https://github.com/AliChoukatli/SecureIT-for-SMB/blob/main/Implementation%20Phases/Phase_10.md)           # README final, captures, PDF export, nettoyage

---


## 📁 **Project Structure**
```
IT-Support-Cybersecurity-SMB/
│
├── 📁 00_Architecture            # High-level diagrams & docs
│   ├── network_topology.png       # Diagram of network layout
│   ├── zero_trust_overview.svg    # Zero Trust model flow
│   └── README.md                  # Explanations of each diagram
│
├── 📄 README.md                   # Overview of the entire project
├── 📄 LICENSE                     # (optional) License type if sharing publicly
├── 📄 .gitignore                  # Files/folders ignored by Git
│
├── 📁 01_Installation_Config      # Windows Server installation, AD, static IP setup
│   ├── README.md
│   └── screenshots/
│
├── 📁 02_IT_Support               # Helpdesk tasks: RDP, password reset, network tools
│   ├── README.md
│   ├── scripts/
│   └── network_troubleshooting/
│ 
└── 📁03_Identity_Endpoint_Management/
│    │   │
│    │   ├── 01_azure_ad_user_creation.png       ← capture de la création d’un user
│    │   ├── 02_azure_ad_group_creation.png      ← capture de la création d’un groupe
│    │   
│    └── device_join_scripts/
│        └── (intune enrollment, hybrid join scripts, etc.)
│
│
├── 📁 04_Zero_Trust_Security      # MFA, Conditional Access, BitLocker, security baselines
│   ├── README.md
│   ├── scripts/
│   └── configurations/
│
├── 📁 05_Sentinel_Security_Operations    # Microsoft Sentinel alert handling, KQL, automation
│   ├── README.md
│   ├── playbooks/
│   └── alerts/
│
├── 📁 06_Phishing_Simulation      # Simulated phishing attack + Event Viewer & Defender logs
│   ├── README.md
│   ├── captures_logs/
│   └── phishing_playbook/
│
├── 📁 07_Forensics_Analysis       # Post-attack forensic analysis (Event IDs, attacker traces)
│   ├── README.md
│   ├── evidence/
│   └── forensic_tools/
│
├── 📁 08_Compliance_ISO_NIST      # ISO 27001 / NIST CSF mapping, policies
│   ├── README.md
│   ├── mappings/
│   └── policies/
│
├── 📁 09_Final_Documentation      # Final README, technical notes, conclusions
│   ├── README.md
│   ├── export_pdf/
│   └── conclusion_reports/
│
```


## 🔐 **Zero Trust Implementation (Integrated)**

| Principle         | Implementation                                     |
|-------------------|----------------------------------------------------|
| Verify explicitly | MFA, device compliance, and sign-in risk policies |
| Least privilege   | RBAC with limited access permissions              |
| Assume breach     | Endpoint monitoring, isolation, security alerts   |



## 📄 **Compliance Mapping (Summary)**

| Framework         | Control ID         | Implementation Example                      |
|-------------------|--------------------|---------------------------------------------|
| ISO/IEC 27001     | A.9.2 – User Access| Azure AD, Conditional Access                |
| ISO/IEC 27001     | A.12.4 – Logging   | Microsoft Defender, Sentinel Logs           |
| NIST CSF          | PR.AC – Access Ctrl| Identity and Role-Based Access Setup        |
| NIST CSF          | DE.CM – Monitoring | Defender for Endpoint Continuous Monitoring |
| NIST CSF          | RS.RP – Response   | Sentinel Alert Triage and Response          |

🔗 **Full version available in** [Mapping_ISO_NIST.xlsx](./Mapping_ISO_NIST.xlsx)


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




## ⚙️ **PowerShell Tools (Support IT)**

| Script Name              | Purpose                                        |
|--------------------------|------------------------------------------------|
| DeployOffice365.ps1      | Auto-install Office for new endpoints          |
| Reset-UserPassword.ps1   | Helpdesk password reset tool                   |
| Get-SecurityStatus.ps1   | Export security compliance status from Intune  |




## 🗂️ License

MIT License
