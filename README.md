# **🛡️ IT Support & Cybersecurity Project – Small Business Simulation (25 Users)**

This project simulates the implementation of a secure, cloud-based IT environment for a fictional small business with 25 employees. It follows modern best practices including the Zero Trust model, ISO/IEC 27001, and the NIST Cybersecurity Framework (CSF), using Microsoft 365, Azure AD (Entra ID), Intune, Microsoft Defender, and Sentinel.

## 📑 Index

1. [Introduction](introduction)
2. [Objectives](https://github.com/AliChoukatli/SecureIT-for-SMB/tree/main?tab=readme-ov-file#-objectives)
3. [Tools](https://github.com/AliChoukatli/SecureIT-for-SMB/tree/main?tab=readme-ov-file#-tools)
4. [How to Use This Project](https://github.com/AliChoukatli/SecureIT-for-SMB/tree/main?tab=readme-ov-file#-how-to-use-this-project)
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

Follow the day-by-day guide from Day 1 through Day 10 to build and secure your SMB environment step-by-step.

### Day 1 → Day 10 Learning Path
- [**Day 1**: Installation & Base Configuration](https://github.com/AliChoukatli/SecureIT-for-SMB/tree/main/Support_IT/Day1_Installation)
- [**Day 2**: Endpoint Security & Device Management](https://github.com/AliChoukatli/SecureIT-for-SMB/tree/main/Support_IT/Day2)
- [**Day 3**: Zero Trust (MFA, CA, BitLocker)](https://github.com/AliChoukatli/SecureIT-for-SMB/tree/main/Support_IT/Day3)
- [**Day 4**: AD User & Group Support](https://github.com/AliChoukatli/SecureIT-for-SMB/tree/main/Support_IT/Day4)
- [**Day 5**: Helpdesk & Network Troubleshooting](https://github.com/AliChoukatli/SecureIT-for-SMB/tree/main/Support_IT/Day5)
- [**Day 6**: Sentinel & Defender Integration](https://github.com/AliChoukatli/SecureIT-for-SMB/tree/main/Support_IT/Day6)
- [**Day 7**: Phishing Simulation](https://github.com/AliChoukatli/SecureIT-for-SMB/tree/main/Support_IT/Day7)
- [**Day 8**: Post-Attack Forensics](https://github.com/AliChoukatli/SecureIT-for-SMB/tree/main/Support_IT/Day8)
- [**Day 9**: ISO/NIST Compliance Mapping](https://github.com/AliChoukatli/SecureIT-for-SMB/tree/main/Support_IT/Day9)
- [**Day 10**: Cleanup & Final Documentation](https://github.com/AliChoukatli/SecureIT-for-SMB/tree/main/Support_IT/Day10)

---


## 📁 **Project Structure**
```
IT-Support-Cybersecurity-SMB/
│
├── 📄 README.md                      # Overview of the entire project
├── 📄 LICENSE                        # (optional) License type if sharing publicly
├── 📄 .gitignore                     # Files/folders ignored by Git
│
├── 📁 01_Installation_Config         # Windows Server installation, AD, static IP setup
│   ├── README.md
│   └── screenshots/
│
├── 📁 02_IT_Support                  # Helpdesk tasks: RDP, password reset, network tools
│   ├── README.md
│   └── scripts/
│
├── 📁 03_IAM_Intune_Join             # Azure AD, Intune, Hybrid Join, device management
│   ├── README.md
│   └── screenshots/
│
├── 📁 04_Zero_Trust_Security         # MFA, Conditional Access, BitLocker, security baselines
│   ├── README.md
│   └── scripts/
│
├── 📁 05_Sentinel_Alert_Triage       # Microsoft Sentinel alert handling, KQL, automation
│   ├── README.md
│   └── playbooks/
│
├── 📁 06_Phishing_Simulation         # Simulated phishing attack + Event Viewer & Defender logs
│   ├── README.md
│   └── captures_logs/
│
├── 📁 07_Forensics_Analysis          # Post-attack forensic analysis (Event IDs, attacker traces)
│   ├── README.md
│   └── evidence/
│
├── 📁 08_Compliance_ISO_NIST         # ISO 27001 / NIST CSF mapping, policies
│   ├── README.md
│   └── mappings/
│
├── 📁 09_Final_Documentation         # Final README, technical notes, conclusions
│   ├── README.md
│   └── export_pdf/
│
└── 📁 10_Screenshots_All             # All screenshots sorted by day for GitHub display
    ├── Day1/
    ├── Day2/
    └── ...
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
