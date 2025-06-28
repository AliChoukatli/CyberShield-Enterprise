# 🛡️ Microsoft Defender Antivirus Deployment via Intune

## 🎯 Objective

Deploy and validate a Microsoft Defender Antivirus security policy via Intune to enforce best-practice protection settings across all corporate Windows endpoints.

---

### 📝 Introduction

In this section, you’ll configure **Microsoft Defender Antivirus** using Microsoft Intune to ensure real-time protection, cloud-based threat detection, and full device coverage. This provides a consistent and secure baseline across all Windows 10/11 endpoints.

The configuration is done using Intune security policies, allowing centralized deployment, validation, and reporting—all without manual endpoint intervention.

---

### 🛡️ Step 1 – Access Endpoint Security Policies 

1. Go to [https://intune.microsoft.com](https://intune.microsoft.com)  
- Navigate to **Endpoint security > Antivirus**
  
### 🛡️ Step 2 – Create Antivirus Policy  

1. Click **+ Create Policy**
2. Platform: **Windows 10 and later**
3. Profile: **Microsoft Defender Antivirus**
4. Name e.g., `Defender Antivirus Baseline 24H2`
5. Click **Create**

![AV](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/03_AzureAD_Sync_%26_Endpoint_Security/Screenshots/Antivirus.png)

---

### 🛡️ Step 3 – Configure Antivirus Settings  

| Parameter                                      | Value / Status                          |
|-----------------------------------------------|---------------------------------------|
| Allow Realtime Monitoring                      | Allowed. Turns on and runs the real-time monitoring service. |
| Allow Cloud Protection                         | Allowed. Turns on Cloud Protection.   |
| Submit Samples Consent                         | Send safe samples automatically.      |
| Allow scanning of all downloaded files and attachments | Allowed.                       |
| Check For Signatures Before Running Scan      | Enabled                               |
| Allow Full Scan On Mapped Network Drives      | Allowed. Scans mapped network drives. |
| Allow Archive Scanning                         | Allowed. Scans the archive files.     |
| Allow Behavior Monitoring                      | Allowed. Turns on real-time behavior monitoring. |
| Allow Email Scanning                           | Allowed. Turns on email scanning.     |
| Allow Full Scan Removable Drive Scanning      | Allowed. Scans removable drives.      |
| Allow Scanning Network Files                   | Allowed. Scans network files.         |
| Enable Network Protection                      | Enabled (audit mode)                   |
| PUA Protection                                | PUA Protection on. Detected items are blocked. They will show in history along with other threats. |
| Scan Parameter                                | Full scan                            |
| Real Time Scan Direction                       | Monitor all files (bi-directional).   |
| Schedule Scan Day                             | Every day                            |
| Schedule Scan Time                            | 120                                  |

![Defender_Policy](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/03_AzureAD_Sync_%26_Endpoint_Security/Screenshots/Defender_Policy.png)
---

### 🛡️ Step 4 – Assign Policy  

- Assign to group: `Windows 10/11 devices`
- Click **Next** then **Create**

![AV-ASSI](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/03_AzureAD_Sync_%26_Endpoint_Security/Screenshots/AV-ass.png)

---

### 🛡️ Step 5 – Validation (PowerShell)

- On a client machine, open PowerShell and run:  
  ```powershell
    Get-MpPreference | Select-Object `
    DisableRealtimeMonitoring, `
    CloudBlockLevel, `
    SubmitSamplesConsent, `
    DisableScriptScanning, `
    CheckForSignaturesBeforeRunningScan, `
    DisableScanningMappedNetworkDrivesForFullScan, `
    DisableArchiveScanning, `
    DisableBehaviorMonitoring, `
    DisableEmailScanning, `
    DisableRemovableDriveScanning, `
    DisableScanningNetworkFiles, `
    EnableNetworkProtection, `
    PUAProtection, `
    ScanParameters, `
    RealTimeScanDirection, `
    ScanScheduleDay, `
    ScanScheduleOffset
  ```
![Defender_Validation](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/03_AzureAD_Sync_%26_Endpoint_Security/Screenshots/Defender_Validation_Script.png)

### 🛡️ Step 6 - Review Policy Report
- Go to Devices > Configuration
- Select policy: Defender Antivirus Baseline 24H2
- Select View Report

![Defender_Report](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/03_AzureAD_Sync_%26_Endpoint_Security/Screenshots/Defender_Report.png)

---

## ✅ Conclusion

With Microsoft Defender Antivirus now configured via Intune:

- ✅ All managed devices receive consistent security settings automatically.  
- 🔍 Policy compliance and enforcement are validated via PowerShell or Intune reports.  
- 🛡️ The organization benefits from real-time, cloud-connected threat protection without manual configuration per device.

