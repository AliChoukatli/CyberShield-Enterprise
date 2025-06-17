# 📘 Incident Response Playbooks (LAB)

This document presents simulated incident response playbooks built for a personal cybersecurity lab project. Each playbook shows how to detect, investigate, contain, and remediate different security incidents using realistic and executable steps in a non-production environment.

---

## 🧩 Table of Contents

1. [💥 Malware Infection](#-malware-infection)
2. [🔐 Unauthorized Access](#-unauthorized-access)
3. [📤 Data Exfiltration](#-data-exfiltration)
4. [🚫 Phishing Simulation](#-phishing-simulation)
5. [🧪 Ransomware Simulation](#-ransomware-simulation)
6. [🧼 Post-Incident Steps](#-post-incident-steps)

---

## 💥 Malware Infection

### 🎯 Objective:
Simulate malware detection and respond using Microsoft Defender and local tools.

### 🛠️ Steps in Lab:
- Trigger a Defender alert using the **EICAR test file**
- Check alert in Microsoft Defender portal (if configured)
- Manually isolate the test machine (or describe the command/script)
- Analyze logs (Event Viewer, Defender logs)
- Remove the file and perform a full antivirus scan
- Document the investigation (screenshots, hash, detection path)

---

## 🔐 Unauthorized Access

### 🎯 Objective:
Detect and handle unauthorized login behavior (e.g., impossible travel) using Sentinel.

### 🛠️ Steps in Lab:
- Simulate multiple sign-ins from different IPs or locations
- Use **SigninLogs** in Sentinel to trigger “Impossible Travel” rule
- Investigate sign-in details (device, location, timestamp)
- Reset the password of the test user account
- Enforce MFA (or document the setting in Azure/Entra)
- Include screenshots from Sentinel and your remediation steps

---

## 📤 Data Exfiltration

### 🎯 Objective:
Simulate an attempt to exfiltrate sensitive files.

### 🛠️ Steps in Lab:
- Create a fake confidential file
- Simulate exfiltration via OneDrive upload or PowerShell script
- Monitor file access events, PowerShell logs, or browser history
- Document upload behavior and script used
- Remove the file and block external uploads (simulate)
- Add logs and screenshots to your repo

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

## 🧪 Ransomware Simulation

### 🎯 Objective:
Demonstrate a basic ransomware scenario and how to respond.

### 🛠️ Steps in Lab:
- Use a **safe ransomware simulator** (e.g., rename files with .locked extension)
- Trigger a Defender alert (if possible)
- Manually isolate the system (network disconnection or VM pause)
- Simulate recovery from backup or file restoration
- Document the extension used, affected files, alert details
- Share screenshots and cleanup steps

---

## 🧼 Post-Incident Steps

After each simulation:

- Write a short summary of actions taken
- Include key findings and challenges
- Capture screenshots of alerts, logs, commands used
- List improvements (e.g., update Defender policy or Sentinel rule)
- Mark the playbook as “complete” or “needs review”

---



**👤 Author:** Ali Choukatli – CyberShield  
**📅 Last Updated:** June 2025
