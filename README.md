# **🛡️ IT Support & Cybersecurity Project – Small Business Simulation (25 Users)**

This project simulates the implementation of a secure, cloud-based IT environment for a fictional small business with 25 employees. It follows modern best practices including the Zero Trust model, ISO/IEC 27001, and the NIST Cybersecurity Framework (CSF), using Microsoft 365, Azure AD (Entra ID), Intune, Microsoft Defender, and Sentinel.

## 📑 Index

1. [Introduction](introduction)
2. [Objectives](https://github.com/AliChoukatli/SecureIT-for-SMB/tree/main?tab=readme-ov-file#-objectives)
3. [Tools](https://github.com/AliChoukatli/SecureIT-for-SMB/tree/main?tab=readme-ov-file#-tools)
4. [How to Use This Project](https://github.com/AliChoukatli/SecureIT-for-SMB/tree/main?tab=readme-ov-file#-how-to-use-this-project)
   - [Option A – Step-by-Step Learning Plan (10 Days)](https://github.com/AliChoukatli/SecureIT-for-SMB/blob/main/Guideline/Option_A.md)
   - [Option B – Explore Individual Modules](https://github.com/AliChoukatli/SecureIT-for-SMB/blob/main/Guideline/Option_B.md)
5. [Project Structure](https://github.com/AliChoukatli/SecureIT-for-SMB/blob/main/README.md#-project-structure)
7. [Zero Trust Implementation](https://github.com/AliChoukatli/SecureIT-for-SMB/tree/main?tab=readme-ov-file#-zero-trust-implementation-integrated)
8. [Compliance Mapping (Summary)](https://github.com/AliChoukatli/SecureIT-for-SMB/tree/main?tab=readme-ov-file#-compliance-mapping-summary)
9. [Incident Response Simulation](https://github.com/AliChoukatli/SecureIT-for-SMB/tree/main?tab=readme-ov-file#-incident-response-simulation)
10. [PowerShell Tools (Support IT)](https://github.com/AliChoukatli/SecureIT-for-SMB/tree/main?tab=readme-ov-file#%EF%B8%8F-powershell-tools-support-it)
11. [Screenshots Summary](https://github.com/AliChoukatli/SecureIT-for-SMB/tree/main?tab=readme-ov-file#%EF%B8%8F-screenshots-summary)
12. [License](https://github.com/AliChoukatli/SecureIT-for-SMB/tree/main?tab=readme-ov-file#%EF%B8%8F-license)

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

This project simulates the implementation of a full Zero Trust architecture and IT support framework for a small business using Microsoft 365, Azure AD, Intune, Autopilot,Microsoft Defender, and Sentinel.
You can use the project in two ways:

- [ Option A – Step-by-Step Learning Plan (10 Days)](https://github.com/AliChoukatli/SecureIT-for-SMB/blob/main/Guideline/Option_A.md)

- [ Option B – Explore Individual Modules](https://github.com/AliChoukatli/SecureIT-for-SMB/blob/main/Guideline/Option_B.md)


## 📁 **Project Structure**
```
/Secure_IT_for_SMB/                                 <-- Main project directory
│
├── README.md                                       <-- Project documentation
├── LICENSE                                         <-- Project license information
│
├── ZeroTrust/                                      <-- Zero Trust security model
│   └── Zero_Trust_Implementation_Guide.pdf         <-- Zero Trust implementation guide
│
├── IT_Operations/                                  <-- Technical support tasks and scripts
│   │
│   ├── PowerShell_Scripts/                         <-- PowerShell scripts for common tasks
│   │   ├── DeployOffice365.ps1
│   │   ├── Reset-UserPassword.ps1
│   │   └── Get-SecurityStatus.ps1
│   │
│   └── Screenshots/                                <-- Screenshots for IT support activities
│       ├── Group_Management.png                    <-- Adding users to groups in Active Directory
│       ├── Password_Reset_AD.png                   <-- Resetting a user's password in AD
│       ├── AD_Permissions_Management.png           <-- Managing permissions in Active Directory
│       ├── Remote_Support_TeamViewer.png           <-- Remote support session using TeamViewer
│       ├── Remote_Desktop_Session.png              <-- Remote Desktop session with a user
│       ├── Device_Manager_Troubleshooting.png      <-- Troubleshooting via Device Manager
│       ├── Windows_Network_Troubleshooter.png      <-- Windows network troubleshooting tool
│       ├── CMD_Ping_Test.png                       <-- Network ping test
│       └── CMD_Ipconfig_Results.png                <-- IP configuration (ipconfig) output
│
├── Cybersecurity/                                  <-- Security monitoring and response
│   │
│   ├── Sentinel_Alerts_Triage/                     <-- Microsoft Sentinel alert handling
│   │   ├── KQL_queries.txt                         <-- KQL queries used for triage
│   │   └── Playbook_AutoResponse.json              <-- Sentinel automated response playbook
│   │
│   └── Screenshots/                                <-- Security-related screenshots
│       ├── Sentinel_Alert.png                      <-- Detected alert in Sentinel
│       └── Defender_Investigation.png              <-- Investigation in Microsoft Defender
│
├── Incident_Response/                              <-- Incident response processes
│   │
│   ├── Phishing_Simulation_Steps.md                <-- Steps for phishing simulation
│   │
│   └── Screenshots/                                <-- Screenshots from the simulation
│       ├── Phishing_Email.png                      <-- Example phishing email
│       └── EventViewer_Logs.png                    <-- Relevant Windows Event Viewer logs
│
├── Forensics_Analysis/                             <-- Forensic investigation evidence
│   │
│   └── Screenshots/                                <-- Screenshots from post-incident analysis
│       ├── Logon_Event_4624.png                    <-- Suspicious logon (Event ID 4624)
│       └── PowerShell_4104.png                     <-- Malicious PowerShell script (Event ID 4104)
│ 
├── Compliance/                                     <-- Compliance and standards
│   │
│   └── Mapping_ISO_NIST.xlsx                       <-- ISO/NIST mapping spreadsheet
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



## 🖼️ **Screenshots Summary**

📁 *Support_IT/Screenshots/*

- [AD_User_Creation.png](#ad-user-creationpng) – Creating a user in Active Directory  
- [Group_Management.png](#group-managementpng) – Managing user groups in Active Directory  
- [Password_Reset_AD.png](#password-reset-adpng) – Resetting a user password in AD  
- [AD_Permissions_Management.png](#ad-permissions-managementpng) – Managing permissions in Active Directory  
- [Remote_Support_TeamViewer.png](#remote-support-teamviewerpng) – Remote support session using TeamViewer  
- [Remote_Desktop_Session.png](#remote-desktop-sessionpng) – Remote Desktop session with a user  
- [Device_Manager_Troubleshooting.png](#device-manager-troubleshootingpng) – Troubleshooting via Device Manager  
- [Windows_Network_Troubleshooter.png](#windows-network-troubleshooterpng) – Windows network troubleshooting tool  
- [CMD_Ping_Test.png](#cmd-ping-testpng) – Network ping test  
- [CMD_Ipconfig_Results.png](#cmd-ipconfig-resultspng) – IP configuration (ipconfig) output  

📁 *Cybersecurity/Screenshots/*

- [Sentinel_Alert.png](#sentinel-alertpng) – Alert detection via Microsoft Sentinel  
- [Defender_Investigation.png](#defender-investigationpng) – Investigation view in Microsoft Defender  

📁 *Incident_Response/Screenshots/*

- [Phishing_Email.png](#phishing-emailpng) – Simulated phishing email  
- [EventViewer_Logs.png](#eventviewer-logspng) – Event Viewer logs related to the incident  


📁 *Forensics_Analysis/Screenshots/*

- [Logon_Event_4624.png](#logon-event-4624png) – Suspicious logon event  
- [PowerShell_4104.png](#powershell-4104png) – Malicious PowerShell script execution (Event ID 4104
---


## 🗂️ License

MIT License
