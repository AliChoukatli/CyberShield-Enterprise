# 📘 Incident Response Playbooks (Soon)

This document presents simulated incident response playbooks built for a personal cybersecurity lab project. Each playbook shows how to detect, investigate, contain, and remediate different security incidents using realistic and executable steps in a non-production environment.

---

## 🧩 Table of Contents

1. [💥 Malware Infection](#-malware-infection)
2. [🚫 Phishing Simulation](#-phishing-simulation)
3. [🔐 Unauthorized Access](#-unauthorized-access)
4. [📤 Data Exfiltration](#-data-exfiltration) 
5. [🧼 Post-Incident Steps](#-post-incident-steps)


---

## 💥 Malware Infection Response

### 🎯 Objective:
Simulate malware detection and respond using Microsoft Defender and local tools.

## 🎯 Objective

- Trigger and analyze a malware detection scenario.
- Practice isolation, investigation, and remediation steps.
- Use built-in Windows Defender and PowerShell tools.

## 🧪 Test Setup

- **Test file to use**: EICAR Standard Antivirus Test File (harmless)
- **Test device**: Windows 11 Pro (lab VM)
- **Security tool**: Microsoft Defender Antivirus (real-time protection ON)

## 🚨 Simulation Steps

### 1. Generate the EICAR Test File

Open Notepad and paste the following string:

```yaml
X5O!P%@AP[4\PZX54(P^)7CC)7}$EICAR-STANDARD-ANTIVIRUS-TEST-FILE!$H+H*
```

Save the file as `eicar.com` (you may need to allow file extension changes).

➡️ **Expected Result**: Microsoft Defender will immediately detect and quarantine the file.

---

### 2. Review Alert in Microsoft Defender

- Open **Windows Security > Virus & threat protection > Protection history**
- Locate the alert:


Threat detected: Virus: EICAR-Test-File
Status: Quarantined
Action: No action needed


➡️ Capture (Soon).

---

### 3. Isolate the Machine (Optional in Lab)

In production, you would isolate the endpoint via MDE or network-level.

In a lab, simulate isolation by:
- Disconnecting the VM from the network
- Or using this PowerShell command:

```powershell
Disable-NetAdapter -Name "Ethernet" -Confirm:$false
```
4. Investigate the Detection
Review Windows Defender logs:

```powershell
Get-MpThreatDetection
```

Also check Event Viewer:

Applications and Services Logs > Microsoft > Windows > Windows Defender > Operational

Look for event ID 1116 (threat detected)

➡️ Document:

- File path
- Detection name
- Threat severity
- Timestamp
- Hash (use PowerShell to get hash if file still exists)

5. Perform Antivirus Scan
Run a full scan:

```powershell
Start-MpScan -ScanType FullScan
```
➡️ Wait for scan completion. Save logs if available.

6. Clean-Up & Restore Connectivity
Confirm that the test file is quarantined or deleted

Re-enable the network adapter:

```powershell
Enable-NetAdapter -Name "Ethernet"
```

---

## 🚫 Phishing Simulation

### 🎯 Objective:
Respond to a simulated phishing email in a safe lab setup.

### 🛠️ Steps in Lab:
- Craft a fake phishing email in HTML (locally or via Outlook test account)
- Analyze email headers and link behavior
- Simulate reporting (e.g., using Outlook “Report Message” or manual review)
- Investigate the URL and possible user interaction
- Document remediation: deletion, training message, awareness follow-up
- Include screenshots of email, header, analysis tools

---



---



**👤 Author:** Ali Choukatli  
**📅 Last Updated:** October 2025
