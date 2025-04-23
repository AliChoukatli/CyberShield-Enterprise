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
     
2. **Active Directory Setup**
 ✅ Step 1: Rename the Server : Why? A clear hostname helps with admin tasks and scripting.
   - Open Server Manager
   - Click on Local Server
   - Click the name next to Computer Name -> Click Change and rename it to something like (SRV-AD-01) -> Restart the computer:  [Change the Computer name] (Screenshot)
     
 ✅ Step 2: Set a Static IP Address : Why? Active Directory needs a fixed IP.
   - In Server Manager > Local Server, click on the current IPv4 address

   - Go to Properties > IPv4 Settings

   - Set:

     IP: 192.168.2.10
     Masque: 255.255.255.0
     Gateway: 192.168.2.1
     Preferred DNS: 127.0.0.1 
     Alternate DNS: 8.8.8.8 
     📸 Capture:

 ✅ Step 3: Install the Active Directory Domain Services Role
 
   In Server Manager, click Add roles and features
   Choose Role-based or feature-based installation
   Select your server
   Under roles, check Active Directory Domain Services
   Click Next through to the end and hit Install
   📸 Screenshot to take: Just before clicking “Install” with the AD DS role selected


✅ Step 4: Promote the Server to Domain Controller
Actions:
After AD DS is installed, click the yellow flag in Server Manager

Click Promote this server to a domain controller

Choose Add a new forest

Enter a domain name like secureit.local

Leave defaults for forest/domain level and DNS

Set the DSRM password

Continue with Next > Install

📸 Screenshots to take:

Screen where you choose “Add a new forest” and enter the domain name

Final summary before clicking “Install”

🔁 The server will automatically restart after promotion.

✅ Step 5: Verify Active Directory Installation
Actions:
Open Server Manager

Go to Tools > Active Directory Users and Computers

Confirm your domain appears and OUs (Organizational Units) are visible

📸 Screenshot to take: Full window of "Active Directory Users and Computers" showing your domain (e.g., secureit.local)

5. **Azure AD & Intune Integration**

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

