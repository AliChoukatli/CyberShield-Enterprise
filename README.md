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
```
## 📁 Project Structure

This project is organized into several key sections, each serving a specific purpose:

- **README.md** : Ce fichier contient la documentation du projet, y compris l'introduction, les objectifs, et le statut.
- **LICENSE** : Contient des informations sur la licence du projet, ici sous licence MIT.
- **Compliance** : Inclut des fichiers relatifs à la conformité avec les normes ISO/IEC et NIST.
- **ZeroTrust** : Comprend un guide détaillant la mise en œuvre du modèle Zero Trust dans l'environnement.
- **Support_IT** : Contient des scripts PowerShell automatisant diverses tâches de support informatique.
- **Cybersecurity** : Regroupe les outils et ressources utilisés pour la surveillance de la sécurité via Microsoft Sentinel et la gestion des alertes.
- **Incident_Response** : Documente le processus de réponse à un incident de cybersécurité (par exemple, une simulation de phishing).
- **Screenshots** : Contient les captures d'écran liées aux investigations forensiques et à la détection des alertes.

---

Cela devrait maintenant afficher correctement l'arborescence dans le `README.md` lorsque tu le colles dans ton fichier. Assure-toi de bien garder la structure de code avec les trois accents graves ``` pour l'arborescence et les sections.


```
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

