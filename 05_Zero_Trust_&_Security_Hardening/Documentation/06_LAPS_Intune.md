# Local Administrator Password Management (LAPS) with Intune

## Overview

Local Administrator Password Management (LAPS) in Intune allows you to automatically manage and rotate local administrator passwords on Windows devices enrolled in Microsoft Endpoint Manager (Intune). Each device gets a unique, complex local admin password that is rotated periodically and securely stored in Azure AD.

This improves security by reducing the risk of lateral movement through shared or static local admin passwords.

## 📘 Table of Contents

- [Key Features](#key-features)
- [Prerequisites](#prerequisites)
- [Step 1 - Create and Test the Local Admin Script](#step-1---create-and-test-the-local-admin-script)
- [Step 2 - Create and Assign LAPS Policy](#step-2---create-and-assign-laps-policy)
- [Step 3 - Deploy the Script via Intune](#step-3---deploy-the-script-via-intune)
- [Step 4 - LAPS_Admin Deployment Verification (via Intune)](#step-4---laps_admin-deployment-verification-via-intune)
- [Step 5 - Retrieve Passwords](#step-5---retrieve-passwords)
- [Step 6 - Log-in with (LAPS_Admin) account](#step-6---log-in-with-laps_admin-account)
- [Step 7 - Rotation Password](#step-7---rotation-password)
- [Step 8 - Limit LAPS Password Access Rights](#step-8---limit-laps-password-access-rights)




## 🔑 Key Features

- Unique, randomized local admin password per device
- Automatic password rotation (e.g., every 30 days)
- Secure password storage in Azure AD (Entra ID)
- Admin password retrieval via Intune
- Optional integration with Microsoft Sentinel

  
## Prerequisites

- Devices enrolled and managed by Intune (Windows 10/11)
- Appropriate Intune licenses and permissions
- Devices must be Azure AD joined or Hybrid Azure AD joined
- Enable Microsoft Entra Local Administrator Password Solution (LAPS)


---

## 1. 🚀 Step 1 -  Create and Test the Local Admin Script

Before deploying the script via Intune, we validated its functionality by running it locally on one device.
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

### ✅ Verification (Local Execution on LTP-HLP01)

![LAPS_Admin](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/05_Zero_Trust_%26_Security_Hardening/Screenshots/LAPS_Admin_user.png)

> ℹ️ The script was executed locally on LTP-HLP01 to validate its behavior before deploying it to other devices via Intune (see Step 3).

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


## 🚀 Step 3 - Deploy the Script via Intune

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


## 🚀 Step 4 - LAPS_Admin Deployment Verification (via Intune)

- Upon receiving the PowerShell script, client devices will create the `LAPS_Admin` local administrator account (if not already present).
- Go to a client machine : eg: `LTP-EMP02`
- Type the following command ``` Get-LocalUser ``` Look for the `LAPS_Admin Account`

![LAPS_Admin_JD](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/05_Zero_Trust_%26_Security_Hardening/Screenshots/LAPS_Admin_JD.png)

- The LAPS policy will manage and rotate the password of this account automatically according to your configured schedule.
- The password is securely backed up to Azure AD or your specified backup directory.


---

## 🚀 Step 5 - Retrieve Passwords

Retrieve via Intune:
Go to Devices > [Device Name] > Local admin password
Copy the password and view its expiration date

![LAPS_Passwd](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/05_Zero_Trust_%26_Security_Hardening/Screenshots/LAPS_Passwd.png)

---

## 🚀 Step 6 -  Log-in with (LAPS_Admin) account

  - **Username:** .\LAPS_Admin  
  - **Password:** The one retrieved from Intune in the previous step.

![LAPS_Admin_FirstStart](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/05_Zero_Trust_%26_Security_Hardening/Screenshots/LAPS_Admin_whoami.png)

---

## 🚀 Step 7 - Rotation Password 

- Go to Devices > [Device Name] > Rotate Local Admin Password
- GO to Local admin password > Show local administrator password
- Check if rotation worked

![LAPS_Passwd_Rotation](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/05_Zero_Trust_%26_Security_Hardening/Screenshots/LAPS_Passwd_Rotation.png)


## 🔒 Step 8 —  Limit LAPS Password Access Rights

**Objective:** Ensure only authorized roles can view LAPS passwords.

- Go to [Microsoft Entra admin center](https://entra.microsoft.com)
- Navigate to **Roles and administrators**
- Verify who has the following roles:
  - Intune Administrator
  - Cloud Device Administrator
  - Privileged Authentication Administrator
- Remove the role from any account that should NOT have LAPS password access.
> *Tip:* Use a dedicated group (e.g., *LAPS Password Readers*) and assign roles accordingly for better control.

![Passwd_Reader_Group](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/05_Zero_Trust_%26_Security_Hardening/Screenshots/LAPS_Passwd_Group.png)

---
