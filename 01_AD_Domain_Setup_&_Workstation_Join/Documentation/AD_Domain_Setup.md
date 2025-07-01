# 🔴 Windows Server 2022 Setup: Active Directory & DHCP

## 🎯 Objective

Establish a Windows Server 2022 machine as a **primary domain controller** and **DHCP server**, forming the foundation of a centralized and secure enterprise network infrastructure.

## 📝 Introduction

This guide walks through the complete installation and configuration of a Windows Server 2022 as a domain controller for your organization. You'll:

- Install the OS and assign a clear server identity
- Configure a **static IP address** to ensure DNS and AD reliability
- Deploy **Active Directory Domain Services (AD DS)** to centralize identity and access management
- Add and configure the **DHCP Server role** to automate IP address distribution

By the end of this section, you’ll have a robust Active Directory and DHCP environment to support future domain-joined client machines and enterprise policy enforcement.

---

## 🧭 **Steps:**

### 🚀 Step 1 – Windows Server 2022 Installation

**🎯 Objective**: Set up the server that will host Active Directory services.

### Instructions

1. Download the official [Windows Server 2022 ISO](https://www.microsoft.com/en-us/evalcenter/download-windows-server-2022).
2. Create a new VM and boot from the ISO.
3. Select the edition: **Standard (Desktop Experience)**.
4. Choose **Custom** installation ➔ Create a new partition ➔ Click **Next**.
5. Set a strong administrator password.

---

### 🚀 Step 2 – Rename the Server

**🎯 Objective**: Assign a clear hostname to the server.

### Instructions

1. Open **Server Manager**.
2. Go to **Local Server**.
3. Click **Computer Name ➔ Change settings ➔ Change ➔ Rename** the server to `DC01`.

   ![Rename Server](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/Screenshots/Day1_Installation_AD/Rename_Server.png)

4. Restart the server to apply the new name.

---

### 🚀 Step 3 – Set a Static IP Address

**🎯 Objective**: Ensure the server uses a fixed IP for Active Directory and DNS stability.

### Instructions

1. In **Server Manager ➔ Local Server**, click the IPv4 address.
2. Go to **Properties ➔ IPv4 Settings** and configure:
   - IP Address: `192.168.2.10`
   - Subnet Mask: `255.255.255.0`
   - Default Gateway: `192.168.2.1`
   - Preferred DNS Server: `127.0.0.1`
   - Alternate DNS Server: `8.8.8.8`

   ![Static IP Settings](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/Screenshots/Day1_Installation_AD/Static_IP.png)

📌 **Ensure IP configuration is consistent across reboots:**  
Setting a static IP address ensures that the server keeps the same IP address even after restarts. This is critical for Active Directory and DNS stability.

## Alternatively (PowerShell):

```powershell
New-NetIPAddress -InterfaceAlias "Ethernet" -IPAddress 192.168.2.10 -PrefixLength 24 -DefaultGateway 192.168.2.1
Set-DnsClientServerAddress -InterfaceAlias "Ethernet" -ServerAddresses ("127.0.0.1", "8.8.8.8")
```

### 🚀 Step 4 – Install Active Directory Domain Services (AD DS)

🎯 **Objective**: Add Active Directory role to the server.

### Instructions
1. In **Server Manager**, click **Add Roles and Features**.
2. Select **Role-based or feature-based installation**.
3. Choose your server from the list.
4. Under **Roles**, check **Active Directory Domain Services**.
5. Proceed with the installation.

🛈 **Note**: After installing the AD DS role, a yellow exclamation mark will appear in Server Manager. This is normal and indicates post-installation tasks are required.

---

### 🚀 Step 5 – Promote the Server to a Domain Controller

🎯 **Objective**: Create a new Active Directory forest.

### Instructions
1. After installing AD DS, click the yellow flag ➔ **Promote this server to a domain controller**.
   
   ![Promote](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/Screenshots/Day1_Installation_AD/Promote_server.png)
   
3. Select **Add a new forest**.
4. Enter your domain name (e.g., `corp.aclab.tech`).
5. Keep default **Forest** and **Domain functional levels**.
6. Configure the **DSRM password**.

   ![DSRM](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/Screenshots/Day1_Installation_AD/DSRM_password.png)
   
8. Complete the wizard and install.

🔁 **The server will automatically reboot after promotion.**

---

### 🚀 Step 6 – Verify Active Directory Installation
🎯 **Objective**: Confirm successful Active Directory deployment.

### Instructions
1. Open **Server Manager ➔ Tools ➔ Active Directory Users and Computers**.
2. Verify:
   - Your domain name appears (`corp.aclab.tech`).
   - Default **Organizational Units (OUs)** are visible.
  
   ![AD_Verification](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/Screenshots/Day1_Installation_AD/AD_verification.png)

---

### 🚀 Step 7 : install DHCP Server 

1. In Server Manager, click Add Roles and Features.
2. Select Role-based or feature-based installation.
3. Choose your server from the list.
4. Under Roles, check DHCP Server
   
![DHCP_Role](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/Screenshots/Day1_Installation_AD/dhcp_server.png)

5. Proceed with the installation.
6. Click on Complete DHCP Configuration
   
![DHCP_installation](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/Screenshots/Day1_Installation_AD/dhcp_complete.png)

6. Autorize DHCP to Active Directory -> Next
7. Put your scope ( in my case i chose to put : (192.168.2.100 - 192.168.2.200)
   
![DHCP_Scope](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/Screenshots/Day1_Installation_AD/DHCP_Scope.png)

8. Configure DHCP -> Yes i want to configure these option now
9. Add a Gateaway address (if you have one)
10. On the DHCP window, click on DHCP Pool you can see your scope
    
![DHCP_Pool](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/Screenshots/Day1_Installation_AD/dhcp_pool.png)

---

## 🔚 Conclusion

At the end of this initial configuration:

- The server is ready to operate as a **domain controller (DC01)**.
- The **Active Directory service** is functional with an established domain (`corp.aclab.tech`).
- A **dynamic DHCP scope** is configured to automatically assign IP addresses to network clients.

This setup lays the groundwork for advanced deployments, including centralized identity management, group policy enforcement, endpoint protection, and integration with tools like **Microsoft Defender** and **Microsoft Sentinel**.
