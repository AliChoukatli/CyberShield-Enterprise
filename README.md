# 🔐 CyberShield Enterprise: Designing, Implementing, and Securing a Zero Trust IT Architecture

![Status](https://img.shields.io/badge/Status-Active-success?style=flat-square)
![PowerShell](https://img.shields.io/badge/Powershell-Scripts-blue?logo=powershell&style=flat-square)
![Windows Server](https://img.shields.io/badge/Windows_Server-2022-blueviolet?logo=windows&style=flat-square)
![Azure](https://img.shields.io/badge/Azure-Integrated-blue?logo=microsoft-azure&style=flat-square)
![Microsoft365](https://img.shields.io/badge/Microsoft_365-Security-orange?logo=microsoft&style=flat-square)
[![License: CC BY-NC-ND 4.0](https://img.shields.io/badge/License-CC--BY--NC--ND%204.0-lightgrey.svg)](https://creativecommons.org/licenses/by-nc-nd/4.0/)


## 🧭 Quick Navigation

- [🎯 Project Overview](#-project-overview)
- [🧱 Architecture](#-architecture-overview)
- [📘 Table of Contents](#-table-of-contents)
- [✨ Security Domains & Tools](#-security-domains--tools)
- [📈 Security Transformation: Before vs. After](#-security-transformation-before-vs-after)
- [✅ Compliance Mapping](#-compliance-mapping)
- [🛠️ Prerequisites & Lab Setup](#️-prerequisites--lab-setup)
- [🤝 How to Navigate](#-how-to-navigate)
- [⚠️ Licence](#%EF%B8%8F-licence)

---

## 🎯 Project Overview

**CyberShield Enterprise** is a comprehensive hands-on project simulating **the design**, **implementation**, and **securing of a modern hybrid IT infrastructure based on Zero Trust principles**.

*This project was developed independently, without prior IT experience or supervision*. It covers key security areas such as **Identity and Access Management (IAM)**, **Endpoint Hardening**, **Data Encryption**, **Privileged Access Management**, and **Advanced Threat Detection and Monitoring**, demonstrating practical skills aligned with industry standards like **ISO 27001** and the **NIST Cybersecurity Framework**. 

---

## 🧱 Architecture Overview

![Architecture](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/Screenshots/Architecture.jpg)

---

## 📘 Table of Contents

Navigate through the chapters to explore detailed implementations and configurations:

* **[Chapter 1: AD Domain Setup & Workstation Join](01_AD_Domain_Setup_&_Workstation_Join/README.md)**
    * 1.1: Windows Server 2022 Setup: Active Directory & DHCP
    * 1.2: Deploy Windows 11 Workstations & Join to Active Directory
* **[Chapter 2: AD Integration User Management](02_AD_Integration_User_Management/README.md)**
    * 2.1: Creating and Managing Organizational Units (OUs)
    * 2.2: Managing Users and Security Groups in Active Directory
    * 2.3: File Share & NTFS Permissions Configuration
    * 2.4: RDP Access Control via Group Policy
    * 2.5: Deleting a User Account in Active Directory
* **[Chapter 3: IT Helpdesk & Network Troubleshooting](03_IT_Helpdesk_&_Network_Troubleshooting/README.md)**
    * 3.1: Deploying Microsoft 365 with ODT and PowerShell
    * 3.2: Secure RDP Access for IT Support
    * 3.3: Reset User Passwords & Unlock Accounts
    * 3.4: Remote Support with TeamViewer
    * 3.5: Network Troubleshooting & Connectivity Checks
* **[Chapter 4: AzureAD Sync & Endpoint Security](04_AzureAD_Sync_&_Endpoint_Security/README.md)**
    * 4.1: Hybrid Azure AD Join – Enable Device Sync & Registration
    * 4.2: Microsoft Intune – Device Enrollment & Auto-Registration
    * 4.3: Microsoft Defender Antivirus Deployment via Intune
    * 4.4: Microsoft Defender for Endpoint (MDE) Onboarding Guide
    * 4.5: Microsoft Defender Firewall Configuration
    * 4.6: BitLocker Deployment via Microsoft Intune
* **[Chapter 5: Zero Trust & Security Hardening](05_Zero_Trust_&_Security_Hardening/README.md)**
    * 5.1: Multi-Factor Authentication (MFA) Configuration Guide
    * 5.2: Conditional Access & Identity Protection Policies
    * 5.3: User Rights Assignment – Hardening Settings (Hybrid or Local AD)
    * 5.4: Security Controls Implementation
    * 5.5: Security Exposure Analysis, Remediation & Risk Management
    * 5.6: Local Administrator Password Management (LAPS) with Intune
    * 5.7: LAPS Integration with Microsoft Sentinel: Monitoring and Detection Guide
* **[Chapter 6:Threat Detection & Simulation](06_Threat_Detection_&_Simulation/README.md)**
    * 6.1: Microsoft Sentinel – Setup 
    * 6.2: Custom Analytics Rules (Microsoft Sentinel)
    * 6.3 : Playbooks (Soon)

---

## ✨ Security Domains & Tools

| Domain                          | Description & Tools Used                                                                                                                                   |
|---------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **IAM & Identity Protection**   | Active Directory, Azure AD (Microsoft Entra ID), Conditional Access, Multi-Factor Authentication (MFA), LAPS, Role-Based Access Control (RBAC).           |
| **Endpoint Security**           | Windows 11 & Windows Server 2022 hardening with Intune, BitLocker encryption, Microsoft Defender for Endpoint, Group Policy Objects (GPO).                |
| **Security Operations (SecOps)**| Microsoft Sentinel setup, custom detection with KQL, integration of data connectors for centralized security monitoring and alerting.                     |
| **Cloud Security & Compliance**| Zero Trust architecture, Intune policy enforcement, alignment with ISO 27001 and NIST Cybersecurity Framework (CSF).                                       |
| **Automation & Scripts**        | PowerShell, KQL                                                                                                                                           |

---

## 📈 Security Transformation: Before vs. After

This project significantly enhances an organization's security posture.

| Security Element              | Before Implementation      | After Implementation                                   |
| :---------------------------- | :------------------------- | :----------------------------------------------------- |
| Multi-Factor Authentication   | ❌ Not enabled             | ✅ Windows Hello, Authenticator, FIDO2, TAP             |
| Endpoint Compliance           | ❌ Uncontrolled            | ✅ Intune + Defender Baselines                         |
| Device Encryption (BitLocker) | ❌ Disabled                | ✅ Enforced via Intune                                  |
| Firewall Configuration        | ❌ Default rules           | ✅ Custom rules via GPO & Intune                        |
| Privileged Access Control     | ❌ Admin used daily        | ✅ User accounts + Role-based Admins                   |
| Defender for Endpoint         | ❌ Not deployed            | ✅ Cloud or GPO onboarding + central console           |
| Exposure Level                | ⚠️ High (pre-attack)       | ✅ Mitigated via Intune & GPO & PowerShell             |

---

## ✅ Compliance Mapping

Each security control in this project was designed not only to enhance protection but also to meet compliance objectives aligned with ISO 27001 and NIST CSF, making the environment both resilient and audit-ready.

| Technical Implementation                 | GRC Domain / Compliance Objective (ISO 27001 / NIST CSF)                                                          | Specific GRC Benefit                                                                 |
|----------------------------------------|------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------|
| **MFA (Multi-Factor Authentication)**    | **ISO 27001 A.9.2.1** (User registration and de-registration)<br>**NIST PR.AC-7** (Privileged access)    | Strengthens identity authentication, reducing the risk of unauthorized access.                |
| **Conditional Access**                   | **ISO 27001 A.9.4.2** (Authentication for external connections)<br>**NIST PR.AC-5** (Access management)  | Ensures that only compliant users and devices can access resources, based on contextual risk. |
| **LAPS (Local Admin Password Solution)** | **ISO 27001 A.9.2.3** (Management of privileged access rights)<br>**NIST ID.AM-1** (Managed identities)  | Secures and manages local administrator accounts, preventing lateral movement.                |
| **Endpoint Hardening**                   | **ISO 27001 A.13.1.2** (Network services security)<br>**NIST PR.PT-3** (Network security)                | Reduces the attack surface of end-user devices, limiting exploitable vulnerabilities.         |
| **Sentinel (Logs & Rules)**              | **ISO 27001 A.12.4.1** (Event logging)<br>**NIST DE.CM-4** (Data analysis)                               | Centralizes evidence collection and automates anomaly detection for auditing and response.    |

---


## 🛠️ Prerequisites & Lab Setup

To explore or replicate this project, you will need:

* An Azure Subscription with appropriate permissions.
* A Microsoft 365 Tenant.

Detailed setup instructions for the lab environment are provided in **Chapter 1**.

---

## 🔍 How to Navigate

Each chapter includes a Documentation folder containing its subsections (e.g., 1.1, 1.2, etc.), with step-by-step instructions and screenshots for each configuration.

## ⚠️ Licence

- **Author : Ali Choukatli**
- **Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International (CC BY-NC-ND 4.0)**

This work is licensed under the [Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License](https://creativecommons.org/licenses/by-nc-nd/4.0/)  

- You **may share this project (e.g. on GitHub, LinkedIn) with proper credit**.  
- You **may not use it for commercial purposes** or **modify/reuse parts of it without explicit permission from the author**.
