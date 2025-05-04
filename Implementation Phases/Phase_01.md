# Phase 1:  Installation & Domain Join

---

## ⚙️ Prerequisites

Before starting **Phase 1**, ensure you meet the following requirements:

- ✅ A host machine with at least 8 GB RAM and virtualization enabled (BIOS/UEFI).
- ✅ Windows 11 ISO (64-bit).
- ✅ Windows Server 2022 ISO.
- ✅ Internet access (ports 80/443 open).
- ✅ PowerShell 5.1 or later installed (`$PSVersionTable.PSVersion`).
- ✅ Microsoft 365 Business Premium subscription (includes Azure AD P1 and Intune).
- ✅ Virtualization platform: Hyper-V, VMware, or VirtualBox.
- ✅ Local administrative privileges.

---

## 🛠️ Overview

In this phase, you will:

- Install and configure 2–3 Windows 11 client VMs.
- Install Windows Server 2022 for Active Directory setup.
- Configure static IP addresses.
- Promote the server to a Domain Controller.
- Verify Active Directory installation.

---

# 🔴 Step 1 – Windows 11 Client Machines

**🎯 Objective**: Install and prepare Windows 11 machines for later domain joining.

### Instructions

1. Download the official [Windows 11 ISO](https://www.microsoft.com/en-us/software-download/windows11).
2. Create a new VM and boot from the ISO.
3. Select **Install now** on the setup screen.
4. Choose **Custom** installation ➔ Create a new partition ➔ Click **Next**.

   ![Create Partition](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/Screenshots/Day1_Installation_AD/Create_Partition.png)

5. Wait for Windows installation to complete.
6. Choose your region and keyboard layout.
7. Select **Join Domain Instead** (do not sign in with a Microsoft account).

   ![Join Domain](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/Screenshots/Day1_Installation_AD/join%20domain.png)

8. Create a local user account:
   - Username
   - Strong password
9. For privacy settings, choose **Required only** ➔ Accept.
10. The system will finalize setup ("Preparing your PC" screen).

    ![Preparing PC](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/Screenshots/Day1_Installation_AD/preparing%20pc.png)

11. Once at the desktop, rename the machine:
    - **Settings ➔ System ➔ About ➔ Rename this PC** (e.g., `WIN11-01`).

    ![Rename Windows 11 PC](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/Screenshots/Day1_Installation_AD/rename_win11.png)

12. Restart the VM to apply the new hostname.

    ![Rename Confirmation](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/Screenshots/Day1_Installation_AD/rename_confirmation.png)

---

### 📌 Notes:
- Create **2–3** Windows 11 VMs.
- **Do not** join them to Azure AD or local domain yet (planned for Phase 3).
- Enable RDP and optionally install TeamViewer for remote support simulation.

---

# 🔴 Step 2 – Windows Server 2022 Installation

**🎯 Objective**: Set up the server that will host Active Directory services.

### Instructions

1. Download the official [Windows Server 2022 ISO](https://www.microsoft.com/en-us/evalcenter/download-windows-server-2022).
2. Create a new VM and boot from the ISO.
3. Select the edition: **Standard (Desktop Experience)**.
4. Choose **Custom** installation ➔ Create a new partition ➔ Click **Next**.
5. Set a strong administrator password.

---

# 🔴 Step 3 – Rename the Server

**🎯 Objective**: Assign a clear hostname to the server.

### Instructions

1. Open **Server Manager**.
2. Go to **Local Server**.
3. Click **Computer Name ➔ Change settings ➔ Change ➔ Rename** the server to `DC01`.

   ![Rename Server](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/Screenshots/Day1_Installation_AD/Rename_Server.png)

4. Restart the server to apply the new name.

---

# 🔴 Step 4 – Set a Static IP Address

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

## 🔴 Step 5 – Install Active Directory Domain Services (AD DS)
🎯 **Objective**: Add Active Directory role to the server.

### Instructions
1. In **Server Manager**, click **Add Roles and Features**.
2. Select **Role-based or feature-based installation**.
3. Choose your server from the list.
4. Under **Roles**, check **Active Directory Domain Services**.
5. Proceed with the installation.

🛈 **Note**: After installing the AD DS role, a yellow exclamation mark will appear in Server Manager. This is normal and indicates post-installation tasks are required.

---

## 🔴 Step 6 – Promote the Server to a Domain Controller
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

## 🔴 Step 7 – Verify Active Directory Installation
🎯 **Objective**: Confirm successful Active Directory deployment.

### Instructions
1. Open **Server Manager ➔ Tools ➔ Active Directory Users and Computers**.
2. Verify:
   - Your domain name appears (`corp.aclab.tech`).
   - Default **Organizational Units (OUs)** are visible.
  
   ![AD_Verification](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/Screenshots/Day1_Installation_AD/AD_verification.png)

---

## 🧠 Summary **Step 1 - Installation & Domain Join**

This phase covers the initial setup of the server and workstation environment in a secure domain-based structure:

- **Windows Server 2022 Configuration:** A Domain Controller (`DC01`) was installed and configured with Active Directory Domain Services (AD DS) for the domain `corp.aclab.tech`.
- **Workstation Installation:** A Windows 11 Pro machine (`Win11-Tech`) was installed to simulate an end-user or IT technician system.
- **Domain Join:** The Windows 11 workstation was joined to the `corp.aclab.tech` domain, enabling centralized identity and device management from the Domain Controller.

These steps simulate real-world onboarding of new devices into an enterprise Active Directory environment.

