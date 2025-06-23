# 🚨 LAPS Integration with Microsoft Sentinel

## 🎯 Objective

This guide explains how to monitor and detect sensitive operations related to the `LAPS_Admin` account using Microsoft Sentinel. Key activities include:

- Retrieval of the local admin password via Intune
- Manual rotation of the local admin password
- Local sign-in using the `LAPS_Admin` account

---

## 1️⃣ Enable Audit Logging on Endpoints

Make sure **Advanced Audit Policy Configuration** is enabled via GPO or Intune on all endpoints.

Recommended audit categories:
- **Account Logon**
- **Logon/Logoff**
- **Object Access**
- **Privilege Use**

These logs will be required to track local sign-ins and privileged activity.

---

## 2️⃣ Connect Required Logs to Microsoft Sentinel

Go to **Microsoft Sentinel > Content Management > Data connectors**, and connect the following:

| Data Source | Purpose |
|-------------|---------|
| **Microsoft Intune** | Tracks password access operations via Endpoint Manager |
| **Azure AD** | Logs role changes, credential reads, and other sensitive operations |
| **Windows Security Events** (via AMA or Log Analytics Agent) | Captures local sign-ins using `LAPS_Admin` |
| **Microsoft Defender for Endpoint** *(optional)* | Provides contextual enrichment and threat indicators |

---

## 3️⃣ Use Cases & Detection Rules

### ✅ Case 1 — Viewing LAPS Password via Intune

This query detects users who retrieved a local admin password through Intune:

```kusto
AuditLogs
| where ActivityDisplayName == "Read deviceLocalCredentials"
| extend DeviceName = tostring(TargetResources[0].displayName)
| extend Reader = tostring(InitiatedBy.user.userPrincipalName)
| project TimeGenerated, DeviceName, Reader, Result = ResultReason
```
> 🔔 Recommendation: Create an alert rule with Medium severity. Add a condition to alert if the Reader is not part of a privileged group like LAPS Password Readers.

### ✅ Case 2 — Manual Rotation of the Local Admin Password
This query identifies manual password resets performed from the Intune console:

```kusto
AuditLogs
| where ActivityDisplayName == "Rotate local device password"
| extend DeviceName = tostring(TargetResources[0].displayName)
| extend Initiator = tostring(InitiatedBy.user.userPrincipalName)
| project TimeGenerated, DeviceName, Initiator
```
> 📌 This may indicate troubleshooting activity or suspicious attempts to reset the admin password.

### ✅ Case 3 — Local Sign-In using the LAPS_Admin Account
Assuming Windows Security logs are connected, the following query detects logon events from LAPS_Admin

```kusto
SecurityEvent
| where EventID == 4624 and Account == "LAPS_Admin"
| project TimeGenerated, Computer, Account, LogonType, IPAddress = IpAddress
```

🛡️ Alert tip: Raise an alert if logon happens:

- From an unexpected endpoint
- During non-working hours
- Too frequently (suspicious pattern)

---

## 📊 LAPS Monitoring Workbook (Recommended)

Create a custom workbook to visualize:

- Daily count of password reads
- Manual rotations
- Geolocation of sign-ins with LAPS_Admin
- Audit activity summary

🧠 Hunting Query Example

```kusto
AuditLogs
| where ActivityDisplayName in ("Read deviceLocalCredentials", "Rotate local device password")
| summarize count() by ActivityDisplayName, bin(TimeGenerated, 1d)
```
