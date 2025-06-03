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

## 📌 Notes

- This scenario demonstrates end-to-end visibility and response using cloud-native Microsoft security tools.
- Timeline, device forensics, and alert correlation were all handled through **Microsoft Sentinel** and **Defender for Endpoint**.
- Automation ensured rapid containment and SOC notification.

---

## 📸 Recommended Screenshots

- Defender for Endpoint alert screen
- Sentinel Incident dashboard
- Automation Rule settings
- Logic App run history (successful execution)
- Isolation confirmation response

---

## ✅ Outcome

This lab demonstrates how a cloud-only SOC setup using Microsoft 365 Defender and Sentinel can detect, correlate, and automatically respond to suspicious endpoint behavior with minimal manual intervention.

