# 🚨 LAPS Integration with Microsoft Sentinel

# 🎯 Objective

This guide explains how to monitor and detect sensitive operations related to the `LAPS_Admin` account using Microsoft Sentinel. Key activities include:

- Retrieval of the local admin password via Intune
- Manual rotation of the local admin password
- Local sign-in using the `LAPS_Admin` account

---

# 📘 Table of contents

- Method 1: Enable Audit Logging via PowerShell Script Deployment — *Recommended*
- Method 2 - Enable Audit Logging via Intune Custom Profile (OMA-URI) — *Currently Limited*  
> ⚠️ Since some advanced audit settings cannot be applied through Intune OMA-URI profiles due to MDM limitations, the PowerShell script deployment method is recommended for reliable audit policy configuration.

---


## Method 1 - Enable Audit Logging via PowerShell Script Deployment — *Recommended*

### 🎯 Objective:
Enable key audit policies required for tracking LAPS_Admin activity—such as password retrieval and local login—using Microsoft Sentinel.

### 🧩 Step 1 — Create the PowerShell Script

Create a PowerShell script (`Enable_LAPS_Audit.ps1`) with the following content:

```powershell
$auditSettings = @(
    @{ Subcategory = "Credential Validation"; Success = "enable"; Failure = "enable" },
    @{ Subcategory = "Logon"; Success = "enable"; Failure = "enable" },
    @{ Subcategory = "Special Logon"; Success = "enable"; Failure = "enable" },
    @{ Subcategory = "File System"; Success = "enable"; Failure = "enable" },            
    @{ Subcategory = "Registry"; Success = "enable"; Failure = "enable" },                
    @{ Subcategory = "Other Object Access Events"; Success = "enable"; Failure = "enable" }, 
    @{ Subcategory = "Sensitive Privilege Use"; Success = "enable"; Failure = "enable" }
)

foreach ($setting in $auditSettings) {
    Write-Output "Setting audit policy for subcategory: $($setting.Subcategory) (Success=$($setting.Success), Failure=$($setting.Failure))"
    AuditPol /set /subcategory:"$($setting.Subcategory)" /success:$($setting.Success) /failure:$($setting.Failure)
}
```
#### 🧪 Important: Before deploying this script via Intune, it is highly recommended to test it locally on a target device to ensure it works as expected.

To test locally:

1. Open PowerShell as Administrator on the test machine.
2. Navigate to the folder where the script is saved.
3. Run the script with:

```powershell
.\Enable_LAPS_Audit.ps1
```
4. Verify the audit policy changes using:

```powershell
auditpol /get /subcategory:"Credential Validation"
auditpol /get /subcategory:"Logon"
auditpol /get /subcategory:"Special Logon"
auditpol /get /subcategory:"File System"
auditpol /get /subcategory:"Registry"
auditpol /get /subcategory:"Other Object Access Events"
auditpol /get /subcategory:"Sensitive Privilege Use"
```

![LAPS_Audit_PS](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/05_Zero_Trust_%26_Security_Hardening/Screenshots/LAPS_Audit_PS.png)

5. Check the Security logs in Event Viewer to confirm relevant audit events are generated (e.g., Event IDs 4624, 4672, 4688).

---

### 🧩 Step 2 — Deploy the Script via Intune

1. Sign in to the Microsoft Endpoint Manager admin center.

2. Navigate to **Devices** > **Scripts**.

3. Click **+ Add** > **Windows 10 and later**.

4. Name the script deployment: **Enable Advanced Audit Logging**.

5. Upload your `Enable_LAPS_Audit.ps1` script.

7. Configure:
   - **Run this script using the logged on credentials:** No
   - **Enforce script signature check:** No
   - **Run script in 64-bit PowerShell:** Yes

8. Assign the script to your target device group (e.g., Azure AD joined Windows 10/11 devices).

![LAPS_Aduit_Script](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/05_Zero_Trust_%26_Security_Hardening/Screenshots/LAPS_Audit_Script_Review.png)

8. Click **Next**, review settings, then **Add**.

---

### 🧩 Step 3 — Verify the Audit Policies

- After deployment, on a target device, open **Event Viewer** → **Windows Logs** → **Security**.

- Verify the presence of audit events such as:
  - Event ID **4624** (Successful logon)
  - Event ID **4672** (Special privileged logon)
  - Event ID **4688** (Process creation)

![LAPS_Audit_EV2](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/05_Zero_Trust_%26_Security_Hardening/Screenshots/LAPS_Audit_EV2.png)

---

### 🧩 Notes

- This script method bypasses Intune's current OMA-URI limitations for audit policy configuration.
- It is fully compatible with Windows 10 and Windows 11 Azure AD joined devices.

