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

