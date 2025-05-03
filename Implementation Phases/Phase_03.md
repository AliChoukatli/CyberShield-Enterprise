# **Phase 3: Helpdesk & Network Troubleshooting**

## 🧰 Prerequisites

- Administrative rights on the local workstation  
- PowerShell 5.1+ installed  
- RDP and/or TeamViewer installed and properly configured  
- Internet access for TeamViewer functionality  

---

## 📌 **Overview**

In this phase, you will simulate key helpdesk and IT support operations, including:

- Reset Passwords & Unlock Accounts (ADUC)

- Remote Support with RDP

- Remote Support with TeamViewer

- Network Troubleshooting: ping

- Network Troubleshooting: ipconfig

- Network Adapter Check (Device Manager)

- Deploy Office 365 via PowerShell

Captures d’écran

Pro Tips 

These tasks mirror real-world Tier 1–2 support responsibilities in enterprise environments.

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

## 🔴 **Remote Support (RDP & TeamViewer)**

 ### 🎯 Objective - Provide remote troubleshooting support using:

- **Remote Desktop Protocol (RDP)** for internal domain-joined machines  
- **TeamViewer** for internet-based or external connections  
---

 ### 🖥️ **Remote Desktop Protocol (RDP)**

1. Open **Remote Desktop Connection**  
2. Enter target hostname or IP (e.g., `ITClient01.corp.aclab.tech`)  
3. Click **Connect**  
4. Enter **domain credentials** when prompted  

🖼️ Screenshot: Remote session showing full control of the remote system

  #### ⚠️  Notes

- Ensure **Remote Desktop** is enabled (`System Properties > Remote`)  
- The user must be part of the **Remote Desktop Users** group  

---

 ### 🖥️ **TeamViewer**

1. Install and launch **TeamViewer** on both support and target machines  
2. Retrieve **Partner ID** and **Password** from the target system  
3. On your support system, enter the **Partner ID** and click **Connect**  
4. Provide password when prompted  

🖼️ Screenshot: TeamViewer active session or Partner ID window

  #### ⚠️  **Notes**

- TeamViewer requires internet on both ends  
- Ensure firewall rules and antivirus are not blocking the session  

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
