
# 📊 Microsoft Sentinel Setup and Architecture

## 🎯 Objective

Deploy Microsoft Sentinel in your Azure tenant to enable cloud-native SIEM and real-time threat detection.

# 🛰️ Microsoft Sentinel – Setup & Architecture

# 🛰️ Microsoft Sentinel – Implementation Guide

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


🎯 Log Analytics Workspace Setup

1. Go to the [Azure Portal](https://portal.azure.com).
2. Search for **"Log Analytics Workspaces"** and click **Create**.
3. Choose:
   - **Subscription**: Your lab subscription
   - **Resource Group**: Create or reuse (e.g., `CyberShield-RG`)
   - **Workspace Name**: e.g., `CyberShield-Workspace`
   - **Region**: East US or your preferred
4. Click **Review + Create** and then **Create**.

![Log_Analytic](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/06_Threat_Detection_%26_Simulation/Screenshots/Log_Analytic_Ov.png)

## 🎯 Microsoft Sentinel Activation

1. In the Azure Portal, search for **"Microsoft Sentinel"**.
2. Click **+ Add** or **+ Create**.
3. Select the Log Analytics Workspace you created earlier.
4. Click **Add Microsoft Sentinel**.

![Sentinel_OV](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/06_Threat_Detection_%26_Simulation/Screenshots/Sentinel_OV.png)


































# 6. 💰 Cost Management

- Microsoft Sentinel provides a **30-day free trial**, with up to **10 GB/day** included for both Sentinel and Log Analytics.
- Additional data is billed by volume. It's important to monitor ingestion rates.
- Use the **Microsoft Pricing Calculator** to estimate ongoing costs: [Sentinel Pricing](https://azure.microsoft.com/en-us/pricing/details/microsoft-sentinel/)
- Apply best practices such as:
  - Enabling only required data connectors
  - Setting data caps
  - Choosing appropriate retention periods****





