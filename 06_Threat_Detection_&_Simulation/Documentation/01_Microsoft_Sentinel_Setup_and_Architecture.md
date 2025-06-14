# 📊  Microsoft Sentinel – Setup & Architecture

## 🎯 Objective:
Deploy Microsoft Sentinel in your Azure tenant to enable cloud-native SIEM and real-time threat detection.
 

## 📘 Table of Contents

1. [Log Analytics Workspace Setup](#3-log-analytics-workspace-setup)
2. [Microsoft Sentinel Activation](#4-microsoft-sentinel-activation)
3. [Data Connectors Configuration](#5-data-connectors-configuration)
    - 5.1 [Azure Active Directory](#51-azure-active-directory)
    - 5.2 [Microsoft Defender for Endpoint](#52-microsoft-defender-for-endpoint)
    - 5.3 [Office 365](#53-office-365)
    - 5.4 [Azure Identity Protection (Optional)](#54-azure-identity-protection-optional)
4. [Cost Management](#6-cost-management)
5. [Best Practices](#7-best-practices)


## 🧰 Prerequisites

- Azure Subscription with appropriate permissions
- Log Analytics Workspace (or permissions to create one)
- Azure AD Global Administrator or Security Admin
- Microsoft Defender data sources enabled (optional but recommended)


## 🎯 1 - Log Analytics Workspace Setup

1. Go to the [Azure Portal](https://portal.azure.com).
2. Search for **"Log Analytics Workspaces"** and click **Create**.
3. Choose:
   - **Subscription**: Your lab subscription
   - **Resource Group**: Create or reuse (e.g., `CyberShield-RG`)
   - **Workspace Name**: e.g., `CyberShield-Workspace`
   - **Region**: East US or your preferred
4. Click **Review + Create** and then **Create**.

![Log_Analytic](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/06_Threat_Detection_%26_Simulation/Screenshots/Log_Analytic_Ov.png)

## 🎯 2 - Microsoft Sentinel Activation

1. In the Azure Portal, search for **"Microsoft Sentinel"**.
2. Click **+ Add** or **+ Create**.
3. Select the Log Analytics Workspace you created earlier.
4. Click **Add Microsoft Sentinel**.

![Sentinel_OV](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/06_Threat_Detection_%26_Simulation/Screenshots/Sentinel_OV.png)


## 🎯 3 - Data Connectors Configuration

This section explains how to enable and configure key Microsoft Sentinel data connectors to ingest logs from critical Microsoft services such as Azure AD, Defender for Endpoint, and Office 365.

### 🔹 3.1 Azure Active Directory

#### ✅ Purpose
Collect logs related to user sign-ins, authentication anomalies, and directory changes.

#### 🛠️ Steps
1. In Microsoft Sentinel, go to **Data connectors**.
2. Search for **Azure Active Directory**.
3. Click **Open connector page**.
4. Under **Configuration**, enable:
   - SignInLogs
   - AuditLogs
   - NonInteractiveUserSignInLogs (optional)
   - ServicePrincipalSignInLogs (optional)
   - ManagedIdentitySignInLogs (optional)
5. Click **Apply Changes**.

> 🧠 **Tip:** Sign-in and audit logs are essential for detecting identity-based threats.

---

### 🔹 3.2 Microsoft Defender for Endpoint

#### ✅ Purpose
Ingest security alerts and device telemetry from Defender for Endpoint.

#### 🛠️ Prerequisites
- Defender for Endpoint must already be deployed and devices onboarded.

#### 🛠️ Steps
1. In Microsoft Sentinel > **Data connectors**, search for **Microsoft Defender for Endpoint**.
2. Click **Open connector page**.
3. Click **Connect**.
4. No further configuration is needed if Defender is active in your tenant.

> 🔍 Sentinel will automatically begin collecting alerts from Defender for Endpoint.

---

### 🔹 3.3 Office 365

#### ✅ Purpose
Monitor Exchange Online, SharePoint, and Teams activities (emails, file access, etc.).

#### 🛠️ Prerequisites
- You must have **Office 365 auditing** enabled.
- Global Administrator permissions are required during setup.

#### 🛠️ Steps
1. In Microsoft Sentinel > **Data connectors**, search for **Office 365**.
2. Click **Open connector page**.
3. Under **Configuration**, select the workloads to ingest:
   - Exchange
   - SharePoint
   - Teams
4. Authorize access via **Connect Office 365 tenant**.
5. Click **Apply Changes**.

> 🧠 This connector is valuable for detecting suspicious email activity or data exfiltration via SharePoint.

---

### 🔹 3.4 Azure Identity Protection (Optional)

#### ✅ Purpose
Detect and ingest risky sign-ins, risky users, and identity compromise data.

#### 🛠️ Prerequisites
- Requires **Azure AD Premium P2** licensing.

#### 🛠️ Steps
1. In Sentinel > **Data connectors**, search for **Azure Identity Protection**.
2. Click **Open connector page**.
3. Click **Connect** (no extra config needed).
4. Data will start flowing from the Identity Protection logs.

---

### ✅ Final Check – Verifying Ingested Data

Once your connectors are enabled:
- Go to **Logs** in Microsoft Sentinel.
- Use basic KQL queries to test data ingestion:

```kql
SigninLogs | take 10
SecurityAlert | where ProductName == "Microsoft Defender for Endpoint"
OfficeActivity | take 10
```

✅ If results appear, your data connector is working.































# 6. 💰 Cost Management

- Microsoft Sentinel provides a **30-day free trial**, with up to **10 GB/day** included for both Sentinel and Log Analytics.
- Additional data is billed by volume. It's important to monitor ingestion rates.
- Use the **Microsoft Pricing Calculator** to estimate ongoing costs: [Sentinel Pricing](https://azure.microsoft.com/en-us/pricing/details/microsoft-sentinel/)
- Apply best practices such as:
  - Enabling only required data connectors
  - Setting data caps
  - Choosing appropriate retention periods****





