# 📊  Microsoft Sentinel – Setup & Architecture

## 🎯 Objective:
Deploy Microsoft Sentinel in your Azure tenant to enable cloud-native SIEM and real-time threat detection.
 

## 📘 Table of Contents

1. [Log Analytics Workspace Setup](#3-log-analytics-workspace-setup)
2. [Microsoft Sentinel Activation](#4-microsoft-sentinel-activation)
3. [Data Connectors Configuration](#5-data-connectors-configuration)
    - 3.1 [Azure Active Directory](#51-azure-active-directory)
    - 3.2 [Microsoft Defender for Endpoint](#52-microsoft-defender-for-endpoint)
    - 3.3 [Office 365](#53-office-365)
    - 3.4 [Azure Identity Protection (Optional)](#54-azure-identity-protection-optional)
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

### 🔹 3.1 Azure Active Directory (Microsoft Entra ID)

#### Purpose

Enable Microsoft Sentinel to collect logs related to:
- User sign-ins
- Authentication anomalies
- Directory changes

This connector is essential to detect identity-based threats and monitor access patterns across your cloud environment.

- Go to **Microsoft Sentinel** in the Azure Portal.
- In the left menu, select **Content Management** → **Content Hub**.
- Use the search bar and type **"Microsoft Entra ID"** (formerly Azure AD).
- Click on the result, then select **Install** or **Create**.

![AD_Connector_HowTO](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/06_Threat_Detection_%26_Simulation/Screenshots/AD_Connector_Install.png)

- Once installed, Click on **Manage**

![AD_Conenctor_Manage](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/06_Threat_Detection_%26_Simulation/Screenshots/AD_Connector_Manage.png)

- Select :
  - SigninLogs
  - AuditLogs
  - ProvisioningLogs 
  - RiskyUsers 
  - RiskEvents

![Entra_Log_Config](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/06_Threat_Detection_%26_Simulation/Screenshots/Entra_Log_config.png)

### 3. Verify the Connector in Data Connectors
- Go back to **Microsoft Sentinel > Data connectors**.
- Locate **Azure Active Directory** in the list.

![](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/06_Threat_Detection_%26_Simulation/Screenshots/Data_Connector.png)


#### Verify Log Ingestion with KQL

- Go to **Log Analytic Workspace > Select your Workspace**  
- Go **Logs > New Query** and run:

```kql
SigninLogs | take 10
```

![Sign-in_Logs](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/06_Threat_Detection_%26_Simulation/Screenshots/Sign-in_Logs.png)

---

### 🔹 3.2 Microsoft Defender for Endpoint

#### Purpose
Ingest security alerts and device telemetry from Defender for Endpoint (MDE) to Microsoft Sentinel.

#### 🛠️ Steps 

1. In Microsoft Sentinel, go to **Content Hub**.
2. Search for **"Microsoft 365 Defender"**.
3. Select the solution package and click **Install**.

![Def_Connect_Install](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/06_Threat_Detection_%26_Simulation/Screenshots/Defender_Connector_Install.png)

5. Follow the prompts and make sure **Microsoft Defender for Endpoint** is selected.
6. Once installed, go to **Data Connectors** or Manage
7. Locate **Microsoft Defender for Endpoint** in the list and click **Open connector page** **-> Connect**


![Def_Connect_Connect](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/06_Threat_Detection_%26_Simulation/Screenshots/Defender_Connector_Connect.png)


8. Verify the Connector in Data Connectors
   - Go back to **Microsoft Sentinel > Data connectors**.
   - Locate **Microsoft Defender For Endpoint** in the list.

![Connector_Defender_OV](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/06_Threat_Detection_%26_Simulation/Screenshots/Connector_Defender.png)

---

#### Data Flow
Once connected, you will start receiving:
- **SecurityAlert** tables (alerts raised in MDE)
- **DeviceEvents**, **DeviceInfo** (if using advanced hunting)

> ℹ️ Ensure that MDE is properly onboarded and licensed in your environment.


### 📊 Verify Microsoft Defender for Endpoint Log Ingestion

### 1. Open Microsoft Sentinel

- Navigate to your **Microsoft Sentinel Workspace**
- In the left-hand menu, click **Logs**
-  Run this KQL query

```kql
DeviceEvents
| where TimeGenerated > ago(1d)
| summarize TotalEvents = count() by bin(TimeGenerated, 1h)
| sort by TimeGenerated desc
```
---

---

### 🔹 3.3 Office 365

#### ✅ Purpose
Monitor user activities across Exchange Online, SharePoint, Teams, and OneDrive.

#### 🛠️ Steps 

1. In Microsoft Sentinel, go to **Content Hub**.
2. Search for **Microsoft 365**.
3. Click on the package and then **Install**.

![Office_Connector_Install](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/06_Threat_Detection_%26_Simulation/Screenshots/Office_Connector_Install.png)

5. During setup, ensure the **Office 365** connector is enabled.
6. After installation, go to **Data Connectors** or Manage

8. Locate **Office 365** and click **Open connector page**.
9. Under **Configuration**, select the workloads you want:
   - **Exchange**
   - **SharePoint**
   - **Teams**
10. Apply Changes
11. Verify the Connector in Data Connectors
   - Go back to **Microsoft Sentinel > Data connectors**.
   - Locate **Microsoft Defender For Endpoint** in the list.

!![Office_Connector](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/06_Threat_Detection_%26_Simulation/Screenshots/Office_Connector.png)


#### 🧪 Verification (KQL)
```kql
OfficeActivity | take 10
```

---

### 🔹 3.4 Azure Identity Protection (Optional)

#### ✅ Purpose
Ingest risk detection signals like:
- Risky users
- Risky sign-ins
- Identity compromise attempts

---

#### 🛠️ Steps

1. In Microsoft Sentinel, go to **Content Hub**.
2. Search for **"Microsoft Entra ID Protection"** (formerly Azure Identity Protection).
3. Click the solution and select **Install**.
4. Once installed, go to **Data Connectors**.
5. Locate **Azure Identity Protection** and click **Open connector page**.
6. Click **Connect**.

---

#### 🧾 Requirements
- Requires **Azure AD Premium P2** license.
- Connects to tables: `RiskyUsers`, `RiskySignins`, `IdentityInfo`.

---

#### 🧪 Verification (KQL)
```kql
RiskyUsers | take 10
RiskySignIns | take 10
```


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
























## 6. 💰 Cost Management

- Microsoft Sentinel provides a **30-day free trial**, with up to **10 GB/day** included for both Sentinel and Log Analytics.
- Additional data is billed by volume. It's important to monitor ingestion rates.
- Use the **Microsoft Pricing Calculator** to estimate ongoing costs: [Sentinel Pricing](https://azure.microsoft.com/en-us/pricing/details/microsoft-sentinel/)
- Apply best practices such as:
  - Enabling only required data connectors
  - Setting data caps
  - Choosing appropriate retention periods****





