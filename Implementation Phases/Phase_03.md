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

## **3.1 – Active Directory User Support**

### ✅ Reset User Passwords & Unlock Accounts

### 🎯 Objective

Assist users who are locked out or need password resets using Active Directory Users and Computers (ADUC).

Steps:

1. Open **Active Directory Users and Computers**
2. Locate the target user account
3. Right-click > **Reset Password**
   
![Reset-Password](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/Screenshots/Phase%20%203/reset-password.png)
   
4. Enter the new password and confirm it
5. Check **Unlock account** if applicable
6. Click **OK** to apply


# **3.2 – Remote Support via RDP**

### ✅ **Prepare Active Directory Group for RDP Access**

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

### ✅ **Enable Remote Desktop on LTP-EMP01**

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

### ✅ **Configure RDP Permissions on Target Machine (LTP-EMP01)**

### 🎯 Objective

Grant the `IT-Support-RDP` group Remote Desktop rights on the domain-joined client `LTP-EMP01`.

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

### ✅ **Initiate RDP Session from LTP-HLP01**

### 🎯 Objective  
Verify remote access works using domain credentials from the support workstation.

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
---
# 3.3 – TeamViewer Remote Assistance

### 🎯 **Objective**

Set up TeamViewer on both machines (support and end-user), ensure secure configuration, and simulate a remote support session from the helpdesk workstation.

### 🧰 **Prerequisites**

- TeamViewer installed on both **LTP-HLP01** (Helpdesk) and **LTP-EMP01** (Employee)
- Internet connectivity
- TeamViewer account (optional for basic usage)
- TeamViewer QuickSupport or Full Client on the employee machine

---

# Download & Install TeamViewer

🔹 **On both LTP-HLP01 and LTP-EMP01:**

