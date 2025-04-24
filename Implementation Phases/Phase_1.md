# Day 1: Setup – Win11 - AD - Network

# 🧰 Prerequisites
Before starting the configuration, ensure the following prerequisites are met:
- A **Windows machine** with administrative rights.
- **Internet access** for downloading necessary files and updates.
- **PowerShell 5.1+** installed for running automation scripts.
- The **`install.xml` file** must be present in the same directory as the script.
- A **Microsoft 365 account** with a valid license (e.g., **Business Premium**).

# Overview
This section covers the steps taken :

**Step 1**
 **(Windows 11 Client Machines)**
   - Download the official Windows 11 ISO from Microsoft.
   - Install 2–3 VMs with Windows 11.
   - Do **not** join them to Azure AD yet (planned for Phase 3).
   - Enable RDP and consider TeamViewer for support simulation.
   - Screenshots to take: installation, initial setup, machine naming.


**Step 2**
  **Windows Server Installation**
   - [🔽Download Windows Server 2022 ISO](https://www.microsoft.com/fr-fr/evalcenter/download-windows-server-2022)
   - Choose The version (Standard Desktop Experience)
   - Choose Custom → "New":
   - Choose the size of the partition you need -> Apply -> Next
   - Choose a Strong Password -> Next
   - [You should see the Server Manager](https://github.com/AliChoukatli/SecureIT-for-SMB/blob/main/Screenshots/Day1_Installation_AD/win_serv_1st_screen.png)
     
**Step 3** **Active Directory Setup**
   - Rename the Server : Why? A clear hostname helps with admin tasks and scripting.
   - Open Server Manager
   - Click on Local Server
   - Click the name next to Computer Name -> Click Change and rename it to something like (SRV-AD-01) -> Restart the computer
   - 📸 [Steps](https://github.com/AliChoukatli/SecureIT-for-SMB/blob/main/Screenshots/Day1_Installation_AD/Capture_name.png)
     
**Step 4** Setting a Static IP Address : Why? Active Directory needs a fixed IP.
   - In Server Manager > Local Server, click on the current IPv4 address
   - [Go to Properties > IPv4 Settings](https://github.com/AliChoukatli/SecureIT-for-SMB/blob/main/Screenshots/Day1_Installation_AD/Set_ip.png)(Example)
     - IP: 192.168.2.10
     - Subnet mask: 255.255.255.0
     - Gateway: 192.168.2.1
     - Preferred DNS: 127.0.0.1 
     - Alternate DNS: 8.8.8.8
   - You can set your static IP with Powershell
     ```
     New-NetIPAddress -InterfaceAlias "Ethernet" -IPAddress 192.168.2.10 -PrefixLength 24 -DefaultGateway 192.168.2.1
     Set-DnsClientServerAddress -InterfaceAlias "Ethernet" -ServerAddresses ("127.0.0.1","8.8.8.8")
     ```

 **Step 5:** Install the Active Directory Domain Services Role
 
   - [In Server Manager, click Add roles and features](https://github.com/AliChoukatli/SecureIT-for-SMB/blob/main/Screenshots/Day1_Installation_AD/AD_add_role.png)
   - Choose Role-based or feature-based installation ->
   - [Select your server (capture select server](https://github.com/AliChoukatli/SecureIT-for-SMB/blob/main/Screenshots/Day1_Installation_AD/Select_server.png)
   - [Under roles, check Active Directory Domain Services](https://github.com/AliChoukatli/SecureIT-for-SMB/blob/main/Screenshots/Day1_Installation_AD/select_ADDS.png)
   - Click Next through to the end and hit Install

 **Step 6:** Promote the Server to Domain Controller

- After AD DS is installed, click the yellow flag in Server Manager
- [Click Promote this server to a domain controller](https://github.com/AliChoukatli/SecureIT-for-SMB/blob/main/Screenshots/Day1_Installation_AD/Promote_server.png))
- Choose Add a new forest
- Enter a domain name : acpracticelab.local (in my case)
- Leave defaults for forest/domain level and DNS
- Set the DSRM password
- Continue with Next > Install
🔁 The server will automatically restart after promotion.

 **Step 7:** Verify Active Directory Installation

- Open Server Manager
- Go to Tools > Active Directory Users and Computers
- [Confirm your domain appears and OUs (Organizational Units) are visible](https://github.com/AliChoukatli/SecureIT-for-SMB/blob/main/Screenshots/Day1_Installation_AD/AD_verification.png)



## ✅ Summary – Day 1
At the end of Day 1, your environment should have:
- A Windows Server 2022 machine installed and configured
- A static IP set (192.168.2.10 in this case)
- Active Directory installed and promoted with domain `acpracticelab.local`
- You are ready to move forward to Azure AD & Intune integration (Day 2)

