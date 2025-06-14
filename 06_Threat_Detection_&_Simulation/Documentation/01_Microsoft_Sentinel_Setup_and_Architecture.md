
# 📊 Microsoft Sentinel Setup and Architecture

## 🎯 Objective

Deploy Microsoft Sentinel in your Azure tenant to enable cloud-native SIEM and real-time threat detection.

# 🛰️ Microsoft Sentinel – Setup & Architecture

# 🛰️ Microsoft Sentinel – Implementation Guide

## 📘 Table of Contents
1. [Overview of Microsoft Sentinel](#1-overview-of-microsoft-sentinel)
2. [Reference Architecture](#2-reference-architecture)
3. [Log Analytics Workspace Setup](#3-log-analytics-workspace-setup)
4. [Microsoft Sentinel Activation](#4-microsoft-sentinel-activation)
5. [Data Connectors Configuration](#5-data-connectors-configuration)
    - 5.1 [Azure Active Directory](#51-azure-active-directory)
    - 5.2 [Microsoft Defender for Endpoint](#52-microsoft-defender-for-endpoint)
    - 5.3 [Office 365](#53-office-365)
    - 5.4 [Azure Identity Protection (Optional)](#54-azure-identity-protection-optional)
6. [Cost Management](#6-cost-management)
7. [Best Practices](#7-best-practices)



## 🧰 Prerequisites

- Azure Subscription with appropriate permissions
- Log Analytics Workspace (or permissions to create one)
- Azure AD Global Administrator or Security Admin
- Microsoft Defender data sources enabled (optional but recommended)

## 🏗️ Step 1 – Create a Log Analytics Workspace

1. Go to the [Azure Portal](https://portal.azure.com).
2. Search for **"Log Analytics Workspaces"** and click **Create**.
3. Choose:
   - **Subscription**: Your lab subscription
   - **Resource Group**: Create or reuse (e.g., `CyberShield-RG`)
   - **Workspace Name**: e.g., `CyberShield-Workspace`
   - **Region**: East US or your preferred
4. Click **Review + Create** and then **Create**.

![Log_Analytic](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/06_Threat_Detection_%26_Simulation/Screenshots/Log_Analytic_Ov.png)

## 🧠 Step 2 – Enable Microsoft Sentinel

1. In the Azure Portal, search for **"Microsoft Sentinel"**.
2. Click **+ Add** or **+ Create**.
3. Select the Log Analytics Workspace you created earlier.
4. Click **Add Microsoft Sentinel**.

![Sentinel_OV](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/06_Threat_Detection_%26_Simulation/Screenshots/Sentinel_OV.png)