1. Open a browser and navigate to:  
   [https://www.teamviewer.com/en/download](https://www.teamviewer.com/en/download)

2. **On LTP-HLP01:**  
   Download the **TeamViewer Full Client** (for providing support).
   
![TV-Download](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/Screenshots/Phase%20%203/Teamviewer_Download.png)

3. **On LTP-EMP01:**  
   Download the **TeamViewer QuickSupport** (for receiving support).


4. Run the installer and select:
   - Default installation
   - Personal / Non-commercial use (or custom for simulation)
   
5. Click **Accept** – finish and wait for the installation to complete.

6. Launch TeamViewer on both machines.

---

## Simulate Remote Support from LTP-HLP01

1. On **LTP-EMP01**, ensure TeamViewer is open and note:
   - Your ID
   - Password

![TV-Download](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/Screenshots/Phase%20%203/EMP-ID.png)

3. On **LTP-HLP01**, under the **Control Remote Computer** section:
   - Sign-in
   - Go To **Remote Support** on the left side
   - Enter the **Partner ID** from **LTP-EMP01**
   - Click **Connect**
     
![Partner-ID](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/Screenshots/Phase%20%203/Partner-ID.png)

   - When prompted, enter the **Password** from **LTP-EMP01**.

You should now have remote access to the user's desktop.

![Session-TV](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/Screenshots/Phase%20%203/session-TV.png)


## 🔴**End Support Session Securely**

1. When support is complete, click the **X** in the TeamViewer window to end the session.

2. On **LTP-EMP01**, advise the user to:
   - Close TeamViewer if not needed
   - Change their temporary password (optional)
   - Revoke access if using permanent ID or unattended access.

### 🔐 **Security Tips**  
🔹 Ensure proper security measures are followed to protect the session and user credentials.

---


# ✅ Troubleshoot Network Connectivity

  ## 🔧 Test 1 – Ping

### 🎯 Objective
Verify basic network connectivity by pinging the default gateway and the domain controller (DC).

All commands below are executed from the employee workstation: **LTP-EMP01**.

---

### ▶️ Test A – Ping the Default Gateway
- Purpose: Ensure the device can reach the router (gateway) and confirm LAN connectivity is functional.
- **Command:**
```bash
ping 192.168.2.1
```
![Ping-Router](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/Screenshots/Phase%20%203/Ping-Router.png)
  
▶️ Test B – Ping the Domain Controller (DC)
- Purpose: Confirm that LTP-EMP01 can reach the Active Directory server (DC) over the network.
- **Command:**
```bash
ping 192.168.2.10
```
![Ping-DC](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/Screenshots/Phase%20%203/Ping-DC.png)


### 🧠 Notes:
If the ping fails:

- ✅ Ensure the domain controller is powered on and properly connected to the network.
- 🔥 Check if ICMP traffic is allowed through Windows Firewall on the target machine.
- 🧩 Confirm that both the source (LTP-EMP01) and target (DC) machines are on the same subnet.
- 🛠️ Use the following command on the domain controller to verify its IP address:
  ```bash
  ipconfig
--- 
### 🔧 Test 2 – IP Configuration

```bash
ipconfig /all
```
![ipconfig](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/Screenshots/Phase%20%203/ipconfig.png)

---

### ✅ **Inspect Network Adapter Status**  
**Objective:** Verify if the network adapter is functioning properly.

- **Why is this important?**  
  This step helps diagnose any network connectivity issues related to the hardware. If the NIC (Network Interface Controller) is having issues, it could cause network disruptions, affecting access to network resources, including domain services.

- **Procedure:**
  1. Open **Device Manager**.
  2. Expand the **Network Adapters** section.
  3. Check for warning icons or missing devices.  
     *(If no warning icons are present, it means no issues have been detected.)*
  4. If needed, right-click the network adapter and select **Update Driver** to check for driver updates.

 ![update-driver](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/Screenshots/Phase%20%203/update-driver.png)

# 📦 Office 365 Deployment via ODT – Lab Documentation

## 🎯 Objective

- Install Microsoft 365 Apps (Office 365) and Visio Pro using Office Deployment Tool (ODT) with a custom PowerShell script.

## **Step 1 – Uninstall Existing Office Installation (if applicable)**

### ✅ Recommended Method: Microsoft Support and Recovery Assistant (SaRA)
- Run this script :
```powershell
iwr https://raw.githubusercontent.com/Admonstrator/msoffice-removal-tool/main/msoffice-removal-tool.ps1 -OutFile msoffice-removal-tool.ps1; powershell -ExecutionPolicy Bypass .\msoffice-removal-tool.ps1
```
Restart the machine after uninstallation.

---

## **Step 2 – Download and Prepare the Office Deployment Tool (ODT)**

1. Download ODT from Microsoft:
   [https://www.microsoft.com/en-us/download/details.aspx?id=49117](https://www.microsoft.com/en-us/download/details.aspx?id=49117)

2. Extract the content to:  
   `C:\ODT`

This folder should contain:
C:\ODT
│ setup.exe
│ config.xml


---

## **Step 3 – Customize `config.xml`**

Create or edit `C:\ODT\config.xml` with the following content:
```xml
<?xml version="1.0" encoding="utf-8"?>
<Configuration>
    <Add OfficeClientEdition="64" Channel="Current">
        <Product ID="O365ProPlusRetail">
            <Language ID="en-us"/>
        </Product>
        <Product ID="VisioProRetail">
            <Language ID="en-us"/>
        </Product>
    </Add>
    <Updates Enabled="TRUE" Channel="Current" />
    <Display Level="None" AcceptEULA="TRUE" />
    <Property Name="AUTOACTIVATE" Value="1" />
</Configuration>
```

 ## **Step 4 – Create the PowerShell Script**
- Create a new script file: C:\Scripts\DeployOffice365.ps1
```powershell
# DeployOffice365.ps1
$OfficeDeploymentPath = "C:\ODT"
$SetupFilePath = "$OfficeDeploymentPath\setup.exe"
$ConfigFilePath = "$OfficeDeploymentPath\config.xml"

# Temporarily allow script execution
Set-ExecutionPolicy RemoteSigned -Scope Process -Force

# Start the Office deployment
Start-Process -FilePath $SetupFilePath -ArgumentList "/configure $ConfigFilePath" -Wait
```

## **Step 5 – Run the Script**
- Open PowerShell as Administrator

- Run the script:
```powershell
cd C:\Scripts
.\DeployOffice365.ps1
```
You should see Office 365 begin installing in the background.

If setup.exe opens a blank CMD and does nothing, Office is likely already installed.
If Office is partially or already installed, the ODT setup may silently fail.

----

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
---
#requires -version 2
#//Requires -RunAsAdministrator

<#
.SYNOPSIS
  This script downloads the current Office uninstaller from Microsoft and tries to remove all Office installations on this computer.
  By choosing -InstallOffice365 it tries to install Office 365 as well.
.DESCRIPTION
  By choosing -InstallOffice365 it tries to install Office 365 as well.
.PARAMETER InstallOffice365
  Will install Office365 after removal.
.PARAMETER SuppressReboot
  Will supress the reboot after finishing the script.
.PARAMETER UseSetupRemoval
  Will use the setup method to remove current Office installations instead of SaRA.
.PARAMETER Force
  Skip user-input.
.PARAMETER RunAgain
  Skip Stage validation and runs the whole script again.
.PARAMETER SecondsToReboot
  Seconds before the computer will reboot.
.INPUTS
  None
.OUTPUTS
  Just output on screen
.NOTES
  Version:        1.2
  Author:         Singleton Factory GmbH
  Creation Date:  2023-01-18
  Purpose/Change: New company, new luck
.EXAMPLE
  .\msoffice-removal-tool.ps1 -InstallOffice365 -SupressReboot
#>

#---------------------------------------------------------[Initialisations]--------------------------------------------------------
Param (
    [switch]$InstallOffice365 = $False,
    [switch]$SuppressReboot = $False,
    [switch]$UseSetupRemoval = $False,
    [Switch]$Force = $False,
    [switch]$RunAgain = $False,
    [int]$SecondsToReboot = 60
)
#----------------------------------------------------------[Declarations]----------------------------------------------------------
$SaRA_URL = "https://aka.ms/SaRA_CommandLineVersionFiles"
$SaRA_ZIP = "$env:TEMP\SaRA.zip"
$SaRA_DIR = "$env:TEMP\SaRA"
$SaRA_EXE = "$SaRA_DIR\SaRAcmd.exe"
$Office365Setup_URL = "https://github.com/Admonstrator/msoffice-removal-tool/raw/main/office365-installer"
#-----------------------------------------------------------[Functions]------------------------------------------------------------
Function Invoke-OfficeUninstall {
    if (-Not (Test-Path "$SaRA_DIR")) {
        New-Item "$SaRA_DIR" -ItemType Directory | Out-Null
    }
    if ($UseSetupRemoval) {
        Write-Host "Invoking default setup method ..."
        Invoke-SetupOffice365 "$Office365Setup_URL/purge.xml"
    }
    else {
        Write-Host "Invoking SaRA method ..."
        Remove-SaRA
        Write-Host "Downloading most recent SaRA build ..."
        Invoke-SaRADownload
        Write-Host "Removing Office installations ..."
        Invoke-SaRA 
    }
}
Function Invoke-SaRADownload {    
    Start-BitsTransfer -Source "$SaRA_URL" -Destination "$SaRA_ZIP" 
    if (Test-Path "$SaRA_ZIP") {
        Write-Host "Unzipping ..."
        Expand-Archive -Path "$SaRA_ZIP" -DestinationPath "$SaRA_DIR" -Force
        if (Test-Path "$SaRA_DIR\DONE") {
            Move-Item "$SaRA_DIR\DONE\*" "$SaRA_DIR" -Force
            if (Test-Path "$SaRA_EXE") {
                Write-Host "SaRA downloaded successfully."
            }
            else {
                Write-Error "Download failed. Program terminated."
                Exit 1
            }
        }
    }
}

Function Remove-SaRA {  
    if (Test-Path "$SaRA_ZIP") {
        Remove-Item "$SaRA_ZIP" -Force
    }

    if (Test-Path "$SaRA_DIR") {
        Remove-Item "$SaRA_DIR" -Recurse -Force
    }
}
 
Function Stop-OfficeProcess {
    Write-Host "Stopping running Office applications ..."
    $OfficeProcessesArray = "lync", "winword", "excel", "msaccess", "mstore", "infopath", "setlang", "msouc", "ois", "onenote", "outlook", "powerpnt", "mspub", "groove", "visio", "winproj", "graph", "teams"
    foreach ($ProcessName in $OfficeProcessesArray) {
        if (get-process -Name $ProcessName -ErrorAction SilentlyContinue) {
            if (Stop-Process -Name $ProcessName -Force -ErrorAction SilentlyContinue) {
                Write-Output "Process $ProcessName was stopped."
            }
            else {
                Write-Warning "Process $ProcessName could not be stopped."
            }
        } 
    }
}

Function Invoke-SaRA {
    $SaRAProcess = Start-Process -FilePath "$SaRA_EXE" -ArgumentList "-S OfficeScrubScenario -AcceptEula -CloseOffice -OfficeVersion All" -Wait -PassThru -NoNewWindow
    switch ($SaRAProcess.ExitCode) {
        0 {
            Write-Host "Uninstall successful!"
            Set-CurrentStage 2
            Break
        }
    
        7 {
            Write-Host "No office installations found."
            Set-CurrentStage 2
            Break
        }

        8 {
            Write-Error "Multiple office installations found. Program need to be run in GUI mode."
            Set-CurrentStage 4
            Exit 2
        }

        9 {
            Write-Error "Uninstall failed! Program need to be run in GUI mode."
            Set-CurrentStage 4
            Exit 3
        }
    }
}

Function Invoke-SetupOffice365($Office365ConfigFile) {
    if ($Office365ConfigFile -eq "$Office365Setup_URL/purge.xml") {
        Write-Host "Downloading Office365 Installer ..."
        Start-BitsTransfer -Source "$Office365Setup_URL/setup.exe" -Destination "$SaRA_DIR\setup.exe"
        Start-BitsTransfer -Source "$Office365ConfigFile" -Destination "$SaRA_DIR\purge.xml"
        Write-Host "Executing Office365 Setup ..."
        $OfficeSetup = Start-Process -FilePath "$SaRA_DIR\setup.exe" -ArgumentList "/configure $SaRA_DIR\purge.xml" -Wait -PassThru -NoNewWindow 
    }
    
    if ($InstallOffice365) {
        Write-Host "Downloading Office365 Installer ..."
        Start-BitsTransfer -Source "$Office365Setup_URL/setup.exe" -Destination "$SaRA_DIR\setup.exe"
        Start-BitsTransfer -Source "$Office365ConfigFile" -Destination "$SaRA_DIR\config.xml"
        Write-Host "Executing Office365 Setup ..."
        $OfficeSetup = Start-Process -FilePath "$SaRA_DIR\setup.exe" -ArgumentList "/configure $SaRA_DIR\config.xml" -Wait -PassThru -NoNewWindow 
        switch ($OfficeSetup.ExitCode) {
            0 {
                Write-Host "Install successful!"
                Set-CurrentStage 4
                Break
            }

            1 {
                Write-Error "Install failed!"
                Set-CurrentStage 3
                Break
            }
        }
    }
}

Function Invoke-RebootInSeconds($Seconds) {
    if (-not $SuppressReboot) {
        Start-Process -FilePath "$env:SystemRoot\system32\shutdown.exe" -ArgumentList "/r /c `"Reboot needed. System will reboot in $Seconds seconds.`" /t $Seconds /f /d p:4:1"
    }
}

