# Local Administrator Password Management (LAPS) with Intune

## Overview

Local Administrator Password Management (LAPS) in Intune allows you to automatically manage and rotate local administrator passwords on Windows devices enrolled in Microsoft Endpoint Manager (Intune). Each device gets a unique, complex local admin password that is rotated periodically and securely stored in Azure AD.

This improves security by reducing the risk of lateral movement through shared or static local admin passwords.

## 📘 Table of Contents

- Unique local administrator password per device
- Automatic password rotation (configurable interval)
- Secure storage of passwords in Azure Active Directory
- Retrieval of passwords via Intune or PowerShell
- Integration possibilities with Microsoft Sentinel for alerting (not native in Intune)

## Prerequisites

- Devices enrolled and managed by Intune (Windows 10/11)
- Appropriate Intune licenses and permissions
- Devices must be Azure AD joined or Hybrid Azure AD joined

---

## How to Enable LAPS via Intune (2025)

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

## 🔐 Retrieve Windows LAPS Password via Microsoft Graph PowerShell 

### Prerequisites

- Global Administrator or appropriate RBAC role.
- Device must be enrolled in Intune with LAPS configured.
- You are running the commands from an **admin workstation**, not the client device.

#### 1. 📦 Install Microsoft Graph PowerShell

- Current User :
```powershell
Install-Module Microsoft.Graph -Scope CurrentUser -Repository PSGallery -Force
```
- All users :
```powershell
Install-Module Microsoft.Graph -Scope AllUsers -Repository PSGallery -Force
```

#### 2. 📦 Verify installation

```powershell
Get-InstalledModule Microsoft.Graph
```
![Graph_Ins_Verif](

#### 3. 🔐 Sign in with Required Scopes

```powershell
Connect-MgGraph -Scopes "DeviceManagementManagedDevices.Read.All"
```
#### 3. 🔎 Get the Device Object ID
Go to:

- [Microsoft Intune Admin Center](https://endpoint.microsoft.com).
- Navigate to Devices > select the device > Hardwware > Microsoft Entra Device ID
- Copy the Device ID field
  
```powershell
$deviceId = "<paste the Device ID here>"
$password = Get-MgDeviceManagementManagedDeviceLapsWindowsDevicePassword -ManagedDeviceId $deviceId
Write-Output $password
```
> ⚠️ Important:
This command must be run from your admin workstation, not on the client device—even if you have local admin rights on that device.





# Alerts and Monitoring for LAPS with Intune

Intune does **not provide built-in alerts** for local admin password changes or access events.

To implement alerting, integrate Intune with **Microsoft Sentinel**:

- **Create custom analytic rules** in Sentinel to detect actions related to local administrator accounts, such as:
  - Password retrieval
  - Password rotation

- Use **Logic Apps** or **Automation runbooks** to send notifications by:
  - Email
  - Microsoft Teams

### Example

Detect when a local admin password is retrieved or rotated and trigger an alert to security operations.

---