---


## Method 2 - Enable Audit Logging via Intune Custom Profile (OMA-URI) — *Currently Limited*
> ⚠️ This method is officially supported but currently has limitations on Azure AD joined Windows 10/11 devices, often causing deployment errors.

---

### 🎯 Objective

Enable key audit policies required for tracking LAPS_Admin activity—such as password retrieval and local login—using Microsoft Sentinel.

This guide is intended for **Azure AD joined devices managed by Intune only** (no on-prem GPO).

---

### 🧩 Step 1 — Create a Custom Profile in Intune

1. Go to the [Microsoft Intune admin center](https://intune.microsoft.com)
2. Navigate to **Devices** > **Configuration profiles**
3. Click **+ Create profile**
4. Configure the profile:
   - **Platform**: *Windows 10 and later*
   - **Profile type**: *Templates* > **Custom**
5. Click **Create**

---

### 🧩 Step 2 — Define Profile Basics

- **Name**: `Enable Advanced Auditing - LAPS`
- **Description**: Enables auditing for Account Logon, Logon/Logoff, Object Access, and Privilege Use categories.
- Click **Next**

---

### 🧩 Step 3 — Add OMA-URI Settings

Click **+ Add** for each of the following OMA-URIs:

| Name                        | OMA-URI                                                                                 | Data Type   | Value |
|-----------------------------|------------------------------------------------------------------------------------------|-------------|-------|
| Audit - Credential Validation | `./Device/Vendor/MSFT/Policy/Config/Audit/AccountLogon_CredentialValidation`         | Integer     | `3`   |
| Audit - Logon               | `./Device/Vendor/MSFT/Policy/Config/Audit/LogonLogoff_Logon`                           | Integer     | `3`   |
| Audit - Special Logon       | `./Device/Vendor/MSFT/Policy/Config/Audit/LogonLogoff_SpecialLogon`                   | Integer     | `1`   |
| Audit - Object Access       | `./Device/Vendor/MSFT/Policy/Config/Audit/ObjectAccess_OtherObjectAccessEvents`       | Integer     | `3`   |
| Audit - Sensitive Privilege | `./Device/Vendor/MSFT/Policy/Config/Audit/PrivilegeUse_SensitivePrivilegeUse`         | Integer     | `3`   |

#### ℹ️ Values Explained:
- `1` = Success  
- `2` = Failure  
- `3` = Success + Failure

#### ℹ️ Audit Categories Overview for LAPS Monitoring

- **Credential Validation** and **Logon**:  
  These audit categories track authentication events, including logins to local accounts such as `LAPS_Admin`.

- **Special Logon**:  
  Tracks logons with elevated privileges. This is crucial for detecting administrative or privileged account access.

- **Object Access**:  
  Monitors access to sensitive files or registry keys. Useful for auditing any modifications or accesses related to LAPS configurations.

- **Sensitive Privilege Use**:  
  Monitors the use of sensitive privileges that could allow privilege escalation or security bypass.

---

### 🧩 Step 4 — Assign the Profile

1. Click **Next**
2. Under **Assignments**, select the **device group** that contains your cloud-only endpoints
3. Click **Next**, then **Review**

![LAPS_Audit](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/05_Zero_Trust_%26_Security_Hardening/Screenshots/LAPS_Audit.png)

4. Click **Create**

---

### 🧩 Step 5 — Confirm Policy Application

On a test device:

- Open **Event Viewer**
- Go to: `Windows Logs > Security`
- You should start seeing events like:
  - `4624` — Successful logon (LAPS_Admin)
  - `4672` — Privileged logon
  - `4688` — Process creation 

![LAPS_Audit_EV](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/05_Zero_Trust_%26_Security_Hardening/Screenshots/LAPS_Audit_EV.png)

> You can now ingest these logs into **Microsoft Sentinel** via the **AMA agent** or **Microsoft Defender for Endpoint**.

---

## 2 - Connect Required Logs to Microsoft Sentinel

## 🔗 Log Sources to Connect

| Log Source             | Log Name                        | Description                                                  |
|------------------------|--------------------------------|--------------------------------------------------------------|
| **Windows Event Logs**  | Microsoft-Windows-LAPS/Operational | Core LAPS operational events: password access, set operations, and errors. |
| **Security Logs**       | Security                       | Tracks user authentication, privilege use, logon sessions (e.g., Event IDs 4624, 4672). |
| **System Logs**         | System                        | Service start/stop and Group Policy processing relevant to LAPS. |

---

### 🛠️ How to Connect These Logs to Microsoft Sentinel

- Access to Microsoft Endpoint Manager portal: [https://endpoint.microsoft.com](https://endpoint.microsoft.com)
- Defined Azure AD device groups targeting Windows 10/11 devices
- Administrative permissions in Intune to create and assign device configuration profiles
- You must have **access to Microsoft Sentinel** and the relevant Log Analytics workspace.

---

### Option 1 — Using Azure Monitor Agent (AMA)

#### Objective

Deploy the Azure Monitor Agent (AMA) centrally and automatically on Windows 10/11 devices managed by Intune to enable log collection for Microsoft Sentinel.

##### 1. Sign in to Microsoft Endpoint Manager portal

- Open a browser and go to [https://endpoint.microsoft.com](https://endpoint.microsoft.com)
- Sign in with an account with Intune admin rights

#### 2. Create a Device Configuration Profile to deploy AMA

- From the left-hand menu, select **Devices** > **Configuration profiles**
- Click **+ Create profile**

#### 3. Configure profile settings

- Platform: **Windows 10 and later**
- Profile type: **Templates**
- Select **Endpoint Protection** (or if available, select **Azure Monitor Agent** template)

> If no dedicated AMA template exists, use **Custom** profile with OMA-URI for advanced configurations or deploy via installer script.

#### 4. Configure the profile details

- Name: `Deploy Azure Monitor Agent`
- Description: `Installs the Azure Monitor Agent for log collection`

#### 5. Assign the profile

- Choose the device groups to deploy the agent to (e.g., "All Windows 10 Devices")

#### 6. Review and create

- Review the settings and click **Create** to deploy

---

## Alternative Method: Deploy AMA using PowerShell script

If no direct profile is available, deploy AMA using a PowerShell script via Intune:

- Create a PowerShell script that installs AMA MSI silently:

```powershell
Start-Process msiexec.exe -ArgumentList '/i https://aka.ms/azuremonitoragentwindows /qn' -Wait
```

---


### Option 2 — Using Microsoft Defender for Endpoint (MDE)

1. Onboard your devices to **Microsoft Defender for Endpoint**.
2. In Microsoft Sentinel, navigate to **Data Connectors**.
3. Locate and open the **Microsoft Defender for Endpoint** connector.
4. Follow the integration steps to connect MDE alerts and event logs to Sentinel.
5. Leverage **Advanced Hunting** queries to analyze LAPS-related events ingested from the Security and Endpoint data.

---

## Verification & Next Steps

- After connecting logs, verify ingestion by running queries in Sentinel such as:

```kusto
Event
| where EventLog == "Microsoft-Windows-LAPS/Operational"
| sort by TimeGenerated desc
| take 10
```
---

## 3️ -  Use Cases & Detection Rules

### ✅ Case 1 — Viewing LAPS Password via Intune

This query detects users who retrieved a local admin password through Intune:

```kusto
AuditLogs
| where ActivityDisplayName == "Read deviceLocalCredentials"
| extend DeviceName = tostring(TargetResources[0].displayName)
| extend Reader = tostring(InitiatedBy.user.userPrincipalName)
| project TimeGenerated, DeviceName, Reader, Result = ResultReason
```
> 🔔 Recommendation: Create an alert rule with Medium severity. Add a condition to alert if the Reader is not part of a privileged group like LAPS Password Readers.

### ✅ Case 2 — Manual Rotation of the Local Admin Password
This query identifies manual password resets performed from the Intune console:

```kusto
AuditLogs
| where ActivityDisplayName == "Rotate local device password"
| extend DeviceName = tostring(TargetResources[0].displayName)
| extend Initiator = tostring(InitiatedBy.user.userPrincipalName)
| project TimeGenerated, DeviceName, Initiator
```
> 📌 This may indicate troubleshooting activity or suspicious attempts to reset the admin password.

### ✅ Case 3 — Local Sign-In using the LAPS_Admin Account
Assuming Windows Security logs are connected, the following query detects logon events from LAPS_Admin

```kusto
SecurityEvent
| where EventID == 4624 and Account == "LAPS_Admin"
| project TimeGenerated, Computer, Account, LogonType, IPAddress = IpAddress
```

🛡️ Alert tip: Raise an alert if logon happens:

- From an unexpected endpoint
- During non-working hours
- Too frequently (suspicious pattern)

---

## 📊 LAPS Monitoring Workbook (Recommended)

Create a custom workbook to visualize:

- Daily count of password reads
- Manual rotations
- Geolocation of sign-ins with LAPS_Admin
- Audit activity summary

🧠 Hunting Query Example

```kusto
AuditLogs
| where ActivityDisplayName in ("Read deviceLocalCredentials", "Rotate local device password")
| summarize count() by ActivityDisplayName, bin(TimeGenerated, 1d)
```
