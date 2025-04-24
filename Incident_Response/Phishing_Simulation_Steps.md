## 🧪 Incident Response Simulation

**Use Case:** A user opens a phishing email → endpoint is compromised → alert is triggered

**Workflow:**

1. **Detection**  
   - Defender for Endpoint flags a suspicious file or behavior  
   - Sentinel ingests the alert and assigns a high severity tag  

2. **Notification & Triage**  
   - SOC team receives the high-severity alert  
   - Run KQL query to gather context:  
     ```kql
     SecurityAlert
     | where Severity == "High" and TimeGenerated > ago(7d)
     ```  

3. **Analysis**  
   - Review Windows Event Viewer logs (Event IDs: 4104, 4624, 4688)  
   - Examine browser history and USB artifacts with forensic tools  

4. **Containment & Eradication**  
   - Disable the affected user account in Azure AD and on-prem AD  
   - Isolate the compromised endpoint via Defender for Endpoint  

5. **Recovery**  
   - Reset user credentials and restore access  
   - Reimage or clean the endpoint, ensure BitLocker + security baselines are applied  

6. **Lessons Learned & Documentation**  
   - Document root cause and timeline in `Incident_Response/Phishing_Simulation_Steps.md`  
   - Update playbooks and policies to prevent similar incidents  

📸 **Screenshots to capture:**  
- Defender alert details  
- Sentinel incident overview  
- Event Viewer logs (IDs 4104, 4624, 4688)  
- User account disabled in AD  
