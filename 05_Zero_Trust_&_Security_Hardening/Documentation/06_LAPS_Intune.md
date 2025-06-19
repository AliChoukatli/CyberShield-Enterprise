# Local Administrator Password Management (LAPS) with Intune

## Overview

Local Administrator Password Management (LAPS) in Intune allows you to automatically manage and rotate local administrator passwords on Windows devices enrolled in Microsoft Endpoint Manager (Intune). Each device gets a unique, complex local admin password that is rotated periodically and securely stored in Azure AD.

This improves security by reducing the risk of lateral movement through shared or static local admin passwords.

## 📘 Table of Contents

- [Key Features](#key-features)
- [Prerequisites](#prerequisites)
- [Step 1 - Create Local Admin Script](#step-1---create-local-admin-script)
- [Step 2 - Create and Assign LAPS Policy](#step-2---create-and-assign-laps-policy)
- [Step 3 - Deploy the Script via Intune](#step-3---deploy-the-script-via-intune)
- [Step 4 - Client Device Behavior](#step-4---client-device-behavior)
- [Step 5 - Retrieve and Rotate Passwords](#step-5---retrieve-and-rotate-passwords)
- [Step 6 - Monitoring and Auditing](#step-6---monitoring-and-auditing)
- [Step 7 - Optional: Integrate with Microsoft Sentinel](#step-7---optional-integrate-with-microsoft-sentinel)
- [Deployment Checklist](#deployment-checklist)


## 🔑 Key Features

- Unique, randomized local admin password per device
- Automatic password rotation (e.g., every 30 days)
- Secure password storage in Azure AD (Entra ID)
- Admin password retrieval via Intune or Graph API
- Optional integration with Microsoft Sentinel

  
## Prerequisites

- Devices enrolled and managed by Intune (Windows 10/11)
- Appropriate Intune licenses and permissions
- Devices must be Azure AD joined or Hybrid Azure AD joined

---

## 1. 🚀 Step 1 - Create Local Admin Script

The following PowerShell script checks if the local user `LAPS_Admin` exists. If not, it creates the account, sets it to enabled, and adds it to the local Administrators group.

```powershell
$AccountName = "LAPS_Admin"

# Generate random Password
Add-Type -AssemblyName System.Web
$plainPassword = [System.Web.Security.Membership]::GeneratePassword(16,3)
$Password = ConvertTo-SecureString $plainPassword -AsPlainText -Force

$user = Get-LocalUser -Name $AccountName -ErrorAction SilentlyContinue

if (-not $user) {
New-LocalUser -Name $AccountName -Password $Password -FullName "LAPS Managed Admin Account" -Description "Account managed by LAPS via Intune" -PasswordNeverExpires:$true -AccountNeverExpires:$true
    Add-LocalGroupMember -Group "Administrators" -Member $AccountName

    Write-Output "User '$AccountName' created and added to Administrators group."
    Write-Output "Generated password: $plainPassword"
} else {
    Write-Output "User '$AccountName' already exists."
}
```
> Note: The password set here is temporary. LAPS will rotate and manage the password automatically after deployment.

### Verification 

![LAPS_Admin](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/05_Zero_Trust_%26_Security_Hardening/Screenshots/LAPS_Admin_user.png)

---

## 🚀 Step 2 - Create and Assign LAPS Policy

1. Sign in to the [Microsoft Endpoint Manager admin center](https://endpoint.microsoft.com).

2. Navigate to **Endpoint security** > **Account protection**.

3. Click **+ Create Policy**.

4. Configure the policy:
   - **Platform**: Windows 10 and later
   - **Profile**: Local admin password solution (Windows LAPS)

| Setting                                          | Description                                                                                             
|--------------------------------------------------|----------------------------------------------------------------------------------------------------------
| **Backup Directory**                             | Entra ID                                                                                                 |
| **Password Age Days**                            | 30                                                                                                        |
| **Administrator Account Name**                   | Leave Empty                                                                                              | 
| **Password Complexity**                          | LowerCase + Uppercase + Numbers + Special characters                                                     | 
| **Password Length**                              | 16                                                                                                       | 
| **Post Authentication Actions**                  | Reset password and log off the managed account.                                                          | 
| **Post Authentication Reset Delay**              | 24                                                                                                       |
| **Automatic Account Management Enabled**         | The target account will be automatically managed                                                         | 
| **Automatic Account Management Enable Account**  | The target account will be enabled                                                                       | 
| **Automatic Account Management Randomize Name**  | the name of the target account will not use a random numeric suffix                                      | 
| Automatic Account Management Target              | Built-in local Administrator                                                                             | 
| **Name or Prefix of Managed Account**            | `Laps_Admin`                                                                           | 
| **Automatic Account Management Target**          | Manage a new account custom administarator account                                                       | 
| **Automatic Account Management Name Or Prefix**  |  Laps_Admin                                                                                              | 

5. Assign the policy to the device groups you want to manage.

6. Save and deploy.

![LAPS_Policy](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/05_Zero_Trust_%26_Security_Hardening/Screenshots/LAPS_Policy.png)


### Notes

- This policy automatically manages the local administrator password on Azure AD joined or Hybrid Azure AD joined devices.
- The password is rotated automatically based on the configured interval.
- Monitor password retrieval permissions via Azure AD roles to maintain security.


---


## 🚀 Step 3 - Install LAPS Client (software/service)

### Overview

The LAPS Client is a Windows service responsible for generating, storing, and automatically rotating the local administrator password on managed devices.  
Installing this client on all target machines is essential to enable the password management features configured in Step 2.

---

### Prerequisites

- Access to Microsoft Endpoint Manager (Intune) portal  
- LAPS MSI installer (`LAPS.x64.msi`) downloaded from Microsoft  
- Target device group(s) identified for deployment

---

### Step 3.1 - Download the LAPS MSI Installer

Download the official LAPS installer from Microsoft:  
https://www.microsoft.com/en-us/download/details.aspx?id=46899  
Choose the 64-bit MSI (`LAPS.x64.msi`).

---

### Step 3.2 - Prepare the Win32 App Package

Intune requires Win32 app format to deploy MSI files. To prepare the package:

1. Download the [Microsoft Win32 Content Prep Tool](https://learn.microsoft.com/en-us/mem/intune/apps/apps-win32-app-management#prepare-the-win32-app-content)  
2. Place the `LAPS.x64.msi` file in a folder, e.g., `C:\LAPS`  
3. Open PowerShell in that folder and run:
   
   ```powershell
   .\IntuneWinAppUtil.exe -c . -s LAPS.x64.msi -o .\
   ```

4. This will generate LAPS.x64.intunewin, the package ready for upload.


Step 3.3 -  Deploy the LAPS Client via Intune

1. Go to Microsoft Endpoint Manager Admin Center
2. Navigate to Apps > Windows > + Add > Windows app (Win32)
3. Upload the LAPS.x64.intunewin file
4. Configure the app information (name, description, publisher)
5. Under Program, enter:

- Install command:

```bash
msiexec /i LAPS.x64.msi /quiet /norestart
```

6. Configure detection rules to verify installation (e.g., registry key for LAPS presence)
7. Assign the app to the same device groups targeted by your LAPS policy


Step 3.4 - Verify Installation

After deployment, verify on a target device that:

- The AdmPwd Windows service is running:

```powershell
Get-Service AdmPwd
```

- The LAPS registry keys exist:

```powershell
Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\LAPS"
```

Notes
The LAPS client must be installed on every device you want to manage with LAPS.

Without this client, Intune’s LAPS policy cannot rotate or retrieve local admin passwords.

---

## 🚀 Step 4 - Deploy the Script via Intune

1. Go to **Microsoft Intune Admin Center**  
   Navigate to **Devices** > **Scripts** > Click **+ Add**.

2. Select the platform:
   - **Platform**: Windows 10 and later

3. **Basics**  
   - **Name**: `Create_LAPS_Admin`  

4. **Script Settings**
   | Setting                                              | Value         | Notes                                      |
   |------------------------------------------------------|---------------|--------------------------------------------|
   | Upload .ps1 file                                     | ✔️            | Upload the `Create_LAPS_Admin.ps1` script  |
   | **Run this script using the logged on credentials**  | **No**        | Ensures script runs as SYSTEM              |
   | **Enforce script signature check**     | **No**      | Set to Yes only if the script is signed                    |
   | **Run script in 64-bit PowerShell host** | **Yes**   | Recommended for compatibility                               |

5. **Assignments**
   - Assign to the **same device group** used for your LAPS policy (e.g., `Windows 10/11 Devices`).

6. **Review + Add**
   - Confirm your settings and click **Add** to deploy the script.

![LAPS_Script_Intune](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/05_Zero_Trust_%26_Security_Hardening/Screenshots/LAPS_Scirpt_Intune.png)

📌 *Once deployed, the script will run on the targeted devices and create the `LAPS_Admin` local administrator account automatically. The LAPS policy will then manage this account’s password.*

---


## 🚀 Step 5 - Client Device Behavior

Copy the password and view its expiration date

- Upon receiving the PowerShell script, client devices will create the `LAPS_Admin` local administrator account (if not already present).
- GO to a client machine : eg: `John Doe`

![LAPS_Admin_JD](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/05_Zero_Trust_%26_Security_Hardening/Screenshots/LAPS_Admin_JD.png)

- The LAPS policy will manage and rotate the password of this account automatically according to your configured schedule.
- The password is securely backed up to Azure AD or your specified backup directory.


---

## 🚀 Step 6 - Retrieve and Rotate Passwords
Retrieve via Intune:
Go to Devices > [Device Name] > Local admin password

Copy the password and view its expiration date

Force Immediate Rotation:
On the client, run:
```powershell
Invoke-LapsPolicyProcessing -Force
```

---

##  🚀 Step 7 - Monitoring and Auditing
Role-Based Access Control (RBAC):
To retrieve passwords, users must be in one of the following roles:

Global Administrator

Intune Administrator

Local Administrator Password Reader (Recommended Least Privilege)

Audit Access:
In Azure AD > Audit Logs, monitor access using:

```kql
AuditLogs
| where ActivityDisplayName contains "Read local administrator password"
```
Check LAPS Client Status:
Run the following command on the client:

```powershell
Get-LapsDiagnostics
```

## 🚀 Step 8 - Optional: Integrate with Microsoft Sentinel
To monitor who accessed local admin passwords:

```kql
AuditLogs
| where ActivityDisplayName contains "Read local administrator password"
| project TimeGenerated, InitiatedBy, ActivityDisplayName, TargetResources
```
-> Trigger alerts if password access occurs outside business hours or from suspicious users.



