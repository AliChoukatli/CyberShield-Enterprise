# 🧪 Phishing Simulation – Incident Response Workflow

## 🎯 Use Case
A user opens a phishing email → endpoint is compromised → alert is triggered

---

## 🔁 Workflow Steps

### 1. **Detection**
- Microsoft Defender detects a malicious file attached to a phishing email.
- Initial alert raised on the endpoint.

### 2. **Alerting**
- Microsoft Sentinel logs the alert and categorizes it as high severity.
- Alert ID and timestamp documented.

### 3. **Triage**
- Security analyst reviews:
  - Microsoft Sentinel incident
  - KQL query results for suspicious login and process activity
  - Timeline correlation using logs from Microsoft Defender and Entra ID

### 4. **Forensic Collection**
- Windows Event Viewer logs:
  - `4104`: Suspicious PowerShell execution
  - `4624`: User logins
  - `4688`: New process creations
- Manual notes on:
  - Browser history (user clicked malicious link)
  - USB activity (no exfiltration detected)

### 5. **Containment**
- User account disabled in Entra ID.
- Device isolated using Microsoft Defender for Endpoint.
- All sessions terminated.

### 6. **Root Cause Summary**
- The user clicked on a phishing link that downloaded a malicious file.
- Malicious PowerShell script attempted to create a reverse shell.
- No lateral movement detected.
- Account was compromised but contained before data exfiltration.

---

📁 *This summary is part of the full project documentation located in the main repository.*
