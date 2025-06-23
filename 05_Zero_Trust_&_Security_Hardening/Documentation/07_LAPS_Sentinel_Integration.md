# 🚨 LAPS Integration with Microsoft Sentinel

# 🎯 Objective

This guide explains how to monitor and detect sensitive operations related to the `LAPS_Admin` account using Microsoft Sentinel. Key activities include:

- Retrieval of the local admin password via Intune
- Manual rotation of the local admin password
- Local sign-in using the `LAPS_Admin` account

---

# 📘 Table of contents

- 1 - Enable Audit Logging via PowerShell Script Deployment — *Recommended*
- 2 - Connect Required Logs to Microsoft Sentinel
- 3️ -  Use Cases & Detection Rules

---

# 1 - Enable Audit Logging for LAPS (PowerShell Script)

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

![LAPS_Audit_User_Status](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/05_Zero_Trust_%26_Security_Hardening/Screenshots/LAPS_Audit_User_Status.png)

---


# 2 - Connect Required Logs to Microsoft Sentinel

## 🎯 Objective

Collect and ingest the relevant Windows Security event logs related to LAPS (`LAPS_Admin`) activities into Microsoft Sentinel for real-time monitoring, alerting, and investigation.

---

## 🔍 Key Event IDs to Collect

| Event ID | Description                             | Relevance to LAPS Monitoring                            |
|----------|-------------------------------------|--------------------------------------------------------|
| 4624     | Successful Logon                     | Detect local sign-ins using `LAPS_Admin` account       |
| 4625     | Failed Logon                        | Detect failed attempts on local admin accounts         |
| 4672     | Special Privileged Logon            | Detect elevated logons (e.g., admin or system accounts)|
| 4688     | Process Creation                    | Detect suspicious process executions related to LAPS   |
| 4703     | A user right was adjusted          | Detect privilege changes affecting LAPS account        |
| 4769     | A Kerberos service ticket was requested | Relevant if LAPS accounts use Kerberos authentication |
| 1102     | Audit log cleared                  | Detect possible log tampering                            |

---

## 🧩 Step 1 - Ensure Audit Policies Are Enabled on Target Devices

Before logs can be collected, ensure the audit policies discussed previously are enabled. Prefer **Method 1** (PowerShell script deployment via Intune) for reliable policy enforcement on Azure AD joined Windows 10/11 devices.

---

## 🧩 Step 2 - Configure Data Collection in Microsoft Sentinel

### 1. Connect Microsoft Sentinel to your Windows endpoints

- Deploy the **Azure Monitor Agent (AMA)** or **Microsoft Defender for Endpoint** on your Windows 10/11 devices.
- These agents will forward Windows Security logs to your Sentinel workspace.

### 2. Enable the **Security Events** data connector in Microsoft Sentinel

- Go to **Microsoft Sentinel** > **Configuration** > **Data connectors**
- Search for and select **Security Events**
- Click **Open connector page**
- Follow instructions to configure log forwarding from your endpoints:
  - Configure **AMA** or **Defender for Endpoint** to collect **Security** event logs (including Event IDs listed above).
  - If using AMA, ensure **Windows Security Events** log is enabled.

![Sentinel Security Events Connector](https://docs.microsoft.com/en-us/azure/sentinel/media/connectors/windows-defender-security-events/connector-page.png)

---

## 🧩 Step 3 - Verify Logs Are Ingested in Microsoft Sentinel

- After configuration, confirm events are arriving in Sentinel by running a simple query in **Logs** (Log Analytics):

```kusto
SecurityEvent
| where EventID in (4624, 4672, 4688)
| where Account == "LAPS_Admin" or Account contains "LAPS_Admin"
| sort by TimeGenerated desc
| take 20
```
> This query helps you see recent logon and privileged activity involving the LAPS_Admin account.

---

### 🧩 Step 4 - Create Analytics Rules & Alerts (Optional but Recommended)

Create custom Analytics rules in Microsoft Sentinel to detect and alert on suspicious or sensitive LAPS-related activities, including but not limited to:

- **Unexpected logon outside business hours**  
- **Logon from unusual IP addresses or geographic locations** (impossible travel detection)  
- **Password retrieval events correlated with LAPS account usage**

You can leverage built-in Sentinel rule templates or customize detection rules based on your organization's environment and risk profile.

---

### ⚠️ Important Notes

- The **Azure Monitor Agent (AMA)** is the recommended agent for Windows Event forwarding, replacing older agents such as OMS Agent or MMA.  
- Integrating **Microsoft Defender for Endpoint** provides richer telemetry and security signals but requires proper licensing.  
- Regular maintenance and tuning of both audit policies and Sentinel detection rules are essential to minimize false positives and maximize detection accuracy.

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
