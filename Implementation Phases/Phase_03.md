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

## 🖥️ Remote Desktop Access Configuration – Enterprise-Style (RDP)

This section simulates a professional Remote Desktop setup where IT support personnel can securely access user workstations using domain-based group permissions.

---

### ✅ Part 1 – Active Directory Preparation (Domain Controller)

#### 🎯 Objective:
Create a dedicated group for IT support staff and assign relevant users. This group will later be granted remote access rights on workstations.

#### 🛠️ Steps:

1. **Create a new security group** in Active Directory:
   - Name: `IT-Support-RDP`
   - Scope: Global
   - Type: Security

2. **Add members to the group**:
   - Example user: `ali.chou`

#### ✅ Outcome:
The group `IT-Support-RDP` contains the IT staff who will be granted RDP access across selected domain-joined machines.

🖼️ **Screenshot to take**:
- ADUC showing the `IT-Support-RDP` group with members (e.g., `ali.chou`)

---

### ✅ Part 2 – Client Machine Configuration (ITClient01)

#### 🎯 Objective:
Grant the `IT-Support-RDP` domain group the ability to initiate Remote Desktop connections to the local machine `ITClient01`.

#### 🛠️ Method A – Graphical (Computer Management):

1. Log in to **ITClient01** with local or domain administrator rights.
2. Open **Computer Management**:
   - Press `Windows + R` → type `compmgmt.msc` → press **Enter**
3. Navigate to:
System Tools > Local Users and Groups > Groups
4. Double-click on **Remote Desktop Users**
5. Click **Add...**
6. In the object name field, enter:
 corp.aclab.tech\IT-Support-RDP
7. Click **Check Names** → then **OK**

🖼️ **Screenshot to take**:
- `Remote Desktop Users` group window showing `corp.aclab.tech\IT-Support-RDP` listed.

---

#### 🛠️ Method B – PowerShell (alternative):

Open an elevated PowerShell session on **ITClient01** and run:

```powershell
Add-LocalGroupMember -Group "Remote Desktop Users" -Member "corp.aclab.tech\IT-Support-RDP"
```
🖼️ Screenshot to take:

PowerShell window confirming successful execution

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

