# 📊 02 - Custom Analytics Rules (Microsoft Sentinel)

Microsoft Sentinel allows the creation of **custom analytics rules** to detect threats, anomalous behavior, or compliance violations using **Kusto Query Language (KQL)**. This section presents examples of custom rules you can use and adapt for your environment.

## 🎯 Detect Multiple Failed Logins Followed by Success

**📌 Use Case**: Detect brute force or password spraying attacks where a user fails multiple sign-ins and then succeeds.

**📌 Description** : This rule detects accounts with **multiple failed sign-in attempts followed by a successful login** in a short time window.

### ✅ Deployment Method

1. Go to **Microsoft Sentinel → Analytics**
2. Click on **+ Create → Scheduled query rule**

#### ⚙️ 1. Set Rule Setting

| Setting                  | Value                                                                            |
|--------------------------|----------------------------------------------------------------------------------|
| **Rule Name**            | Multiple Failed Logins then Success                                              |
| **MITRE ATT&CK**         | Credential Access `Brute Force T1110`, Initial Access `T1078 - Valid Accounts`   |
| **Severity**             | Medium                                                                           |
 
3. Paste the KQL in the **Set rule logic** step

#### 📄 2. KQL Query

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

#### 🧩 3. Alert enhancement 
3.1 - Entity Mapping

Allows Microsoft Sentinel to recognize and classify entities from the query results.

| Entity Type | Identifier 1 | Identifier 2        |
|-------------|--------------|---------------------|
| Account     | Name         | UserPrincipalName   |

3.2 - Alert Details

- **Alert Name Format**  
  `Brute Force Detected - {{UserPrincipalName}}`

- **Alert Description Format**  
  `The account {{UserPrincipalName}} had {{FailedCount}} failed login attempts followed by a successful login at {{SuccessTime}}.`



#### 🕒 4. Query Scheduling

| Setting                   | Value          |
|---------------------------|----------------|
| Run query every           | 5 minutes      |
| Lookup data from the last | 60 minutes      |
| First run start time      | 6/16/2025, 12:00 PM |

> This means the rule executes every 5 minutes, analyzing the past 5 minutes of log data.

#### 🚨 5. Alert Threshold : **Generate alert when number of query results**: `> 1`

#### 📦 6.  Event Grouping : ✅ **Trigger an alert for each event*

#### 📴 7. Suppression : ❌

![Failed_Login_Rule_Rev](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/06_Threat_Detection_%26_Simulation/Screenshots/Failed_Login_Rule_Rev.png)


### ⚙️ Incident Settings

When an analytics rule triggers alerts, Microsoft Sentinel can automatically group these alerts into incidents. This helps security teams manage and investigate related alerts more efficiently.

1. Alert grouping → Enabled
   -5 min 
2. Choose **“Group alerts into a single incident if all entities match”**  
3. Re-open closed matching incidents → Disabled

![Failed_Login_Rule_Rev2](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/06_Threat_Detection_%26_Simulation/Screenshots/Failed_Login_Rule_Rev2.png)


### 🧪 Results Simulation

- After rule creation, Go back to **Edit the rule** and then under **Rule Query** Select **“View query results”** to validate against live workspace data.

---

## 🎯 Unusual Location Sign-in

**📌 Use Case** : Detects when a user signs in successfully from geographic locations that deviate from their usual login patterns. This may indicate potential account compromise or unauthorized access attempts using stolen credentials.

**📌 Description** : This rule flags users signing in from unusual geographic locations, which may indicate suspicious activity or credential compromise. 

**✅ Deployment Method**

1. Go to **Microsoft Sentinel → Analytics**
2. Click on **+ Create → Scheduled query rule**

| Setting                  | Value                                                                            |
|--------------------------|----------------------------------------------------------------------------------|
| **Rule Name**            | Unusual Location Sign-in                                             |
| **MITRE ATT&CK**         | Initial Access `T1078 - Valid Accounts`                               |
| **Severity**             | Medium                                                                           |

3. Paste the KQL in the **Set rule logic** step

#### 📄 2. KQL Query

```kusto
let timeRange = 7d;
let threshold = 3;
SigninLogs
| where TimeGenerated > ago(timeRange)
| where ResultType == 0  // Successful login
| summarize Locations = make_set(Location), Count = count() by UserDisplayName
| where array_length(Locations) >= threshold
```

