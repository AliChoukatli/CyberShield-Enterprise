# Phase 1: Environment Setup – Windows 11 Clients, Active Directory & Networking

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


## Overview

In this phase, you will:

- Install and configure 2–3 Windows 11 client VMs.
- Install Windows Server 2022 for Active Directory setup.
- Configure static IP addresses.
- Promote the server to a Domain Controller.
- Verify Active Directory installation.

---

# 🔴 Step 1 – Windows 11 Client Machines

**Objective**: Install and prepare Windows 11 machines for later domain joining.

### Instructions:

1. Download the official [Windows 11 ISO](https://www.microsoft.com/en-us/software-download/windows11).
2. Create a new VM and boot from the ISO.
3. On the setup screen, select `Install now`.
   
   🖼️ **Screenshot**: Installation screen (`Install now` button).

4. Select `Custom` installation.
5. Create a new partition as needed ➔ click `Next`.
   
   🖼️ **Screenshot**: Partition creation screen.

6. Wait for Windows installation to complete.
   
   🖼️ **Screenshot**: Installation in progress.

7. Choose your region and keyboard layout.

8. Select `Join Domain Instead` (do not sign in with a Microsoft account).
   
   🖼️ **Screenshot**: "Join Domain Instead" option.

9. Create a local user account:
   - Set a username.
   - Set a strong password.

10. For privacy settings, choose `Required only` ➔ Accept.

11. The system will finalize setup ("Preparing your PC" screen).
   
    🖼️ **Screenshot**: "Preparing your PC" screen.

12. Once at the desktop, proceed to rename the machine:
    - Settings ➔ System ➔ About ➔ `Rename this PC`.
    - Example: `WIN11-01`.

    🖼️ **Screenshot**: Rename computer screen.

13. Restart the VM to apply the new hostname.

    🖼️ **Screenshot**: Confirmation after rename.

### Notes:

- Create **2–3** Windows 11 VMs.
- Do **NOT** join them to Azure AD or local domain yet (planned for Phase 3).
- Enable RDP and optionally install TeamViewer for remote support simulation.

---

# 🔴 Step 2 – Windows Server 2022 Installation

**Objective**: Set up the server that will host Active Directory services.

### Instructions:

1. Download [Windows Server 2022 ISO](https://www.microsoft.com/en-us/evalcenter/download-windows-server-2022).
2. Create a new VM and boot from the ISO.
3. Select the version: `Standard (Desktop Experience)`.
4. Choose `Custom` installation ➔ Create a new partition ➔ Click `Next`.
5. Set a strong administrator password.

    🖼️ **Screenshot**: First Server Manager screen after installation.

---

# 🔴 Step 3 – Rename the Server

**Objective**: Assign a clear hostname to the server.

### Instructions:

1. Open **Server Manager**.
2. Go to **Local Server**.
3. Click the current computer name ➔ `Change` ➔ Rename to something like `DC01`.
   
   🖼️ **Screenshot**: Computer rename dialog.

4. Restart the server to apply the new name.

---

# 🔴 Step 4 – Set a Static IP Address

**Objective**: Ensure the server uses a fixed IP for Active Directory and DNS stability.

### Instructions:

1. In **Server Manager ➔ Local Server**, click the IPv4 address.
2. Go to **Properties ➔ IPv4 Settings**:
   - IP Address: `192.168.2.10`
   - Subnet Mask: `255.255.255.0`
   - Default Gateway: `192.168.2.1`
   - Preferred DNS: `127.0.0.1`
   - Alternate DNS: `8.8.8.8`

    🖼️ **Screenshot**: Static IP configuration screen.

3. Alternatively, configure via PowerShell:
```powershell
New-NetIPAddress -InterfaceAlias "Ethernet" -IPAddress 192.168.2.10 -PrefixLength 24 -DefaultGateway 192.168.2.1
Set-DnsClientServerAddress -InterfaceAlias "Ethernet" -ServerAddresses ("127.0.0.1", "8.8.8.8")
```

# 🔴 Step 5 – Install Active Directory Domain Services (AD DS)

**Objective**: Add Active Directory role to the server.

### Instructions:

1. In **Server Manager**, click **Add Roles and Features**.
2. Select **Role-based or feature-based installation**.
3. Choose your server from the list.
4. Under **Roles**, check **Active Directory Domain Services**.

    🖼️ **Screenshot**: Selecting AD DS role.

5. Proceed with the installation.

---

# 🔴 Step 6 – Promote the Server to a Domain Controller

**Objective**: Create a new Active Directory forest.

### Instructions:

1. After installing AD DS, click the yellow flag ➔ **Promote this server to a domain controller**.
2. Select **Add a new forest**.
3. Enter your domain name (e.g., `corp.aclab.tech`).
4. Keep default **Forest** and **Domain functional levels**.
5. Configure the **DSRM password**.

    🖼️ **Screenshot**: Domain controller promotion screen.

6. Complete the wizard and install.

🔁 **The server will automatically reboot after promotion.**

---

# 🔴 Step 7 – Verify Active Directory Installation

**Objective**: Confirm successful Active Directory deployment.

### Instructions:

1. Open **Server Manager ➔ Tools ➔ Active Directory Users and Computers**.
2. Verify:
   - Your **domain name** appears.
   - Default **Organizational Units (OUs)** are visible.

    🖼️ **Screenshot**: Active Directory Users and Computers overview.

---

# ✅ Phase 1 Summary

At the end of Phase 1, you should have:

- ✔️ Windows Server 2022 installed and renamed.
- ✔️ Static IP configuration completed.
- ✔️ Active Directory Domain Services installed and configured.
- ✔️ Domain created (`aclab.tech`).
- ✔️ 2–3 Windows 11 client machines ready for domain join in future phases.

You are now ready to proceed to **Phase 2: Active Directory User Management**.

