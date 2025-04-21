# Incident Response Simulation: Phishing Attack

## Use Case
A user opens a phishing email → endpoint is compromised → alert is triggered

## Workflow

1. **Defender detects a malicious file from phishing**
2. **Sentinel logs the alert and triggers high severity**
3. **Triage done using KQL and log review**
4. **Forensic evidence collected:**
   - **Windows Event Viewer logs**:
     - IDs: 4104, 4624, 4688
   - **Browser/USB artifacts**:
     - (noted only)
5. **User account disabled and isolated**
6. **Root cause summary noted in this file**
