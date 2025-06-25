# 🚨 LAPS Integration with Microsoft Sentinel: Monitoring and Detection Guide

## Introduction

Local Administrator Password Solution (LAPS) improves endpoint security by automatically managing local administrator passwords on Windows devices. However, monitoring the activities related to the LAPS-managed accounts—such as password retrieval, manual password rotation, and local sign-ins—is essential to detect potential misuse or unauthorized access.

This guide explains how to enable audit logging, collect relevant security events, and create detection rules in Microsoft Sentinel to monitor the `LAPS_Admin` account activities effectively. By integrating LAPS with Microsoft Sentinel, security teams gain real-time visibility and enhanced threat detection capabilities for local admin account operations.

---

## Objective

This guide aims to empower security and IT administrators to:

- Enable advanced audit policies that track key LAPS-related activities on endpoints.
- Collect and ingest critical security event logs into Microsoft Sentinel for centralized monitoring.
- Create and deploy detection rules to identify suspicious or unauthorized use of the `LAPS_Admin` account.
- Set up alerting and visualization tools to improve incident response and governance around local admin account usage.

Following this process will strengthen your organization’s security posture by detecting and responding to risky activities involving local administrator accounts managed through LAPS.

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

1. Go to [https://endpoint.microsoft.com](https://endpoint.microsoft.com)

2. Navigate to **Devices** > **Scripts**.

3. Click **+ Add** > **Windows 10 and later**.

4. Name the script deployment: **Enable Advanced Audit Logging**.

5. Upload your `Enable_LAPS_Audit.ps1` script.

6. Configure:
   - **Run this script using the logged on credentials:** No
   - **Enforce script signature check:** No
   - **Run script in 64-bit PowerShell:** Yes

7. Assign the script to your target device group (e.g., Azure AD joined Windows 10/11 devices).

![LAPS_Aduit_Script](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/05_Zero_Trust_%26_Security_Hardening/Screenshots/LAPS_Audit_Script_Review.png)

8. Click **Next**, review settings, then **Add**.
   
![LAPS_Audit_User_Status](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/05_Zero_Trust_%26_Security_Hardening/Screenshots/LAPS_Audit_User_Status.png)

---

### 🧩 Step 3 — Verify the Audit Policies

- After deployment, on a target device, open **Event Viewer** → **Windows Logs** → **Security**.

- Verify the presence of audit events such as:
  - Event ID **4624** (Successful logon)
  - Event ID **4672** (Special privileged logon)
  - Event ID **4688** (Process creation)

![LAPS_Audit_EV2](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/05_Zero_Trust_%26_Security_Hardening/Screenshots/LAPS_Audit_EV2.png)

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

### 🧩 Step 1 - Ensure Audit Policies Are Enabled on Target Devices

Before starting, make sure you have:

- An active **Log Analytics Workspace** connected to Microsoft Sentinel.
- Azure AD joined or hybrid-joined **Windows 10/11 endpoints**.
- **Intune** or another management solution to deploy AMA at scale.
- Appropriate roles (e.g., **Log Analytics Contributor**, **Intune Admin**, **Global Admin**).

---

### 🧩 Step 2 — Create a Data Collection Rule (DCR)

1. Go to the Azure Portal: [https://portal.azure.com](https://portal.azure.com)

2. Search for **"Data Collection Rules"**

3. Click **+ Create**

4. Fill in the basic info:  
   - **Name**: `LAPS_SecurityEvents_DCR`  
   - **Region**: Same as your Log Analytics workspace  
   - **Resource Group**: Use an existing one or create a new one  

5. Reveoew Click **Next**

---

#### ➕ Add Data Source

1. Go to **Collect and Deliver** > **Add data source**
2. Choose **Windows Event Logs**
3. Select:  
   Security
   - Audit success
   - Audit failure
  
![DCR_Add_Data](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/05_Zero_Trust_%26_Security_Hardening/Screenshots/DCR_Add_Data.png)

---

#### ➕ Add Destination

1. go to **Destination** > **+ Add destination**

2. Choose your **Log Analytics Workspace** connected to Microsoft Sentinel

![DCR_Destination](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/05_Zero_Trust_%26_Security_Hardening/Screenshots/DCR_Destination.png)

3. Click **Next**, then **Create**
4. Review and create

![DCR_Review](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/05_Zero_Trust_%26_Security_Hardening/Screenshots/DCR_Review.png)

---

### 🧩 Step 3 - Download the MSI Installer

1. Go to the official Microsoft link:  
  [https://aka.ms/azuremonitoragentwindows64](https://aka.ms/azuremonitoragentwindows64)
2. Save the file, typically named `AzureMonitorAgentSetup.msi`
3. Open PowerShell or Command Prompt as Administrator
4. Run the following command (adjust the path if needed):

```powershell
msiexec /i "C:\Path\To\AzureMonitorAgentSetup.msi" /quiet /norestart
```
> This will install AMA silently without rebooting immediately.

5. After installation, check the service status by running:

```powershell
Get-Service -Name AzureMonitorAgent
```
> The service status should be Running.

![AMA_Running](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/05_Zero_Trust_%26_Security_Hardening/Screenshots/AMA_running.png)

---

### 🧩 Step 4 - Register the Agent with Your Log Analytics Workspace (If Needed)
> **Note:** This step is only required if the Azure Monitor Agent (AMA) is installed manually and is not yet registered with your Log Analytics Workspace.

Use the following PowerShell script, replacing `<Your Workspace ID>` and `<Your Primary Key>` with your actual workspace details:

```powershell
$WorkspaceId = "<Your Workspace ID>"
$WorkspaceKey = "<Your Primary Key>"
$agentPath = "C:\Program Files\Azure Monitor Agent\Agent\AzureMonitorAgent.exe"

Start-Process -FilePath $agentPath -ArgumentList "register", "-w", $WorkspaceId, "-k", $WorkspaceKey -Wait
```
#### ⚠️ Finding Workspace ID and Primary Key

1. In the Azure Portal, navigate to your eg: **CyberShield-Workspace**.

2. Go to the **Agents** section (sometimes called **Agents management** or **Agent settings**).

> There you will find the **Workspace ID** and **Primary Key** needed to register the Azure Monitor Agent.
 
---

### 🧩 Step 5 - Azure Arc Onboarding for a Local Hyper-V VM

This guide covers onboarding a local Hyper-V VM to Azure Arc using the generated PowerShell script for centralized management and monitoring in the Azure portal.


1. Generate the Azure Arc Onboarding Script

- In the Azure portal, navigate to **Azure Arc > Servers > Add**.
- Choose **Add a single server**.
- Select the target **Subscription**, **Resource Group**, and **Region**.
- Click **Next** then **Generate script**.
- Copy or download the generated PowerShell script.

2. Run the Onboarding Script on the Hyper-V VM

- Log in to your local VM running on Hyper-V.
- Open **PowerShell as Administrator**.
- Paste and execute the copied onboarding script.
- The script will:
  - Download and install the Azure Connected Machine Agent.
  - Prompt for Azure login in a pop-up browser window. Authenticate using your Azure credentials.
  - Create the Azure Arc resource representing the VM in the specified Resource Group.
- Wait for the process to complete (this can take several minutes).

![Arc_Script_VM](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/05_Zero_Trust_%26_Security_Hardening/Screenshots/Arc_Script_connected_VM.png)

3. Verify the Connection

- In the Azure portal, go to **Azure Arc > Servers**.
- Confirm that your Hyper-V VM appears in the list of connected machines.

![Azure_Arc_Machines](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/05_Zero_Trust_%26_Security_Hardening/Screenshots/Azure_Arc_Machines.png)

> You can now manage and monitor the VM through Azure Arc.

---

### Notes

- This method works for machines outside Azure, including on-premises and other cloud environments.
- The onboarding script automates agent installation and resource registration.
- For bulk onboarding, consider using Azure Arc provisioning with Azure CLI or automation tools.


---
### 🧩 Step 5 - Associate a Data Collection Rule (DCR) with Your Devices

- In the Azure Portal, go to **Data Collection Rules**.  
- Select or create a DCR that specifies which logs and events to collect (e.g., `LAPS_SecurityEvents_DCR`).  
- Associate the DCR with your target devices or Azure resources to enable log collection.

![Associate_DCR_HLP01](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/05_Zero_Trust_%26_Security_Hardening/Screenshots/Associate_DCR_HLP01.png)

> **Note:** Association methods vary depending on your environment (Azure Arc, VM extensions, or others).

---

### 🧩 Step 6 - Verify Log Ingestion in Microsoft Sentinel

1. Connect to the Azure Portal
- Open [https://portal.azure.com](https://portal.azure.com).
- Navigate to your **Microsoft Sentinel** workspace (the Log Analytics workspace connected to Sentinel).

2. Open the Logs Explorer
- In your Sentinel workspace menu, click on **Logs**.

3. Run a Basic Query to Check Security Events
Run the following Kusto Query Language (KQL) query to view security events related to logins in the last 24 hours:

```kql
SecurityEvent
| where TimeGenerated > ago(24h)
| where EventID in (4624, 4625, 4672, 4688)
| sort by TimeGenerated desc
| take 50
```
- This query filters key security events important for LAPS monitoring.
- Adjust the time range as needed (e.g., ago(1h), ago(7d)).

4. Analyze the Results
   
- Review the events for timestamps, computer names, user accounts, and event types.
- If you see data flowing in, log collection is working properly.

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
---

## Conclusion

Effectively monitoring LAPS-managed local administrator accounts is a vital component of a robust endpoint security strategy. By enabling audit logging, connecting Windows security logs to Microsoft Sentinel, and implementing tailored detection rules, organizations can gain comprehensive visibility into critical operations such as password retrievals, manual resets, and local sign-ins.

This integration enhances threat detection, improves accountability, and supports faster incident response, thereby reducing the risk of lateral movement and privilege escalation within your environment.
