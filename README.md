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
/Secure_IT_for_SMB/                           <-- Répertoire principal du projet
│
├── README.md                                 <-- Fichier de documentation du projet
├── LICENSE                                   <-- Informations sur la licence du projet
│
├── Compliance/                               <-- Répertoire pour la conformité et les normes
│   └── Mapping_ISO_NIST.xlsx                 <-- Fichier Excel pour le mapping ISO/NIST
│
├── ZeroTrust/                                <-- Répertoire pour le modèle Zero Trust
│   └── Zero_Trust_Implementation_Guide.pdf   <-- Guide de mise en œuvre Zero Trust
│
├── Cybersecurity/                            <-- Répertoire pour la surveillance de la sécurité
│   ├── Sentinel_Alerts_Triage/               <-- Répertoire pour les alertes et le triage de Sentinel
│   │   ├── KQL_queries.txt                   <-- Requêtes KQL
│   │   └── Playbook_AutoResponse.json        <-- Playbook pour la réponse automatique
│   └── Screenshots/                          <-- Captures liées à la cybersécurité
│       ├── Sentinel_Alert.png
│       └── Defender_Investigation.png
│
├── Incident_Response/                        <-- Répertoire pour la réponse aux incidents
│   ├── Phishing_Simulation_Steps.md          <-- Détails de la simulation de phishing
│   └── Screenshots/                          <-- Captures spécifiques à la simulation d'incident
│       ├── Phishing_Email.png
│       └── EventViewer_Logs.png
│
├── Support_IT/                               <-- Répertoire pour le support technique
│   ├── PowerShell_Scripts/                   <-- Scripts PowerShell
│   │   ├── DeployOffice365.ps1
│   │   ├── Reset-UserPassword.ps1
│   │   └── Get-SecurityStatus.ps1
│   └── Screenshots/                          <-- Captures pour les tâches IT
│       ├── AD_User_Creation.png
│       └── Group_Management.png
│
├── Forensics_Analysis/                       <-- Répertoire pour les preuves forensiques
│   └── Screenshots/                          <-- Captures liées à l'analyse post-incident
│       ├── Logon_Event_4624.png              <-- Connexion suspecte
│       └── PowerShell_4104.png               <-- Script PowerShell malveillant exécuté


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