#### 🧩 3. Alert enhancement 
3.1 - Entity Mapping

Allows Microsoft Sentinel to recognize and classify entities from the query results.

| Entity Type | Identifier 1 | Identifier 2        |
|-------------|--------------|---------------------|
| Account     | Name         | UserDisplayName     |


3.2 - Alert Details

- **Alert Name Format**  
`Unusual Location Sign-in - <UserDisplayName>`
- **Alert Description Format**  
`An unusual sign-in was detected for user '<UserDisplayName> 
The user has successfully signed in from multiple distinct geographic locations within the last 7 days (threshold: 3 locations).  
This may indicate suspicious activity such as compromised credentials or account sharing.`

`Details:  `
`- User: <UserDisplayName>`
`- Number of unique locations: <Count>`
`- Locations: <Locations>  
Please investigate this activity to ensure account security.

#### 🕒 4. Query Scheduling

| Setting                   | Value               |
|---------------------------|---------------------|
| Run query every           | 5 minutes           |
| Lookup data from the last | 7 Days              |
| First run start time      | 6/16/2025, 12:00 PM |

**Alert Threshold** : Trigger alert when query returns more than 0 results 
**Event Grouping** | Group alerts into incidents if all entities match within 5 minutes 
**Suppression** : | Off                                                                

### ⚙️ Incident Settings

**Incident Creation**      | Enabled                                                            
**Alert grouping** : 
**Reopen Closed Incident** | Disabled                                                           

---


## 🎯 Impossible Travel Detection

**📌 Use Case** : Detects login activities from geographically distant locations that are not possible to travel between within the observed timeframe. This is a strong indicator of account compromise through credential theft or session hijacking.

**📌 Description** : This rule detects sign-ins from distant locations within a short time, indicating impossible travel. It may suggest account compromise through leaked credentials or active attacks.

**✅ Deployment Method**

1. Go to **Microsoft Sentinel → Analytics**
2. Click on **+ Create → Scheduled query rule**

```kusto
SigninLogs
| where ResultType == 0 // Successful login
| where LocationDetails != "" and LocationDetails contains ","
| extend City = tostring(parse_json(LocationDetails)["city"]),
         Country = tostring(parse_json(LocationDetails)["countryOrRegion"]),
         Lat = todouble(parse_json(LocationDetails)["geoCoordinates"]["latitude"]),
         Lon = todouble(parse_json(LocationDetails)["geoCoordinates"]["longitude"])
| where isnotempty(Lat) and isnotempty(Lon)
| sort by UserPrincipalName asc, TimeGenerated asc
| extend NextEvent = next(TimeGenerated, 1),
         NextLat = next(Lat, 1),
         NextLon = next(Lon, 1),
         NextUser = next(UserPrincipalName, 1)
| where UserPrincipalName == NextUser
| extend DistanceKm = geo_distance_2points(Lat, Lon, NextLat, NextLon),
         TimeDiff = datetime_diff("Second", NextEvent, TimeGenerated),
         SpeedKmh = (DistanceKm / (TimeDiff / 3600))
| where SpeedKmh > 500
| project UserPrincipalName, City, Country, Lat, Lon, TimeGenerated, NextEvent, DistanceKm, SpeedKmh
```
##  ⚙️ Impossible Travel Detection – Analytics Rule Configuration

| Setting                  | Value                                                                 |
|--------------------------|-----------------------------------------------------------------------|
| **Objective**            | Detect impossible travel scenarios (e.g., logins from distant locations in a short time). |
| **Entity Mapping**       | `Account` → `UserPrincipalName`                                      |
| **Query Frequency**      | Every 5 minutes                                                      |
| **Lookup Period**        | Last 24 hours                                                        |
| **Alert Threshold**      | Trigger alert when query returns more than 0 results                |
| **Alert Name Format**    | `Impossible Travel Detected - {{UserPrincipalName}}`                |
| **Alert Description**    | `User {{UserPrincipalName}} appears to have signed in from distant locations within an unrealistic timeframe.` |
| **MITRE ATT&CK**         | `T1078 - Valid Accounts`                                             |
| **Severity**             | Medium                                                               |
| **Incident Creation**    | Enabled                                                              |
| **Event Grouping**       | Group alerts into incidents if all entities match within 5 minutes   |
| **Reopen Closed Incident** | Disabled                                                          |
| **Suppression**          | Off                                                                  |


---
