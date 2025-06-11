## ✅ **3.2 – Remote Support via RDP**

### 📌 **Prepare Active Directory Group for RDP Access**

#### 🎯 Objective : *Create a domain security group for IT support staff to manage RDP permissions centrally.*

1. Open **Active Directory Users and Computers**
2. Create a new **security group**:

   * Name: `IT-Support-RDP`
   * Scope: Global
   * Type: Security
3. Add support team users to the group (e.g., `ali.choukatli`)

![RDP-Member](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/Screenshots/Phase%20%203/RDP_groupe.png)

---

### 📌 **Enable Remote Desktop on LTP-EMP01**

#### 🎯 Objective : *Enable Remote Desktop on `LTP-EMP01` and verify access settings for the domain group.*

### 🛠️ Instructions

1. Log in to LTP-EMP01 as an Administrator.

2. Open Settings (Win + I)

3. Navigate to:
System > Remote Desktop

4. Toggle ON the switch next to:
Remote Desktop

![RDP-Enable](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/00_IT_Support_%26_Helpdesk/Screenshots/RDP_enable.png)
 
---

### 📌 **Configure RDP Permissions on Target Machine (LTP-EMP01)**

#### 🎯 *Objective : Grant the `IT-Support-RDP` group Remote Desktop rights on the domain-joined client `LTP-EMP01`.*

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

### 🛠️ **Method B – PowerShell**

Run the following as Administrator:

```powershell
Add-LocalGroupMember -Group "Remote Desktop Users" -Member "corp.aclab.tech\IT-Support-RDP"
```
---

#### 📌 **PowerShell Script to Add "IT-Support-RDP" to "Remote Desktop Users" on Multiple Machines**

```powershell
# List of computers
$computers = @("Machine1", "Machine2", "Machine3")

foreach ($computer in $computers) {
    # Add the group to the "Remote Desktop Users" group
    Invoke-Command -ComputerName $computer -ScriptBlock {
        Add-ADGroupMember -Identity "Remote Desktop Users" -Members "corp.aclab.tech\IT-Support-RDP"
    } -Credential (Get-Credential)
}

# computers: Declares a list of remote machines where the script will be applied.
# Invoke-Command: Runs the command remotely on each machine in the list.
# Add-ADGroupMember: Adds the "IT-Support-RDP" group to the local "Remote Desktop Users" group on each machine.
# Credential (Get-Credential): Prompts for credentials required to connect to each remote machine.
```
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
### 2. **Check if Remote Desktop Enabled (on target machine)**
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
