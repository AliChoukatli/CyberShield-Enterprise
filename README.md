# Azure & M365 Security Lab: Build Your Enterprise Cyber Defense 🛡️

![GitHub last commit](https://img.shields.io/github/last-commit/YOUR_GITHUB_USERNAME/YOUR_REPO_NAME?style=for-the-badge)
![GitHub stars](https://img.shields.io/github/stars/YOUR_GITHUB_USERNAME/YOUR_REPO_NAME?style=for-the-badge)
![GitHub forks](https://img.shields.io/github/forks/YOUR_GITHUB_USERNAME/YOUR_REPO_NAME?style=for-the-badge)

---

## 🎯 Project Overview

**Azure & M365 Security Lab: Build Your Enterprise Cyber Defense** is a comprehensive hands-on project demonstrating the deployment and hardening of a modern cybersecurity posture within a cloud-native and hybrid environment, primarily leveraging Microsoft security services. This project covers the full lifecycle of securing an enterprise, from foundational setup and identity management to endpoint protection, system hardening, and real-time threat detection.

It serves as a practical guide and a robust portfolio for individuals looking to gain and showcase experience in real-world cybersecurity implementations.

---

## 📝 Introduction

In today's evolving threat landscape, building a resilient and adaptive security infrastructure is paramount. This project meticulously details the steps to establish a strong defense-in-depth strategy, integrating various Microsoft security solutions to create a cohesive and monitored enterprise environment. From configuring robust Multi-Factor Authentication (MFA) and Conditional Access policies to deploying advanced endpoint protection and a cloud-native SIEM, this lab offers a holistic view of modern security operations.

---

## 📘 Table of Contents

Navigate through the chapters to explore detailed implementations and configurations:

* **[Chapter 1: 01_AD_Domain_Setup_&_Workstation_Join](01_AD_Domain_Setup_&_Workstation_Join/README.md)**
    * 1.1: Windows Server 2022 Setup: Active Directory & DHCP
    * 1.2: Deploy Windows 11 Workstations & Join to Active Directory
* **[Chapter 2: 02_AD_Integration_User_Management](02_AD_Integration_User_Management/README.md)**
    * 2.1: Creating and Managing Organizational Units (OUs)
    * 2.2: Managing Users and Security Groups in Active Directory
    * 2.3: File Share & NTFS Permissions Configuration
    * 2.4: RDP Access Control via Group Policy
    * 2.5: Deleting a User Account in Active Directory
    * *(Note: Based on your provided file list for Chapter 2, there are also `04_GPO_Baseline_Policies.md` that could be included if desired.)*
* **[Chapter 3: 03_IT_Helpdesk_&_Network_Troubleshooting](03_IT_Helpdesk_&_Network_Troubleshooting/README.md)**
    * 3.1: Deploying Microsoft 365 with ODT and PowerShell
    * 3.2: Secure RDP Access for IT Support
    * 3.3: Reset User Passwords & Unlock Accounts
    * 3.4: Remote Support with TeamViewer
    * 3.5: Network Troubleshooting & Connectivity Checks
* **[Chapter 4: 04_AzureAD_Sync_&_Endpoint_Security](04_AzureAD_Sync_&_Endpoint_Security/README.md)**
    * 4.1: Hybrid Azure AD Join – Enable Device Sync & Registration
    * 4.2: Microsoft Intune – Device Enrollment & Auto-Registration
    * 4.3: Microsoft Defender Antivirus Deployment via Intune
    * 4.4: Microsoft Defender for Endpoint (MDE) Onboarding Guide
    * 4.5: Microsoft Defender Firewall Configuration
    * 4.6: BitLocker Deployment via Microsoft Intune
* **[Chapter 5: 05_Zero_Trust_&_Security_Hardening](05_Zero_Trust_&_Security_Hardening/README.md)**
    * 5.1: Multi-Factor Authentication (MFA) Configuration Guide
    * 5.2: Conditional Access & Identity Protection Policies
    * 5.3: User Rights Assignment – Hardening Settings (Hybrid or Local AD)
    * 5.4: Security Controls Implementation
    * 5.5: Security Exposure Analysis, Remediation & Risk Management
    * 5.6: Local Administrator Password Management (LAPS) with Intune
    * 5.7: LAPS Integration with Microsoft Sentinel: Monitoring and Detection Guide
* **[Chapter 6: 06_Threat_Detection_&_Simulation](06_Threat_Detection_&_Simulation/README.md)**
    * 6.1: Microsoft Sentinel – Setup & Architecture
    * 6.2: Custom Analytics Rules (Microsoft Sentinel)
    * *(More chapters on Playbooks, Threat Hunting, Incident Management would go here if available)*

---

## ✨ Key Project Highlights & Technologies

This project demonstrates practical skills in:

* **Identity & Access Management (IAM):** Active Directory, DHCP, MFA, Conditional Access, LAPS, Role-Based Access Control (RBAC).
* **Endpoint Security:** Windows Server 2022, Windows 11, Device Hardening, BitLocker Encryption, Microsoft Defender for Endpoint.
* **Security Operations (SecOps):** Microsoft Sentinel deployment, Data Connectors, Kusto Query Language (KQL) for custom detection rules.
* **Governance, Risk, & Compliance (GRC):** Risk mitigation strategies, compliance mapping with ISO 27001 and NIST CSF.
* **Cloud Security:** Leveraging Azure and Microsoft 365 security services.
* **Tools Used:** Azure Active Directory (Microsoft Entra ID), Microsoft Intune, Microsoft Defender XDR (for Endpoint & Office 365), Microsoft Sentinel, Group Policy Objects (GPO), PowerShell.

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

Our technical implementations directly contribute to meeting security and compliance requirements, aligning our operations with recognized frameworks such as ISO 27001 and the NIST Cybersecurity Framework (CSF).

| Technical Implementation        | GRC Domain / Compliance Objective (ISO 27001 / NIST CSF)                                                                                 | Specific GRC Benefit                                                                    |
| :------------------------------ | :--------------------------------------------------------------------------------------------------------------------------------------- | :-------------------------------------------------------------------------------------- |
| **MFA (Multi-Factor Authentication)** | **ISO 27001 A.9.2.1** (User registration and de-registration)<br>**NIST PR.AC-7** (Privileged access)                                   | Strengthens identity authentication, reducing the risk of unauthorized access.            |
| **Conditional Access** | **ISO 27001 A.9.4.2** (Authentication for external connections)<br>**NIST PR.AC-5** (Access management)                                   | Ensures that only compliant users and devices can access resources, based on contextual risk. |
| **LAPS (Local Admin Password Solution)** | **ISO 27001 A.9.2.3** (Management of privileged access rights)<br>**NIST ID.AM-1** (Managed identities)                         | Secures and manages local administrator accounts, preventing lateral movement.           |
| **Endpoint Hardening** | **ISO 27001 A.13.1.2** (Network services security)<br>**NIST PR.PT-3** (Network security)                                                   | Reduces the attack surface of end-user devices, limiting exploitable vulnerabilities.     |
| **Sentinel (Logs & Rules)** | **ISO 27001 A.12.4.1** (Event logging)<br>**NIST DE.CM-4** (Data analysis)                                                              | Centralizes evidence collection and automates anomaly detection for auditing and response. |

---

## 🚀 Value for Aspiring IT/Cybersecurity Professionals

This project serves as an **invaluable asset** for individuals with limited or no prior IT experience looking to enter the cybersecurity field. It offers:

* **Concrete Practical Experience:** Unlike theoretical knowledge, this project showcases hands-on abilities with enterprise-grade tools.
* **Broad Skill Set:** It covers a wide array of cybersecurity domains, demonstrating a holistic understanding of modern security.
* **Problem-Solving & Documentation Skills:** The process of building and documenting this project highlights critical thinking, troubleshooting, and clear communication abilities.
* **Direct Job Market Relevance:** The technologies and concepts implemented are highly sought after in roles such as SOC Analyst, Security Administrator, IAM Specialist, and IT Support with a security focus.

This project acts as a powerful **technical portfolio**, distinguishing you significantly from other entry-level candidates by providing tangible proof of your skills and dedication.

---

## 🛠️ Prerequisites & Lab Setup

To explore or replicate this project, you will need:

* An Azure Subscription with appropriate permissions.
* A Microsoft 365 Tenant (or Azure AD tenant).
* Basic understanding of Windows operating systems and networking concepts.
* (Optional) Access to a lab environment for hands-on practice.

Detailed setup instructions for the lab environment are provided in **Chapter 1**.

---

## 🤝 How to Navigate & Contribute

Feel free to browse through the chapters in the table of contents. Each chapter's folder typically contains a dedicated `Documentation` section with detailed steps and screenshots.

