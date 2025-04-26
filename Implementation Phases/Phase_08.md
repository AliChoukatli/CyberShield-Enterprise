# Phase 8: Forensics Post-Attack

## 🧰 Prerequisites
- Familiarity with Windows Event Logs.
- Access to Event Viewer and Defender.

## Overview
This day focuses on analyzing logs post-attack to understand how an attack was carried out and how to prevent future incidents.

### **Step 1: Analyze Event ID 4624 (Logon Event)**
- Open **Event Viewer** and search for Event ID 4624 (logon events).
  
    - 📸 Screenshot: Event ID 4624 log showing user login activity.

### **Step 2: Analyze Event ID 4104 (PowerShell Activity)**
- Check for Event ID 4104 to review PowerShell script execution during the attack.
  
    - 📸 Screenshot: Event ID 4104 log showing suspicious PowerShell script execution.

### **Step 3: Investigate Other Logs**
- Review other relevant events such as failed login attempts (Event ID 529), and administrative privilege escalations.
  
    - 📸 Screenshot: Other suspicious logs showing failed login attempts.

## Pro Tips:
- Use KQL (Kusto Query Language) in Sentinel to query logs more effectively.
- Always correlate logs from different sources (e.g., Defender, Event Viewer).

