
# 📊 Microsoft Sentinel Setup and Architecture

## 🎯 Objective

Deploy Microsoft Sentinel in your Azure tenant to enable cloud-native SIEM and real-time threat detection.

# 🛰️ Microsoft Sentinel – Setup & Architecture

## 📘 Table des matières
1. [Présentation de Microsoft Sentinel](#présentation-de-microsoft-sentinel)
2. [Architecture de Référence](#architecture-de-référence)
3. [Création du Log Analytics Workspace](#création-du-log-analytics-workspace)
4. [Activation de Microsoft Sentinel](#activation-de-microsoft-sentinel)
5. [Gestion des Coûts et Estimations](#gestion-des-coûts-et-estimations)
6. [Bonnes Pratiques](#bonnes-pratiques)
7. [Captures d’Écran](#captures-décran)


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





