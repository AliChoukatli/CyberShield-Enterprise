# 🛡️ IT Support & Cybersecurity Project – Small Business Simulation (25 Users)

This project simulates the implementation of a secure, cloud-based IT environment for a fictional small business with 25 employees. It follows modern best practices including the Zero Trust model, ISO/IEC 27001, and the NIST Cybersecurity Framework (CSF), using Microsoft 365, Azure AD (Entra ID), Intune, Microsoft Defender, and Sentinel.

---

## 🧱 Objectives

- Deploy a modern cloud IT infrastructure
- Apply cybersecurity best practices (Zero Trust, ISO/NIST)
- Manage identities, endpoints, and security operations
- Simulate a phishing attack and incident response workflow
- Automate common IT support tasks using PowerShell

---

## 🧩 Tech Stack

| Area                  | Tools & Services                                           |
|-----------------------|------------------------------------------------------------|
| Identity & Access     | Microsoft 365, Azure AD (Entra ID), MFA, Conditional Access |
| Endpoint Management   | Windows 11, Intune, BitLocker, Microsoft Defender for Endpoint |
| Security Monitoring   | Microsoft Sentinel, KQL, Security Alerts, Logs             |
| Automation            | PowerShell scripting                                       |
| Frameworks Applied    | ISO/IEC 27001, NIST CSF, Zero Trust                         |

---

## 📁 Project Structure
/Projet_IT_Support_Cybersec/ │ ├── README.md 
# Project documentation ├── LICENSE 
# License file (MIT License) ├── Compliance/ # Compliance-related files 
│ └── Mapping_ISO_NIST.xlsx # Compliance mapping (ISO & NIST) ├── ZeroTrust/ # Zero Trust related materials │ └── Zero_Trust_Implementation_Guide.pdf # Guide for Zero Trust implementation ├── Support_IT/ # IT support scripts and tools │ └── PowerShell_Scripts/ # PowerShell scripts for automation │ ├── DeployOffice365.ps1 # Auto-install Office for new endpoints │ ├── Reset-UserPassword.ps1 # Helpdesk password reset tool │ └── Get-SecurityStatus.ps1 # Export security compliance status from Intune ├── Cybersecurity/ # Cybersecurity-related content │ └── Sentinel_Alerts_Triage/ # Files related to Sentinel alerts triage │ ├── KQL_queries.txt # KQL queries for log analysis │ └── Playbook_AutoResponse.json # Playbook for automated incident response ├── Incident_Response/ # Incident response-related documentation │ └── Phishing_Simulation_Steps.md # Steps for phishing simulation incident ├── Screenshots/ # Screenshots for demonstration │ └── Forensics_Analysis/ # Screenshots of forensic analysis steps


---

## 🔐 Zero Trust Implementation (Integrated)

| Principle         | Implementation                                     |
|-------------------|----------------------------------------------------|
| Verify explicitly | MFA, device compliance, and sign-in risk policies |
| Least privilege   | RBAC with limited access permissions               |
| Assume breach     | Endpoint monitoring, isolation, security alerts   |

---

## 📄 Compliance Mapping (Summary)

| Framework Control                  | Implementation                               |
|------------------------------------|-----------------------------------------------|
| ISO/IEC 27001 A.9.2 – User Access  | Azure AD, Conditional Access                  |
| ISO/IEC 27001 A.12.4 – Logging     | Microsoft Defender, Sentinel Logs             |
| NIST CSF PR.AC – Access Control    | Identity and role-based access setup          |
| NIST CSF DE.CM – Continuous Monitoring | Defender for Endpoint                     |
| NIST CSF RS.RP – Response Planning | Sentinel alert triage & basic response        |

[Full mapping available here](Cybersecurity/Compliance/Compliance_Mapping.md)

---

## 🧪 Incident Response Simulation

**Use Case:** A user opens a phishing email → endpoint is compromised → alert is triggered

### Workflow:

1. Defender detects a malicious file from phishing
2. Sentinel logs the alert and triggers high severity
3. Triage done using KQL and log review
4. Forensic evidence collected:
   - Windows Event Viewer (IDs: 4104, 4624, 4688)
   - Browser/USB artifacts (noted only)
5. User account disabled and isolated
6. Root cause summary noted in [Incident_Response/Phishing_Simulation_Steps.md](Incident_Response/Phishing_Simulation_Steps.md)
## ⚙️ PowerShell Tools (Support IT)

| Script Name              | Purpose                                        |
|--------------------------|------------------------------------------------|
| DeployOffice365.ps1      | Auto-install Office for new endpoints          |
| Reset-UserPassword.ps1   | Helpdesk password reset tool                   |
| Get-SecurityStatus.ps1   | Export security compliance status from Intune  |

---

## 📸 Screenshots

All key screenshots are stored in `/Screenshots`:
- Alert detection from Sentinel
- Defender investigation page
- Forensics: Windows Event Viewer logs

---

## 🚀 Status

✅ 100% Complete – Optimized for learning, labs, and interviews  
📌 Designed to demonstrate both IT support & cybersecurity fundamentals

---

## 🧠 Bonus Ideas

If you'd like to expand this project:
- Add SSO integration with a SaaS app
- Create a simple incident response PDF report
- Build a video walkthrough or portfolio slide

---

## 🗂️ License

MIT License

