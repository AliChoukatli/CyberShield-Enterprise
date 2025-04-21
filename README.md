# 🛡️ IT Support & Cybersecurity Project – Small Business Simulation (25 Users)

This project simulates the implementation of a secure, cloud-based IT environment for a fictional small business with 25 employees. It follows modern best practices including the Zero Trust model, ISO/IEC 27001, and the NIST Cybersecurity Framework (CSF), using Microsoft 365, Azure AD (Entra ID), Intune, Microsoft Defender, and Sentinel.


## 🧱 Objectives

- Deploy a modern cloud IT infrastructure
- Apply cybersecurity best practices (Zero Trust, ISO/NIST)
- Manage identities, endpoints, and security operations
- Simulate a phishing attack and incident response workflow
- Automate common IT support tasks using PowerShell







## 🧩 Tools

| Area                | Tools & Services                                                   |
|---------------------|--------------------------------------------------------------------|
| IAM                 | Microsoft 365, Azure AD (Entra ID), MFA, Conditional Access       |
| Endpoint Management  | Windows 11, Intune, BitLocker, Microsoft Defender for Endpoint    |
| Security Monitoring  | Microsoft Sentinel, KQL, Security Alerts, Logs                    |
| Automation           | PowerShell scripting                                              |
| Frameworks Applied   | ISO/IEC 27001, NIST CSF, Zero Trust                               |

## 📁 Project Structure

This project is organized into several key sections, each serving a specific purpose:

```
/Secure_IT_for_SMB/
├── README.md
├── LICENSE
│
├── Compliance/
│   └── Mapping_ISO_NIST.xlsx
│
├── ZeroTrust/
│   └── Zero_Trust_Implementation_Guide.pdf
│
├── Support_IT/
│   ├── PowerShell_Scripts/
│   │   ├── DeployOffice365.ps1
│   │   ├── Reset-UserPassword.ps1
│   │   └── Get-SecurityStatus.ps1
│   └── Screenshots/
│       ├── Group_Management.png
│       ├── Password_Reset_AD.png
│       ├── AD_Permissions_Management.png
│       ├── Remote_Support_TeamViewer.png
│       ├── Remote_Desktop_Session.png
│       ├── Device_Manager_Troubleshooting.png
│       ├── Windows_Network_Troubleshooter.png
│       ├── CMD_Ping_Test.png
│       └── CMD_Ipconfig_Results.png
│
├── Cybersecurity/
│   ├── Sentinel_Alerts_Triage/
│   │   ├── KQL_queries.txt
│   │   └── Playbook_AutoResponse.json
│   └── Screenshots/
│       ├── Sentinel_Alert.png
│       └── Defender_Investigation.png
│
├── Incident_Response/
│   ├── Phishing_Simulation_Steps.md
│   └── Screenshots/
│       ├── Phishing_Email.png
│       └── EventViewer_Logs.png
│
├── Forensics_Analysis/
│   └── Screenshots/
│       ├── Logon_Event_4624.png
│       └── PowerShell_4104.png

```


## 🔐 Zero Trust Implementation (Integrated)

| Principle         | Implementation                                     |
|-------------------|----------------------------------------------------|
| Verify explicitly | MFA, device compliance, and sign-in risk policies |
| Least privilege   | RBAC with limited access permissions              |
| Assume breach     | Endpoint monitoring, isolation, security alerts   |



## 📄 Compliance Mapping (Summary)

| Framework         | Control ID         | Implementation Example                      |
|-------------------|--------------------|---------------------------------------------|
| ISO/IEC 27001     | A.9.2 – User Access| Azure AD, Conditional Access                |
| ISO/IEC 27001     | A.12.4 – Logging   | Microsoft Defender, Sentinel Logs           |
| NIST CSF          | PR.AC – Access Ctrl| Identity and Role-Based Access Setup        |
| NIST CSF          | DE.CM – Monitoring | Defender for Endpoint Continuous Monitoring |
| NIST CSF          | RS.RP – Response   | Sentinel Alert Triage and Response          |

🔗 **Full version available in** [Mapping_ISO_NIST.xlsx](./Mapping_ISO_NIST.xlsx)




## 🧪 Incident Response Simulation

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




## ⚙️ PowerShell Tools (Support IT)

| Script Name              | Purpose                                        |
|--------------------------|------------------------------------------------|
| DeployOffice365.ps1      | Auto-install Office for new endpoints          |
| Reset-UserPassword.ps1   | Helpdesk password reset tool                   |
| Get-SecurityStatus.ps1   | Export security compliance status from Intune  |



## 📸 Screenshots

## 🖼️ Captures d’écran

📁 `Cybersecurity/Screenshots/`
- `Sentinel_Alert.png` – Détection d'alerte via Microsoft Sentinel
- `Defender_Investigation.png` – Vue de l'analyse Defender

📁 `Incident_Response/Screenshots/`
- `Phishing_Email.png` – Capture de l'email de phishing
- `EventViewer_Logs.png` – Journaux d'événements liés à l'incident

📁 `Support_IT/Screenshots/`
- `AD_User_Creation.png` – Ajout d’un utilisateur via Active Directory
- `Group_Management.png` – Gestion des groupes

📁 `Screenshots/Forensics_Analysis/`
- `Logon_Event_4624.png` – Connexion suspecte
- `PowerShell_4104.png` – Script PowerShell malveillant exécuté


## 🗂️ License

MIT License
