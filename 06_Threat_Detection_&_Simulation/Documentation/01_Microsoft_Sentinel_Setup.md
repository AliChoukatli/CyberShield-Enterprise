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

# 🔹 3.1 Azure Active Directory (Microsoft Entra ID)

## ✅ Purpose

Enable Microsoft Sentinel to collect logs related to:
- User sign-ins
- Authentication anomalies
- Directory changes

This connector is essential to detect identity-based threats and monitor access patterns across your cloud environment.

## 🛠️ Steps

### 1. Access Content Hub
- Go to **Microsoft Sentinel** in the Azure Portal.
- In the left menu, select **Content Management** → **Content Hub**.

### 2. Install the Microsoft Entra ID Solution
- Use the search bar and type **"Microsoft Entra ID"** (formerly Azure AD).
- Click on the result, then select **Install** or **Create**.

![AD_Connector_HowTO](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/06_Threat_Detection_%26_Simulation/Screenshots/AD_Connector_HowTO.png)

- Once installed, the button changes to **Manage** — click it to access related components (Data Connector, Workbooks, Analytics Rules, etc.).

![AD_Conenctor_Manage](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/06_Threat_Detection_%26_Simulation/Screenshots/AD_Connector_Manage.png)

- Click on Entra ID - > Open Connector Page
- Select :
  - SigninLogs
  - AuditLogs
  - ProvisioningLogs 
  - RiskyUsers 
  - RiskEvents
  - 
![Entra_Log_Config](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/06_Threat_Detection_%26_Simulation/Screenshots/Entra_Log_config.png)

---

### 3. Verify the Connector in Data Connectors
- Go back to **Microsoft Sentinel > Data connectors**.
- Locate **Azure Active Directory** in the list.
- Click on it, then click **Open connector page**.

📸 `data_connector_list_azure_ad.png`

---


## ✅ Optional: Verify Log Ingestion with KQL

- Go to **Log Analytic Workspace > Select your Workspace**  
- Go **Logs > New Query** and run:

```kql
SigninLogs | take 10
```
---

### 🔹 3.2 Microsoft Defender for Endpoint

#### ✅ Purpose
Ingest security alerts and device telemetry from Defender for Endpoint (MDE) to Microsoft Sentinel.

#### 🛠️ Steps (2025 – Updated via Content Hub)

1. In Microsoft Sentinel, go to **Content Hub**.
2. Search for **"Microsoft 365 Defender"**.
3. Select the solution package and click **Install**.
4. Follow the prompts and make sure **Microsoft Defender for Endpoint** is selected.
5. Once installed, go to **Data Connectors**.
6. Find **Microsoft Defender for Endpoint** in the list and click **Open connector page**.
7. If not already connected, click **Connect**.

---

#### ✅ Data Flow
Once connected, you will start receiving:
- **SecurityAlert** tables (alerts raised in MDE)
- **DeviceEvents**, **DeviceInfo** (if using advanced hunting)

> ℹ️ Ensure that MDE is properly onboarded and licensed in your environment.

---

### 🔹 3.3 Office 365

### 📧 5.3 Office 365

#### ✅ Purpose
Monitor user activities across Exchange Online, SharePoint, Teams, and OneDrive.

---

#### 🛠️ Steps (2025 – Updated via Content Hub)

1. In Microsoft Sentinel, go to **Content Hub**.
2. Search for **"Microsoft 365 Defender"**.
3. Click on the package and then **Install**.
4. During setup, ensure the **Office 365** connector is enabled.
5. After installation, go to **Data Connectors**.
6. Locate **Office 365** and click **Open connector page**.
7. Under **Configuration**, select the workloads you want:
   - **Exchange**
   - **SharePoint**
   - **Teams**
8. Authorize and connect your tenant.

---

#### 📌 Notes
- Audit logging must be enabled in Microsoft Purview (Compliance Center).
- Requires Global Admin privileges for the initial connection.

---

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

#### 🛠️ Steps (2025 – Updated via Content Hub)

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
























# 6. 💰 Cost Management

- Microsoft Sentinel provides a **30-day free trial**, with up to **10 GB/day** included for both Sentinel and Log Analytics.
- Additional data is billed by volume. It's important to monitor ingestion rates.
- Use the **Microsoft Pricing Calculator** to estimate ongoing costs: [Sentinel Pricing](https://azure.microsoft.com/en-us/pricing/details/microsoft-sentinel/)
- Apply best practices such as:
  - Enabling only required data connectors
  - Setting data caps
  - Choosing appropriate retention periods****





