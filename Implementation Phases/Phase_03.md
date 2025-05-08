# **Phase 3: Helpdesk & Network Troubleshooting**

## 🧰 Prerequisites

* Administrative rights on the local workstation
* PowerShell 5.1+ installed
* RDP and/or TeamViewer installed and properly configured
* Internet access for TeamViewer functionality

---

## 📌 Overview

This phase simulates professional IT support practices in a small enterprise, covering remote assistance, user account management, network diagnostics, and software deployment.

* Install and configure support tools (RSAT, PowerShell, Remote Access)
* Resolve user account issues via Active Directory
* Secure Remote Desktop Protocol (RDP) setup using domain groups
* Remote support via TeamViewer as an alternative
* Network connectivity diagnostics and troubleshooting
* Automate Microsoft 365 deployment via PowerShell

---

## ✅ Step 1 – Reset User Passwords & Unlock Accounts

### 🎯 Objective

Assist users who are locked out or need password resets using Active Directory Users and Computers (ADUC).

1. Open **Active Directory Users and Computers**
2. Locate the target user account
3. Right-click > **Reset Password**
   
![Reset-Password](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/Screenshots/Phase%20%203/reset-password.png)
   
4. Enter the new password and confirm it
5. Check **Unlock account** if applicable
6. Click **OK** to apply




## ✅ Step 2 – Prepare Active Directory Group for RDP Access

### 🎯 Objective

Create a domain security group for IT support staff to manage RDP permissions centrally.

1. Open **Active Directory Users and Computers**
2. Create a new **security group**:

   * Name: `IT-Support-RDP`
   * Scope: Global
   * Type: Security
3. Add support team users to the group (e.g., `ali.choukatli`)

![RDP-Member](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/Screenshots/Phase%20%203/RDP_groupe.png)

---

## ✅ Step 3 – Enable Remote Desktop on LTP-EMP01

### 🎯 Objective  
Enable Remote Desktop on `LTP-EMP01` and verify access settings for the domain group.

### 🛠️ Instructions

1. Log in to LTP-EMP01 as an Administrator.

2. Open Settings (Win + I)

3. Navigate to:
System > Remote Desktop

4. Toggle ON the switch next to:
Remote Desktop

![RDP-Enable](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/Screenshots/Phase%20%203/RDP_enable.png)
 
---

## ✅ Step 4 –  Configure RDP Permissions on Target Machine (LTP-EMP01)

### 🎯 Objective

Grant the `IT-Support-RDP` group Remote Desktop rights on the domain-joined client `CL-WIN11-02`.

### 🛠️ Method A – Graphical (Computer Management)

1. Log in to `LTP-EMP01` as a **local administrator** or **domain admin**  
2. Press `Windows + R`, type `compmgmt.msc`, and hit **Enter**  
3. Navigate to:  System Tools > Local Users and Groups > Groups
4. Double-click on **Remote Desktop Users**  
5. Click **Add...**, then enter:  
corp.aclab.tech\IT-Support-RDP

6. Click **Check Names** to validate, then click **OK**

![RDP-Member](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/Screenshots/Phase%20%203/RDP_member.png)

---

### Method B – PowerShell

Run the following as Administrator:

```powershell
Add-LocalGroupMember -Group "Remote Desktop Users" -Member "corp.aclab.tech\IT-Support-RDP"
```



---

---

## ✅ Step 5 – Initiate RDP Session from LTP-HLP01

### 🎯 Objective  
Verify remote access works using domain credentials from the support workstation.

### 🛠️ Instructions

1. On `LTP-HLP01`, press `Windows + R`, type `mstsc`, and hit **Enter**  
2. In the **Computer** field, enter:
   LTP-EMP01.corp.aclab.tech

3. Click **Show Options**  
4. In the **Username** field, enter:  
corp.aclab.tech\sophia.martinez

![RDP-Before](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/Screenshots/Phase%20%203/RDP_before.png)

6. Click **Connect**  
7. Enter the password when prompted  
8. A successful RDP session confirms that access is working

![RDP-After](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/Screenshots/Phase%20%203/RDP-After.png)

---

### ✅ **If you are unable to connect to a target machine via Remote Desktop Protocol (RDP), follow this structured checklist to identify and resolve the issue.**

## 1. 🔌 Check Network Connectivity

Confirm that the target machine is reachable from the source (e.g., Helpdesk PC or Server):

```powershell
ping <ComputerName or IP>
Test-NetConnection -ComputerName <Target> -Port 3389
```
2. Check if Remote Desktop Enabled (on target machine)
Ensure RDP is properly enabled:
```powershell
Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server" -Name "fDenyTSConnections" -Value 0
```
Enable required firewall rules:
```powershell
Enable-NetFirewallRule -DisplayGroup "Remote Desktop"
Enable-NetFirewallRule -Name FPS-ICMP4-*
```powershell
```

## ✅ Step 6 – Remote Support with TeamViewer

### 🎯 Objective

Provide internet-based support when RDP is not available.

1. Install TeamViewer on both `CL-WIN11-01` and `ITClient01`
2. On technician device, enter **Partner ID** of client and connect
3. Enter provided **password** to initiate session

🖼️ Screenshot: TeamViewer Partner ID and session prompt

### ⚠️ Notes

* Ensure internet access is available
* Allow TeamViewer through firewalls and AV solutions
* Disable unattended access when not in use

---

## ✅ Step 7 – Troubleshoot Network Connectivity

### Test 1 – Ping

```bash
ping 192.168.2.1
```

🖼️ Screenshot: Ping result

### Test 2 – IP Configuration

```bash
ipconfig /all
```

🖼️ Screenshot: Network config output

---

## ✅ Step 8 – Inspect Network Adapter Status

### 🎯 Objective

Verify the NIC is functioning properly.

1. Open **Device Manager**
2. Expand **Network Adapters**
3. Check for issues: warning icons, missing drivers
4. Right-click > **Update driver** if needed

🖼️ Screenshot: NIC status in Device Manager

---

## ✅ Step 9 – Deploy Microsoft 365 via PowerShell

### 🎯 Objective

Automate Microsoft 365 installation from the support workstation.

1. Open PowerShell as Administrator
2. Run deployment script:

```powershell
.\DeployOffice365.ps1
```

🖼️ Screenshot: Script execution

### ⚠️ Notes

* Ensure execution policy allows script
* Validate script path
* Internet speed affects duration

---

## 🧠 Pro Tips

* Use `tracert 8.8.8.8` to trace network routes
* Keep RDP restricted using Conditional Access and firewalls
* Use PowerShell for repeatable support tasks
* Maintain documentation for escalated issues

---

## 📌 Professional Summary

Phase 3 simulated real-world Helpdesk & Tier 1/2 support scenarios:

* 🔐 Remote support via RDP and TeamViewer
* 👤 Active Directory management for user lockouts
* 🌐 Network diagnostics using CLI tools and Device Manager
* 💻 Microsoft 365 deployment with PowerShell automation

✅ These are core operational skills for IT Support & Helpdesk professionals in enterprise settings.
