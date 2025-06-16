# 📊 02 - Custom Analytics Rules (Microsoft Sentinel)

Microsoft Sentinel allows the creation of **custom analytics rules** to detect threats, anomalous behavior, or compliance violations using **Kusto Query Language (KQL)**. This section presents examples of custom rules you can use and adapt for your environment.

---

## 🛠️ Custom Rule: Detect Multiple Failed Logins Followed by Success

**📌 Use Case**: Detect brute force or password spraying attacks where a user fails multiple sign-ins and then succeeds.

### 🔍 Description

This rule detects accounts with **multiple failed sign-in attempts followed by a successful login** in a short time window.

---

### ✅ Deployment Method

1. Go to **Microsoft Sentinel → Analytics**
2. Click on **+ Create → Scheduled query rule**

### ⚙️ Rule Settings

| Setting                  | Value                                                                            |
|--------------------------|----------------------------------------------------------------------------------|
| **Rule Name**            | Multiple Failed Logins then Success                                              |
| **MITRE ATT&CK**         | Credential Access(Brute Force (T1110)), Initial Access( Valid Accounts (T1078) ) |
| **Severity**             | Medium                                                                           |
 
4. Paste the KQL in the **Set rule logic** step
5. Configure rule settings as described above
6. Enable the rule and monitor from **Incidents** or **Logs**

--- 


| **Alert Suppression**    | Off                                  |
| **Custom Event Grouping**| Enabled                              |
| **Entity Mapping**       | User → UserPrincipalName             |
| **Alert Frequency**      | Every 5 minutes                      |

---

### 📄 KQL Query

```kusto
let timeRange = 1h;
let failedThreshold = 5;
SigninLogs
| where TimeGenerated > ago(timeRange)
| where ResultType == 50074 or ResultType == 50076 or ResultType == 50053 // Failed login codes
| summarize FailedCount = count() by UserPrincipalName, bin(TimeGenerated, 10m)
| where FailedCount >= failedThreshold
| join kind=inner (
    SigninLogs
    | where TimeGenerated > ago(timeRange)
    | where ResultType == 0 // Successful login
    | project SuccessTime = TimeGenerated, UserPrincipalName
) on UserPrincipalName
| where SuccessTime > TimeGenerated
| project UserPrincipalName, FailedCount, TimeGenerated, SuccessTime
```


---

### 📌 Notes

- You can adjust `failedThreshold` or `timeRange` to make the rule more or less sensitive.
- Consider suppressing alerts for known automation accounts or whitelisted users.
- Always test custom rules in a **non-production environment** before enabling alerts.

---



---

## 📂 Other Examples

- 🔎 Unusual Location Sign-in  
- 📥 Impossible Travel Detection  
- 🐚 PowerShell Execution from Office Macro  

*(à documenter dans les futurs fichiers)*
