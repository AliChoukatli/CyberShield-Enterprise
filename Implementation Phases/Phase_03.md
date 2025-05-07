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

## ✅ Step 3 – Configure RDP Access on Client Machine (ITClient01)

### 🎯 Objective

Grant the `IT-Support-RDP` group Remote Desktop rights on the domain-joined client `CL-WIN01`.

### 🛠️ Method A – Graphical (Computer Management)

1. Log in to `CL-WIN01` as a **local administrator** or **domain admin**  
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
## ✅ Step 4 – Enable and Test RDP on CL-WIN01

### 🎯 Objective  
Enable Remote Desktop on `CL-WIN01` and verify access settings for the domain group.

### 🛠️ Instructions

1. Log in to `CL-WIN01` locally or via Hyper-V  
2. Right-click **This PC** > **Properties**  
3. Click **Remote desktop settings**  
- or go to: `Settings > System > Remote Desktop`  
4. Enable:  
✅ **Allow remote connections to this computer**  
5. *(Optional)* Disable for compatibility:  
❌ **Allow connections only from computers using Network Level Authentication (NLA)**  
6. Click **OK** to apply changes  
7. Open **Computer Management**  
8. Confirm `corp.aclab.tech\IT-Support-RDP` is present in **Remote Desktop Users**

📸 **Screenshot to capture:**  
- Remote Desktop settings enabled  
- Group membership of `Remote Desktop Users` showing `IT-Support-RDP`

---

## ✅ Step 5 – Initiate RDP Session from SRV-DC01

### 🎯 Objective  
Validate that `SRV-DC01` can connect to `CL-WIN01` using the domain account `ali.choukatli`.

### 🛠️ Instructions

1. On `SRV-DC01`, press `Windows + R`, type `mstsc`, and hit **Enter**  
2. In the **Computer** field, enter:  
---

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
