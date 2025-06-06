# 🛡️ Exposure Level Actions – Defender for Endpoint

This document outlines actions taken to address a **High Exposure Level** reported in the Microsoft Defender for Endpoint (MDE) Threat & Vulnerability Management (TVM) dashboard.

Two different types of responses were demonstrated:

- ✅ A remediation request (Update Windows 11)
- 🟡 A justified risk acceptance (signing communication policy)

---

## 📊 Initial Exposure Summary

- **Exposure Level**: 🔴 High
- **Device**: `LTP-HLP01`
- **Detected Issues**:
  1. Outdated Windows 11 build
  2. Network client: Digitally sign communications (always) – Not configured
  3. BitLocker not enabled
  4. RDP access enabled
  5. Defender AV not fully configured

---

## 🛠️ 1. Remediation Attempt – Windows 11 Update

An attempt was made to create a remediation task to update the device to the latest version of Windows 11 using Microsoft Intune.

| Field | Value |
|-------|-------|
| **Remediation Type** | Software update |
| **Target** | Windows 11 (OS and built-in applications) |
| **Tool** | Microsoft Intune |
| **Due Date** | June 7, 2025 |
| **Priority** | High |
| **Notes** | Updating Windows 11 to the latest version to reduce device exposure score. Requested via Defender TVM and assigned to Intune. |

![Req_win11_update](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/03_AzureAD_Sync_%26_Endpoint_Security/Screenshots/Req_Win11update.png)

---

## 🟡 2. Risk Accepted – Digitally Sign Communications Policy

Another vulnerability was handled by accepting the risk, rather than applying the configuration immediately.

| Policy | Microsoft network client: Digitally sign communications (always) |
|--------|------------------------------------------------------------------|
| **Action** | Risk accepted |
| **Justification** | In a lab setup, this policy is not enforced to allow compatibility testing with legacy services. In a production environment, this setting would typically be enabled via Group Policy or Intune baseline. |
| **Status** | Documented and marked as accepted risk in Defender portal |

This demonstrates the ability to assess risk pragmatically and document security decisions for audit purposes.

---

## ✅ Summary

| Action Type | Item | Result |
|-------------|------|--------|
| Remediation | Windows 11 Update | ❌ Failed (Lab limitation) |
| Risk Accepted | Digitally sign communications | ✅ Documented justification |

In a real-world enterprise, both items would be tracked and managed as part of a broader vulnerability management program.

