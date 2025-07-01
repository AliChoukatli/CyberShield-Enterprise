# 🛡️ CyberShield Entreprise – Securing a Small Business (25 Users)

This project simulates the end-to-end deployment of a secure, hybrid-cloud IT infrastructure for a fictional small business in the financial sector. It applies modern cybersecurity practices aligned with **Zero Trust**, **ISO/IEC 27001**, and **NIST CSF** using **Microsoft 365**, **Azure AD (Entra ID)**, **Intune**, **Microsoft Defender**, and **Microsoft Sentinel**.

> **Context:** Fictional SMB named *CyberShield Entreprise* handling sensitive financial data with a staff of 25. Prioritizing security, compliance, and remote device management.

---

## 📚 Table of Contents

1. [🎯 Global Objectives](#-global-objectives)
2. [🏢 Environment Overview](#-environment-overview)
3. [📐 Architecture](#-architecture)
4. [🚩 Project Phases Overview](#-project-phases-overview)
5. [🔐 Zero Trust Implementation](#-zero-trust-implementation)
6. [📊 Security Before vs After](#-security-before-vs-after)
7. [✅ Compliance Mapping](#-compliance-mapping)

---

## 🎯 Global Objectives

1. Establish and secure on-premises Active Directory infrastructure  
2. Manage users, groups, and access control efficiently  
3. Deploy Office 365 and automate IT support tasks  
4. Enable hybrid device management with Azure AD and Intune  
5. Implement Zero Trust security with MFA and endpoint hardening  


---

## 🏢 Environment Overview

| Component        | Details                                                                         |
| ---------------- | --------------------------------------------------------------------------------|
| **Users**        | 25 (across multiple departments)                                                 |
| **Devices**      | 1 Domain Controller, 1 File Server, 3 Workstations                               |
| **OS**           | Windows Server 2022, Windows 11 Entreprise                                       |
| **Licensing**    | Microsoft 365 Business Premium P1                                                |
| **Hybrid Setup** | Azure AD Connect (Password Hash Sync + SSO)                                      |
| **Device Join**  | Hybrid Azure AD Join + Intune                                                    |
| **Security**     | Microsoft Defender for Endpoint, Windows Firewall, BitLocker, Conditional Access |
| **MFA**          | Windows Hello, Microsoft Authenticator, FIDO2, TAP                               |

---

## 📐 Architecture

![Architecture](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/Screenshots/Architecture.jpg)

The project integrates Microsoft on-premises and cloud services to manage and protect user identities, devices, and data while ensuring full compliance with recognized standards.

---

## 🚩 Project Phases Overview

| Phase                                                                | Description                                                                                                                                                                                 |
| ---------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| ✅ **1 – Domain_Setup_&_Workstation_Join**                           | Prepares servers and workstations, domain controller installation, workstation domain join, and Hyper-V environment setup.                                                                  |
| ✅ **2 – AD_Integration_User_Management**                            | OU creation, user & group management, NTFS permission setup, RDP access policy, and user lifecycle simulation.                                                                              |
| ✅ **3 – IT_Helpdesk_&_Network_Troubleshooting**                     | Office 365 deployment via ODT and PowerShell, troubleshooting scenarios, user profile repairs, and automation scripts for support tasks.                                                    |
| ✅ **4 – Azure AD Sync & Endpoint Security**                         | Hybrid join of devices, Intune management, application of security & compliance policies, Windows Defender Firewall, BitLocker encryption, and Microsoft Defender for Endpoint onboarding.  |
| ✅ **5 – Zero_Trust_&_Security_Hardening**                           | MFA (WHfB, Authenticator App, TAP, FIDO2), integration with Conditional Access, Zero Trust configuration, Misconfig & Resolution & EXposure Security Analysis                               |
| ✅ **6 – Threat_Detection_&_Simulation**                             |
---

## 🔐 Zero Trust Implementation

| Principle               | Implementation Example                                        |
| ----------------------- | ------------------------------------------------------------- |
| **Verify Explicitly**   | MFA (Windows Hello, Authenticator, FIDO2), Conditional Access |
| **Use Least Privilege** | Role-based access, restricted admin use, separate accounts    |
| **Assume Breach**       | Endpoint detection (EDR), centralized logs, alert response    |

All policies and technologies are aligned with Zero Trust security model.

---

## 📊 Security Before vs After

| Security Element              | Before Hardening     | After Implementation                        |
| ----------------------------- | -------------------- | ------------------------------------------- |
| Multi-Factor Authentication   | ❌ Not enabled        | ✅ Windows Hello, Authenticator, FIDO2, TAP  |
| Endpoint Compliance           | ❌ Uncontrolled       | ✅ Intune + Defender Baselines               |
| Device Encryption (BitLocker) | ❌ Disabled           | ✅ Enforced via Intune                       |
| Firewall Configuration        | ❌ Default rules      | ✅ Custom rules via GPO & Intune             |
| Privileged Access Control     | ❌ Admin used daily   | ✅ User accounts + Role-based Admins         |
| Defender for Endpoint         | ❌ Not deployed       | ✅ Cloud or GPO onboarding + central console |
| Exposure Level                | ⚠️ High (pre-attack)  | ✅ Mitigated via Intune & GPO & PowerShell    |

---

## ✅ Compliance Mapping

| Framework         | Control ID               | Implementation Example                           |
| ----------------- | ------------------------ | ------------------------------------------------ |
| **ISO/IEC 27001** | A.9.2 – User Access Mgmt | Azure AD + Group Membership + Conditional Access |
| **ISO/IEC 27001** | A.12.4 – Logging         | Microsoft Defender + Sentinel SIEM               |
| **NIST CSF**      | PR.AC – Access Control   | MFA, Role-based Privileges                       |
| **NIST CSF**      | DE.CM – Detect/Monitor   | Endpoint Monitoring                              |


---

### ⚙️ Cartographie des Contrôles de Sécurité avec les Cadres GRC

Nos implémentations techniques contribuent directement au respect des exigences de sécurité et de conformité, alignant nos opérations avec des cadres reconnus tels que l'ISO 27001 et le NIST Cybersecurity Framework (CSF).

| Implémentation Technique | Domaine GRC / Objectif de Conformité (ISO 27001 / NIST CSF) | Bénéfice GRC Spécifique |
|--------------------------|---------------------------------------------------------------|-------------------------|
| **MFA (Multi-Factor Authentication)** | **ISO 27001 A.9.2.1** (Enregistrement et désenregistrement des utilisateurs)<br>**NIST PR.AC-7** (Accès à privilèges) | Renforce l'authentification des identités, réduisant le risque d'accès non autorisé. |
| **Accès Conditionnel** | **ISO 27001 A.9.4.2** (Authentification des connexions)<br>**NIST PR.AC-5** (Gestion des accès) | Assure que seuls les utilisateurs et appareils conformes peuvent accéder aux ressources, en fonction du risque contextuel. |
| **LAPS (Local Admin Password Solution)** | **ISO 27001 A.9.2.3** (Gestion des droits d'accès à privilèges)<br>**NIST ID.AM-1** (Identités gérées) | Sécurise et gère les comptes administrateurs locaux, prévenant le mouvement latéral. |
| **Durcissement des Endpoints** | **ISO 27001 A.13.1.2** (Sécurité des services réseau)<br>**NIST PR.PT-3** (Sécurité des réseaux) | Réduit la surface d'attaque des appareils finaux, limitant les vulnérabilités exploitables. |
| **Sentinel (Logs & Règles)** | **ISO 27001 A.12.4.1** (Enregistrement des événements)<br>**NIST DE.CM-4** (Analyse des données) | Centralise la collecte des preuves et automatise la détection des anomalies pour l'audit et la réponse. |

## 📎 Supporting Assets

* **Scripts**: Fully documented PowerShell scripts for automation (e.g., O365 install, BitLocker, Defender, Join tasks)
* **Screenshots**: Captures from Entra ID, Intune, Defender, and local machines to validate implementation
* **GitHub Pages**: Access all project chapters on [CyberShield Enterprise GitHub](https://github.com/AliChoukatli/CyberShield-Enterprise)

---

## 🧾 License

Licensed under MIT.

> ⚠️ **Note:** This project is a simulation built for educational and portfolio purposes. It demonstrates real-world implementations in a fictional context.
