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

| Setting                                  | Description                                                                                              | Default / Notes                                |
|------------------------------------------|----------------------------------------------------------------------------------------------------------|------------------------------------------------|
| **Backup Directory**                     | Where to back up the local admin password. Options: Microsoft Entra ID, 2 = Active Directory             |
| **Administrator Account Name**           | Specify the local admin account name to manage. If not specified, the built-in admin account is managed. | Account must already exist if custom name set. |
| **Password Complexity**                  | Complexity rules for the password. Values: 4 = LowerCase + Uppercase + Number + Special characters                                                        |
| **Password Length**                      | Length of the generated password (8–64 characters).                                                      | Default: 14 characters                         |
| **Post Authentication Actions**          | Action to take after password expires. Default is to reset password and log off the managed account.     | Default: 3 (Reset + logoff)                    |
| **Post Authentication Reset Delay**      | Hours to wait after authentication before applying post-auth action. 0 disables post-auth actions.       | Default: 24 hours                              |
| **Automatic Account Management Enabled** | Enable automatic management of the target account password.                                              | Default: False (must enable to activate LAPS)  |

5. Assign the policy to the device groups you want to manage.

6. Save and deploy.


---

### Notes

- This policy automatically manages the local administrator password on Azure AD joined or Hybrid Azure AD joined devices.
- The password is rotated automatically based on the configured interval.
- Monitor password retrieval permissions via Azure AD roles to maintain security.


---

## Retrieving the Local Admin Password

You can retrieve the stored local admin password for a device using PowerShell or through the Intune portal.

### Using PowerShell

Install the [Microsoft Graph PowerShell module](https://learn.microsoft.com/en-us/powershell/microsoftgraph/overview) and run the following:

```powershell
Connect-MgGraph -Scopes "DeviceManagementManagedDevices.Read.All"
$deviceId = "<Device Object ID>"
$password = Get-MgDeviceManagementManagedDeviceLapsActivedirectoryDevicePassword -ManagedDeviceId $deviceId
Write-Output $password
```
(Replace <Device Object ID> with the actual device ID.)


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




