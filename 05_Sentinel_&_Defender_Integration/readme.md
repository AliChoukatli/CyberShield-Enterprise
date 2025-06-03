# 🧩 Microsoft Sentinel & Defender for Endpoint Integration

## 📋 Overview

This document outlines the integration of Microsoft Sentinel with Microsoft Defender for Endpoint (MDE) to establish a robust security monitoring and incident response capability in a cloud-first environment. This setup enables real-time alert ingestion, automated response, and deep threat investigation using Microsoft’s XDR and SIEM solutions.

> **Note:** This implementation is cloud-only and designed for lab demonstration purposes. The structure, tooling, and response workflow reflect enterprise-grade security practices.

---

## 🎯 Objectives

- Centralize security events from Defender for Endpoint into Microsoft Sentinel.
- Triage and investigate endpoint threats in near real-time.
- Build automated playbooks to contain and respond to threats.
- Document a sample attack scenario and how it was detected and handled.

---

## 🛠️ Setup & Integration Steps

### 1. 🎛️ Enable Microsoft Defender for Endpoint
- Ensure your devices are onboarded to Microsoft Defender for Endpoint.
- Navigate to **Microsoft 365 Defender** > **Settings** > **Device onboarding**.
- Deploy via **Intune**, **GPO**, or **script** depending on environment.
- Confirm telemetry is visible in **Microsoft 365 Defender portal**.

### 2. 🧩 Connect Defender for Endpoint to Sentinel
1. Open the **Azure Portal** and go to **Microsoft Sentinel**.
2. Select your **Sentinel Workspace** > **Content Hub** > Search for `Microsoft 365 Defender`.
3. Click **Install Solution** → Follow the wizard to connect Defender for Endpoint.
4. Confirm connectors:  
   - Microsoft 365 Defender (Unified XDR)  
   - Microsoft Defender for Endpoint (Device telemetry and alerts)

### 3. ✅ Validate Data Ingestion
In Sentinel:
- Navigate to **Logs** > Run KQL query:

```kusto
SecurityAlert
| where ProductName == "Microsoft Defender for Endpoint"
| sort by TimeGenerated desc
```
- Confirm alerts are received from Defender.
- Test with a real or simulated threat (see attack scenario below).

---

# 🧪 Simulated Attack Scenario: PowerShell-Based Credential Dumping

## 🎯 Objective

Demonstrate the detection, investigation, and automated response workflow of a simulated credential dumping attack using Microsoft Defender for Endpoint and Microsoft Sentinel.

---

## 🧾 Scenario Summary

**Title:** PowerShell-based Credential Dumping Detected  
**Date:** 2025-06-01  
**Environment:** Cloud-only (Intune-managed endpoints + Microsoft 365 Defender + Sentinel)

---

## 🔍 Description

A user endpoint triggered a Defender alert for suspicious PowerShell activity attempting to dump credentials, mimicking `Mimikatz` behavior. This alert was sent to Microsoft Sentinel and resulted in an automated incident workflow.

---

## 🧪 Simulated Steps

1. A simulated attacker executes an obfuscated PowerShell command on `DESKTOP-01`.
2. Microsoft Defender for Endpoint detects behavior:
   > **Alert:** `Suspicious behavior by PowerShell (CredentialAccess)`
3. Alert is sent to **Microsoft 365 Defender** and ingested into **Microsoft Sentinel**.
4. Sentinel analytic rule detects the alert and generates an **incident**.
5. Automation rule is triggered:
   - Assigns incident to analyst
   - Tags incident as `HighPriority`
   - Launches playbook to isolate the device

---

## 🧠 Investigation in Sentinel

### 📝 Incident Details

| Field         | Value                    |
|---------------|--------------------------|
| **Severity**  | High                     |
| **Entity**    | `DESKTOP-01`             |
| **User**      | `demo@domain.com`        |
| **Alert Type**| Behavior-based (PSExec/Mimikatz) |
| **Timestamp** | 2025-06-01 14:32 UTC     |

---

### 🔎 Actions Performed

- ✅ Alert reviewed in **Sentinel Incident blade**
- ✅ Timeline of user/device activity analyzed
- ✅ Cross-checked with additional Defender alerts for correlation
- ✅ Device risk level and recent login behavior retrieved

---

## 🔁 Automation & Response

### 1. 🛠️ Automation Rule: *Auto-Assign & Tag*

| Trigger Condition                      | Action                          |
|----------------------------------------|----------------------------------|
| Incident contains MDE alert            | Assign to analyst               |
|                                        | Add tag `HighPriority`          |
|                                        | Launch isolation playbook       |

**Rule Type:** Scheduled / When incident is created  
**Scope:** Alerts from Microsoft Defender for Endpoint  
**Tags Applied:** `HighPriority`, `EndpointThreat`

---

### 2. ⚙️ Playbook: *Isolate Compromised Device*

| Action                            | Value                           |
|-----------------------------------|----------------------------------|
| API                               | Microsoft Defender for Endpoint |
| Endpoint                          | `/machines/{id}/isolate`        |
| Inputs                            | `Device ID`, `Reason`, `Comment`|
| Additional                        | Send SOC notification via email |

**Result:** Device `DESKTOP-01` was successfully isolated from the network to contain the threat.

---

### 🧾 Sample KQL Queries

- Query 1 – Endpoint alert overview
```kusto
SecurityAlert
| where ProductName == "Microsoft Defender for Endpoint"
| project TimeGenerated, AlertName, Computer, Severity, Description
| sort by TimeGenerated desc
```
- Query 2 – Timeline of a specific host
```kusto
DeviceEvents
| where DeviceName == "DESKTOP-01"
| where Timestamp > ago(1d)
| sort by Timestamp asc
```


## 📸 Recommended Screenshots

- Defender for Endpoint alert screen
- Sentinel Incident dashboard
- Automation Rule settings
- Logic App run history (successful execution)
- Isolation confirmation response

---

## ✅ Best Practices

| 🧩 Area                  | 💡 Recommendation                                                   |
|--------------------------|---------------------------------------------------------------------|
| Alert Ingestion          | Use unified Microsoft 365 Defender connector                        |
| Alert Correlation        | Enable advanced fusion rules                                        |
| Automation               | Use Logic Apps for isolation, tagging, and escalation               |
| Alert Noise Reduction    | Fine-tune analytic rules and filters                                |
| Incident Enrichment      | Use entity behavior analytics and workbook dashboards               |
| Endpoint Visibility      | Onboard all Windows 10/11 devices and servers to Defender for Endpoint |



## ✅ Outcome

This lab demonstrates how a cloud-only SOC setup using Microsoft 365 Defender and Sentinel can detect, correlate, and automatically respond to suspicious endpoint behavior with minimal manual intervention.

