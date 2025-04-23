# Day 1: Installation & Configuration de base

## 🧰 Prerequisites
Before starting the configuration, ensure the following prerequisites are met:
- A **Windows machine** with administrative rights.
- **Internet access** for downloading necessary files and updates.
- **PowerShell 5.1+** installed for running automation scripts.
- The **`install.xml` file** must be present in the same directory as the script.
- A **Microsoft 365 account** with a valid license (e.g., **Business Premium**).

## Overview
This section covers the steps taken on Day 1 of the project:
1. **Windows Server Installation**
   - [🔽 Download Windows Server 2022 ISO](https://www.microsoft.com/fr-fr/evalcenter/download-windows-server-2022)
   - Choose The version (Standard Desktop Experience)
   - Choose Custom -" New
   - Choose the size of the partition you need -> Apply -> Next
   - Choose a Strong Password -> Next
   - [You should see the Server Manager](https://github.com/AliChoukatli/SecureIT-for-SMB/blob/main/Screenshots/Day1_Installation_AD/win_serv_1st_screen.png)
     
3. **Active Directory Setup**
4. **Azure AD & Intune Integration**

This folder contains screenshots taken during these steps to assist you in following the instructions in the guide.

## 📸 Screenshots
The following screenshots demonstrate key steps of the installation and configuration:

| Screenshot | Description |
|------------|-------------|
| ![01_Install_M365_Business_Premium](https://github.com/AliChoukatli/SecureIT-for-SMB/blob/main/Screenshots/Day1_Installation_AD/Install%20M365%20Business%20Premium.png) | Choose the Business Option (Trial works) to install M365 Business Premium. |
| ![02_windows_server_install](Screenshots/Day1_Installation_AD/02_windows_server_install.png) | Screenshot showing the first part of the Windows Server installation process. It covers the initial setup and configuration steps
| ![03_ad_user_creation](Screenshots/Day1_Installation_AD/03_ad_user_creation.png) | Screenshot showing the creation of users in Active Directory. |
| ![04_azure_ad_overview](Screenshots/Day1_Installation_AD/04_azure_ad_overview.png) | Screenshot of the Azure AD overview page. |
| ![05_intune_enrollment](Screenshots/Day1_Installation_AD/05_intune_enrollment.png) | Screenshot showing the Intune device enrollment process. |

## Purpose
These screenshots are provided to help you follow the configuration steps for Day 1 of the project. They offer visual references to guide you through each process, ensuring smooth execution of tasks such as server setup, user creation, and integration with Azure AD & Intune.