Function Set-CurrentStage($StageValue) {
    if (-not (Test-Path "HKLM:\Software\OEM\Singleton-Factory-GmbH\M365\Install")) {
        New-Item -Path "HKLM:\Software\OEM\Singleton-Factory-GmbH\M365\Install" -Force | Out-Null
    }
    New-ItemProperty -Path "HKLM:\Software\OEM\Singleton-Factory-GmbH\M365\Install" -Name "CurrentStage" -Value $StageValue -PropertyType String -Force | Out-Null
}

Function Invoke-Intro {   
Write-Host "  __ _             _      _                  ___          _                   "
Write-Host " / _(_)_ __   __ _| | ___| |_ ___  _ __     / __\_ _  ___| |_ ___  _ __ _   _ "
Write-Host " \ \| | '_ \ / _' | |/ _ \ __/ _ \| '_ \   / _\/ _' |/ __| __/ _ \| '__| | | |"
Write-Host " _\ \ | | | | (_| | |  __/ || (_) | | | | / / | (_| | (__| || (_) | |  | |_| |"
Write-Host " \__/_|_| |_|\__, |_|\___|\__\___/|_| |_| \/   \__,_|\___|\__\___/|_|   \__, |"
Write-Host "             |___/                                                      |___/ "
Write-Host "Microsoft Office Removal Tool"
Write-Host "by Aaron Viehl (Singleton Factory GmbH)"
Write-Host "singleton-factory.de"
Write-Host ""
}

