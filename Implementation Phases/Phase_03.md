# **Phase 3: Helpdesk & Network Troubleshooting**

## 🧰 Prerequisites
- Administrative rights on the local machine.
- PowerShell 5.1+ installed for running scripts.

## Overview
This day covers common IT support tasks such as troubleshooting network issues and remote support using tools like TeamViewer and Remote Desktop. Additionally, we will deploy Office 365 using PowerShell scripts.

 
 ## 🛠️ Remote Support (RDP & TeamViewer)
 
 * **RDP**: Open Remote Desktop > Enter target hostname/IP > Login with admin credentials
 * **TeamViewer**: Launch both ends > Input Partner ID > Connect
 ### 🎯 Objective
 Simulate IT Helpdesk remote support by connecting to another device using Remote Desktop Protocol (RDP) and TeamViewer. This is a key support function in real-world environments for troubleshooting user issues without being physically present.
 
 ---
 
 ### 🔧 Steps
 
 #### 📡 Remote Desktop Protocol (RDP)
 1. On your main workstation, open the **Remote Desktop Connection** tool.
 2. Enter the target computer's **hostname or IP address** (example: `ITClient01.corp.aclab.tech`).
 3. Click **Connect**.
 4. When prompted, enter **admin credentials** (domain user with RDP rights).
 5. The remote session should open, giving you control of the target machine.
 
 #### 💻 TeamViewer
 1. Install and launch **TeamViewer** on both the support and target computers.
 2. On the target computer, retrieve the **Partner ID** and **password**.
 3. On your support machine, enter the **Partner ID**, then click **Connect**.
 4. Enter the password when prompted to establish the remote session.
 
 ---
 
 ### 🖼️ Screenshots to Capture
 
 - ✅ RDP session active (showing the remote desktop interface).
 - ✅ TeamViewer connection window (showing the Partner ID screen or an active session).
 
 ---
 
 ### 🔐 Notes
 
 - Ensure **Remote Desktop** is enabled on the target machine (via `System Properties > Remote` tab).
 - The user account must be in the **Remote Desktop Users** group or have local admin rights.
 - TeamViewer requires internet access and both clients must be online for the session to work.
 
 ---
 
 **📸 Screenshots:**
 
 * RDP session open
 * TeamViewer connection prompt

### **Step 1: Troubleshoot Network Connectivity**
- **Ping Test:** 
    - Open Command Prompt (CMD) and run:
      ```bash
      ping 192.168.2.1
      ```
      - Verify if the server responds.
      - If it does not, check the server’s network settings.
      
    - 📸 Screenshot: CMD output for Ping Test.

### **Step 2: Use Device Manager for Network Issues**
- Open **Device Manager** and check if the network adapter is functioning properly.
- Right-click the adapter and choose **Update driver** if necessary.
  
    - 📸 Screenshot: Device Manager showing network adapter status.

### **Step 3: Remote Support Using TeamViewer**
- Install **TeamViewer** and use it to troubleshoot remote machines.
  
    - 📸 Screenshot: TeamViewer window connected to a remote machine.

### **Step 4: Troubleshoot Network with `ipconfig`**
- Open CMD and run:
    ```bash
    ipconfig /all
    ```
    - Check for the correct IP address, subnet mask, and gateway.
  
    - 📸 Screenshot: `ipconfig` output showing network configuration.

### **Step 5: Deploy Office 365 Using PowerShell**
- Run the PowerShell script:
    ```powershell
    .\DeployOffice365.ps1
    ```
    - This will silently install Office 365 on the client machine.

    - 📸 Screenshot: PowerShell script execution.

## Pro Tips:
- Ensure that Remote Desktop is enabled and properly configured on the machine.
- Use `tracert` for more advanced network troubleshooting.
**

