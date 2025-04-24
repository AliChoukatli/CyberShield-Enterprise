# **Day 5: Helpdesk & Network Troubleshooting**

## 🧰 Prerequisites
- Administrative rights on the local machine.
- PowerShell 5.1+ installed for running scripts.

## Overview
This day covers common IT support tasks such as troubleshooting network issues and remote support using tools like TeamViewer and Remote Desktop. Additionally, we will deploy Office 365 using PowerShell scripts.

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

