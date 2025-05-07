# **Phase 3: Helpdesk & Network Troubleshooting**

## 🧰 Prerequisites

- Administrative rights on the local workstation  
- PowerShell 5.1+ installed  
- RDP and/or TeamViewer installed and properly configured  
- Internet access for TeamViewer functionality  

---

## 📌 **Overview**

- Set up support tools (RSAT, PowerShell, Remote Assistance, Event Viewer)

- Manage tickets and escalate technical issues

- Network diagnostics: IPConfig, ping, tracert, Netstat, Wireshark (introductory)

- Provide secure and tracked user support

---

## 🔴 **Reset Passwords & Unlock Accounts**

  ### 🎯 Objective
  Assist users who are locked out or need password resets using Active Directory Users and Computers (ADUC).

 1. Open **Active Directory Users and Computers**  
 2. Locate the target user  
 3. Right-click > **Reset Password**

![Reset-passwd](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/Screenshots/Phase%202/reset-password.png)

 4. Enter the new password  
 5. Check **Unlock account** if applicable
 6. OK
---

## 🔴 Remote Desktop Protocol (RDP) – IT Support Access

### Objective
Provide secure remote support from the IT technician workstation (`CL-WIN11-01`) to a domain-joined client (e.g., `ITClient01.corp.aclab.tech`).

### ⚠️ Prerequisites for RDP Access

- ✅ **Enable Remote Desktop** on the target system:  
  `System Properties > Remote > Allow remote connections`

## 🔐 Remote Desktop – Enterprise-Style Group Access Control

### 🎯 Objective  
Simulate how enterprise environments grant RDP access using a **dedicated AD group** and **local group membership** (without assigning local admin rights).

---

### ✅ 1. Create a dedicated AD group: `IT-Support-RDP`

```powershell
New-ADGroup -Name "IT-Support-RDP" -SamAccountName "IT-Support-RDP" -GroupCategory Security -GroupScope Global -Path "OU=Groups,DC=corp,DC=aclab,DC=tech"
```
  🖼️ Screenshot: PowerShell output showing the group creation.


  
- ✅ ** Add user (ali.choukatli) to the IT-Support-RDP group:**
  Add-ADGroupMember -Identity "IT-Support-RDP" -Members "ali.chou"
🖼️ Screenshot: Confirmation in PowerShell or AD Users and Computers showing ali.chou as a member.



### Steps
1. On `CL-WIN11-01`, open **Remote Desktop Connection**
2. Enter the target hostname: `ITClient01.corp.aclab.tech`
3. Click **Connect**
4. Enter domain credentials (e.g., `corp.aclab.tech\jdoe`)
5. Session opens with full desktop control

🖼️ **Screenshot**: Active RDP session from `CL-WIN11-01` to `ITClient01`

---



🖼️ **Screenshot**: User `jdoe` added to Remote Desktop Users group

---

## 🔗 TeamViewer – Remote Support Alternative

### Steps
1. Install and launch TeamViewer on both `CL-WIN11-01` and the target (e.g., `ITClient01`)
2. On `ITClient01`, retrieve the **Partner ID** and **Password**
3. On `CL-WIN11-01`, enter Partner ID, click **Connect**
4. Enter password to gain control

🖼️ **Screenshot**: Active TeamViewer session or Partner ID window

---

### ⚠️ Important Notes
- TeamViewer requires internet access on both systems
- Ensure firewall and antivirus do not block TeamViewer
- RDP should be restricted by firewall or Conditional Access in production

---

## 🔴 **Troubleshoot Network Connectivity**

 ### 🧪 Test 1: Ping Command

1. Open **Command Prompt (CMD)**  
2. Run:

```bash
ping 192.168.2.1
```
3. Analyze response time or packet loss

🖼️ Screenshot: Ping test output showing reply status

### 🧪 Test 2: ipconfig

1- In CMD, run:
```
ipconfig /all
```
2- Review:

- IPv4 Address

- Subnet Mask

- Default Gateway

- DNS Servers

🖼️ Screenshot: ipconfig /all output showing full network configuration
---

## 🔴 **Check Network Adapter via Device Manager**
🎯 Objective - Ensure the physical or virtual network adapter is properly installed and working.

 1. Right-click Start > Device Manager

 2. Expand Network Adapters

 3. Check for:

  - Warnings or disabled state

 - Missing drivers

 4. Right-click > Update driver if needed

🖼️ Screenshot: Device Manager view of network adapter status
---

## 🔴 **Deploy Office 365 via PowerShell**
🎯 Objective - Automate Office 365 installation using a script.

 1. Open PowerShell as Administrator

 2. Run the deployment script:
```
.\DeployOffice365.ps1
```
--> The script silently installs Office 365 in the background

🖼️ Screenshot: Script execution output in PowerShell

#### **⚠️ Notes**
- Ensure the script path is correct and signed if execution policies require it

- Office installation may take several minutes depending on network speed
---

#### 🧠 **Pro Tips**
Use tracert for detailed routing diagnostics:
```
tracert 8.8.8.8
```
- Always check if the firewall or antivirus is blocking RDP or TeamViewer

- Document user actions to reproduce issues quickly

- Use scripts where possible to save time and reduce error

## 🧠 Professional Summary

This phase simulates common Tier 1–2 helpdesk responsibilities:

- **Shared Folder Configuration:** A shared folder `C:\SharedFolders\IT` was created on the Domain Controller (`DC01`) and shared as `\\DC01\IT`, with precise share and NTFS permissions based on AD group membership.
- **Remote Support Tools:** RDP and TeamViewer were set up to simulate internal and remote support sessions.
- **Network Troubleshooting:** Common tools like `ping`, `ipconfig`, and Device Manager were used to resolve connectivity issues.
- **Office 365 Deployment:** A PowerShell script was used to silently install Microsoft 365 from the Technician workstation, simulating automation in software deployment.

These tasks develop essential troubleshooting, remote assistance, and configuration skills for real-world support environments.

