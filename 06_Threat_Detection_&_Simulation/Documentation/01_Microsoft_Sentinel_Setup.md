# 📊 Microsoft Sentinel – Setup & Architecture

## 🎯 Objective

Deploy Microsoft Sentinel in your Azure environment to enable centralized log analytics, real-time security monitoring, and threat detection across cloud and on-premises resources.

---

## 📝 Introduction

This section guides you through deploying Microsoft Sentinel within your Azure tenant to enable a cloud-native Security Information and Event Management (SIEM) solution with real-time threat detection capabilities.

You will learn how to set up the necessary infrastructure, activate Sentinel, configure essential data connectors, and manage costs for an effective security monitoring environment.

---

## 📘 Table of Contents

1. [Log Analytics Workspace Setup](#3-log-analytics-workspace-setup)
2. [Microsoft Sentinel Activation](#4-microsoft-sentinel-activation)
3. [Data Connectors Configuration](#5-data-connectors-configuration)
    - 3.1 [Azure Active Directory](#51-azure-active-directory)
    - 3.2 [Microsoft Defender XDR ( Defender for Endpoint + Office 365]()
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
- Click on the result, then select **Install**

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

#### Verify the Connector in Data Connectors
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

### 🔹 3.2 Microsoft Defender XDR

#### Purpose

Enable Microsoft Sentinel to collect logs related to:

- Go to **Microsoft Sentinel** in the Azure Portal.
- In the left menu, select **Content Management** → **Content Hub**.
- Use the search bar and type **"Microsoft Defender XDR"**
- Click on the result, then select **Install**

![XDR_Connector_Install](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/06_Threat_Detection_%26_Simulation/Screenshots/XDR_Connector_Install.png)

- Once installed, Click on **Manage**
- Select **Microsoft Defender XDR -> Open connector Page**
- Select
    - `Microsoft Defender for Endpoint` (10/10)
    - `Microsoft Defender for Office 365` (5/5) - - 
    - `Microsoft Defender Alerts`(2/2)`


Notes: 
If you can't Find Defender for office 365  look for `Microsoft 365` in Content Hub
- Select
  - Exchange
  - SharePoint
  - Teams
  
#### Verify the Connector in Data Connectors
- Go back to **Microsoft Sentinel > Data connectors**.
- Locate **Microsoft Defender XDR** in the list.

![XDR_Connector_OV](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/06_Threat_Detection_%26_Simulation/Screenshots/XDR_Connector_OV.png)





## 4. 💰 Cost Management

- Microsoft Sentinel provides a **30-day free trial**, with up to **10 GB/day** included for both Sentinel and Log Analytics.
- Additional data is billed by volume. It's important to monitor ingestion rates.
- Use the **Microsoft Pricing Calculator** to estimate ongoing costs: [Sentinel Pricing](https://azure.microsoft.com/en-us/pricing/details/microsoft-sentinel/)
- Apply best practices such as:
  - Enabling only required data connectors
  - Setting data caps
  - Choosing appropriate retention periods





