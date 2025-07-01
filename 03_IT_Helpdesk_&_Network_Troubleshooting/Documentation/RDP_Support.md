# 🖥️ Secure RDP Access for IT Support

## 🎯 Objective

Create and configure a domain security group to centrally manage Remote Desktop access for IT support personnel, enabling secure and restricted remote connections to domain-joined workstations.

## 📝 Introduction

This section covers how to securely enable and manage Remote Desktop Protocol (RDP) access for support staff within a domain environment. By creating a dedicated Active Directory security group (`IT-Support-RDP`) and applying permissions centrally, we ensure consistent, controlled, and auditable access to client machines such as `LTP-EMP01`.

You'll learn how to activate RDP, assign group permissions locally or via PowerShell, and test connectivity using domain credentials — all following enterprise best practices.

---

## **Remote Support via RDP**


### 📌 **Enable Remote Desktop on LTP-EMP01**

#### 🎯 Objective : *Enable Remote Desktop on `LTP-EMP01` and verify access settings for the domain group.*

### 🛠️ Instructions

1. Log in to LTP-EMP01 as an Administrator.

2. Open Settings (Win + I)

3. Navigate to:
System > Remote Desktop

4. Toggle ON the switch next to:
Remote Desktop

![RDP-Enable](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/03_IT_Helpdesk_%26_Network_Troubleshooting/Screenshots/RDP_enable.png)
 
---

###  📌 **Initiate RDP Session from LTP-HLP01**

#### 🎯 Objective: *Verify remote access works using domain credentials from the support workstation.*

### 🛠️ Instructions

1. On `LTP-HLP01`, press `Windows + R`, type `mstsc`, and hit **Enter**  
2. In the **Computer** field, enter:
   LTP-EMP01.corp.aclab.tech

3. Click **Show Options**  
4. In the **Username** field, enter:  
corp.aclab.tech\ali.choukatli

![RDP-Before](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/Screenshots/Phase%20%203/RDP_before.png)

6. Click **Connect**  
7. Enter the password when prompted  
8. A successful RDP session confirms that access is working

![RDP-After](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/Screenshots/Phase%20%203/RDP-After.png)

---

## 🔴 **If you are unable to connect to a target machine via Remote Desktop Protocol (RDP)**

### 1. **Check Network Connectivity**

Confirm that the target machine is reachable from the source (e.g., Helpdesk PC or Server):

```powershell
ping <ComputerName or IP>
Test-NetConnection -ComputerName <Target> -Port 3389
```
### 2. ** Verify RDP Settings and Firewall Rules (on target machine)**

Ensure RDP is properly enabled:
```powershell
Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server" -Name "fDenyTSConnections" -Value 0
```
Enable required firewall rules:
```powershell
Enable-NetFirewallRule -DisplayGroup "Remote Desktop"
Enable-NetFirewallRule -Name FPS-ICMP4-*
netsh advfirewall firewall add rule name="Allow ICMPv4-In" protocol=icmpv4:8,any dir=in action=allow
```
🛡️ Security Best Practice: Avoid exposing RDP to the internet. Use VPN or restrict RDP access via firewall rules (IP allowlist).

---

## 🔚 Conclusion

After completing this section:
- Remote Desktop is successfully enabled on the client workstation.
- Domain users from the IT-Support-RDP group (whose RDP access is managed by Group Policy from Chapter 2.4) can now remotely connect to workstations (e.g., LTP-EMP01) using secure credentials.
- Key troubleshooting steps for RDP connectivity were reviewed.

This confirms a secure and manageable remote support setup in your AD environment

