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
- Azure Active Directory Premium P1 or above (for password storage & retrieval)
- Devices must be Azure AD joined or Hybrid Azure AD joined

---

## How to Enable LAPS via Intune

1. Sign in to the [Microsoft Endpoint Manager admin center](https://endpoint.microsoft.com).

2. Navigate to **Devices** > **Configuration profiles**.

3. Click **+ Create profile**:
   - Platform: **Windows 10 and later**
   - Profile type: **Templates** > **Endpoint protection**

4. In the profile settings, expand **Local device security options**.

5. Find the setting **Local admin password management** and enable it.

6. Configure the password rotation interval (e.g., 30 days).

7. Assign the profile to the device groups you want to manage.

8. Save and deploy.

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




