# Day 1: Installation & Configuration de base

## 🧰 Prerequisites
Before starting the configuration, ensure the following prerequisites are met:
- A **Windows machine** with administrative rights.
- **Internet access** for downloading necessary files and updates.
- **PowerShell 5.1+** installed for running automation scripts.
- The **`install.xml` file** must be present in the same directory as the script.
- A **Microsoft 365 account** with a valid license (e.g., **Business Premium**).

## Overview
This section covers the steps taken :

I. **Windows Server Installation**
   - [🔽 Download Windows Server 2022 ISO](https://www.microsoft.com/fr-fr/evalcenter/download-windows-server-2022)
   - Choose The version (Standard Desktop Experience)
   - Choose Custom -" New
   - Choose the size of the partition you need -> Apply -> Next
   - Choose a Strong Password -> Next
   - [You should see the Server Manager](https://github.com/AliChoukatli/SecureIT-for-SMB/blob/main/Screenshots/Day1_Installation_AD/win_serv_1st_screen.png)
     
II. **Active Directory Setup**
  **Step 1:** Rename the Server : Why? A clear hostname helps with admin tasks and scripting.
   - Open Server Manager
   - Click on Local Server
   - Click the name next to Computer Name -> Click Change and rename it to something like (SRV-AD-01) -> Restart the computer
   - [Verifiation ] (Screenshot capture name)
     
  **Step 2:** Set a Static IP Address : Why? Active Directory needs a fixed IP.
   - In Server Manager > Local Server, click on the current IPv4 address
   - Go to Properties > IPv4 Settings
     
     - IP: 192.168.2.10
     - Masque: 255.255.255.0
     - Gateway: 192.168.2.1
     - Preferred DNS: 127.0.0.1 
     - Alternate DNS: 8.8.8.8 
     - 📸 Capture: (capture Set_ip)

  **Step 3:** Install the Active Directory Domain Services Role
 
   - In Server Manager, click Add roles and features (capture ad role) -> Choose Role-based or feature-based installation -> Select your server (capture select server)
   - Under roles, check Active Directory Domain Services (cature select ADDS)
   - Click Next through to the end and hit Install

 **Step 4:** Promote the Server to Domain Controller

- After AD DS is installed, click the yellow flag in Server Manager
- Click Promote this server to a domain controller (capture promote_server)
- Choose Add a new forest
- Enter a domain name : acpracticelab.local (in my case)
- Leave defaults for forest/domain level and DNS
- Set the DSRM password
- Continue with Next > Install
🔁 The server will automatically restart after promotion.

 **Step 5:** Verify Active Directory Installation

- Open Server Manager
- Go to Tools > Active Directory Users and Computers
- Confirm your domain appears and OUs (Organizational Units) are visible : (capture AD_Verification)

III. **Azure AD & Intune Integration**




