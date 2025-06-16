# 📊 02 - Custom Analytics Rules (Microsoft Sentinel)

Microsoft Sentinel allows the creation of **custom analytics rules** to detect threats, anomalous behavior, or compliance violations using **Kusto Query Language (KQL)**. This section presents examples of custom rules you can use and adapt for your environment.

## 🛠️ Detect Multiple Failed Logins Followed by Success

**📌 Use Case**: Detect brute force or password spraying attacks where a user fails multiple sign-ins and then succeeds.

### 🔍 Description

This rule detects accounts with **multiple failed sign-in attempts followed by a successful login** in a short time window.

### ✅ Deployment Method

1. Go to **Microsoft Sentinel → Analytics**
2. Click on **+ Create → Scheduled query rule**

### ⚙️ Set Rule Setting

| Setting                  | Value                                                                            |
|--------------------------|----------------------------------------------------------------------------------|
| **Rule Name**            | Multiple Failed Logins then Success                                              |
| **MITRE ATT&CK**         | Credential Access(Brute Force (T1110)), Initial Access( Valid Accounts (T1078) ) |
| **Severity**             | Medium                                                                           |
 
4. Paste the KQL in the **Set rule logic** step

#### 📄 KQL Query

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
6. Configure rule settings as described above



### 🧩 Alert enhancement 

1. Entity Mapping

Allows Microsoft Sentinel to recognize and classify entities from the query results.

| Entity Type | Identifier 1        | Identifier 2     | Identifier 3 (optional) |
|-------------|---------------------|------------------|--------------------------|
| **Account** | UserPrincipalName   | DisplayName      |                          |

> Select **Account** as the entity type. Use `UserPrincipalName` as the primary identifier, and `DisplayName` as a secondary label for improved alert context.


---

2. Alert Details

Customize the alert message using parameters from your query results.

- **Alert Name Format**  
  `Brute Force Detected - {{UserPrincipalName}}`

- **Alert Description Format**  
  `The account {{UserPrincipalName}} had {{FailedCount}} failed login attempts followed by a successful login at {{SuccessTime}}.`

> If a parameter has no value, Microsoft Sentinel will revert to the default alert title and description configured on the first screen.



---

3. 🕒 Query Scheduling

| Setting                   | Value          |
|---------------------------|----------------|
| Run query every           | 5 minutes      |
| Lookup data from the last | 5 minutes      |
| First run start time      | 6/16/2025, 12:00 PM |

> This means the rule executes every 5 minutes, analyzing the past 5 minutes of log data.

---

4. 🚨 Alert Threshold

- **Generate alert when number of query results**: `> 0`

---

5. 📦 Event Grouping

Options for how Sentinel groups query results into alerts:

- ✅ **Trigger an alert for each event**
- ❌ **Trigger a single alert when the query returns results**

> Recommended: "Trigger an alert for each event" unless the query returns a high number of events (above 150), which may cause Sentinel to summarize the last alert.

---

6. 📴 Suppression

- **Stop running query after alert is generated**: ❌ *(Unchecked)*

---


### ⚙️ Incident Settings

When an analytics rule triggers alerts, Microsoft Sentinel can automatically group these alerts into incidents. This helps security teams manage and investigate related alerts more efficiently.

1. Alert grouping → Enabled
   -5 min 
→ Choose **“Group alerts into a single incident if all entities match”**  
 - Re-open closed matching incidents → Disabled


---



### 🧪 Results Simulation

- After rule creation, use **“Test with current data”** to validate against live workspace data.
- A timeline chart displays the last 50 rule evaluations with clickable data points for inspection.

---

🔙 Back to: [Custom Rule – Multiple Failed Logins then Success](#🛠️-custom-rule-detect-multiple-failed-logins-followed-by-success)

7. Enable the rule and monitor from **Incidents** or **Logs**

--- 



---




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