#-----------------------------------------------------------[Execution]------------------------------------------------------------
# Check if -Force is set
if (-Not $Force) {
    do {
        $YesOrNo = Read-Host "Are you sure you want to remove Office from this PC? (y/n)"
    } while ("y", "n" -notcontains $YesOrNo)

    if ($YesOrNo -eq "n") {
        exit 1
    }
}

Invoke-Intro
# Check if there is a stage to resume
if (-not ($RunAgain)) {
    if (Test-Path "HKLM:\Software\OEM\Singleton-Factory-GmbH\M365\Install") {
        $CurrentStageValue = (Get-ItemProperty "HKLM:\Software\OEM\Singleton-Factory-GmbH\M365\Install").CurrentStage
        Switch ($CurrentStageValue) {
            1 {
                Write-Host "Resuming Stage 1: Uninstalling Office ..."
                Invoke-OfficeUninstall 
                Invoke-SetupOffice365 "$Office365Setup_URL/upgrade.xml"
                Remove-SaRA
                Invoke-RebootInSeconds $SecondsToReboot
            }

            2 {
                Write-Host "Resuming Stage 2: Installing Office 365 ..."
                Invoke-SetupOffice365 "$Office365Setup_URL/upgrade.xml"
                Remove-SaRA
                Invoke-RebootInSeconds $SecondsToReboot
            }

            3 {
                Write-Host "Resuming Stage 3: Cleaning up ..."
                Remove-SaRA
            }

            4 {
                # Final stage: All is done, script will not run.
                exit 0
            }

            default {
                Write-Host "Resuming Stage 1: Uninstalling Office ..."
                Invoke-OfficeUninstall 
                Invoke-SetupOffice365 "$Office365Setup_URL/upgrade.xml"
                Remove-SaRA
                Invoke-RebootInSeconds $SecondsToReboot
            }
        }
    }
    else {
        Invoke-Intro
        Stop-OfficeProcess
        Invoke-OfficeUninstall 
        Invoke-SetupOffice365 "$Office365Setup_URL/upgrade.xml"
        Invoke-RebootInSeconds $SecondsToReboot
    }
}
else {
    Invoke-Intro
    Stop-OfficeProcess
    Invoke-OfficeUninstall 
    Invoke-SetupOffice365 "$Office365Setup_URL/upgrade.xml"
    Invoke-RebootInSeconds $SecondsToReboot
}
exit

```
