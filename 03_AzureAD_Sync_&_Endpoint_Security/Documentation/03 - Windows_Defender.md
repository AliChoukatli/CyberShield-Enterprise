# 🛡️  Microsof Defender

## 🎯 Objective
To apply Microsoft recommended security configurations using the **Windows 10 and later Security Baseline** in Intune.  
Focus: Defender Antivirus, Firewall settings, and User Rights assignments.

# Configure Microsoft Defender Antivirus via Intune Endpoint Security

## Objective  
Apply Microsoft recommended Defender Antivirus settings using Intune Endpoint Security Antivirus policy.

---

## 🛡️ Step 1 – Access Endpoint Security Policies  
1. Go to [https://intune.microsoft.com](https://intune.microsoft.com)  
2. In the left menu, click **Endpoint security**  
3. Click on **Antivirus**  

## 🛡️ Step 2 – Create Antivirus Policy  
1. Click **+ Create Policy**  
2. Select:  
   - Platform: **Windows 10 and later**  
   - Profile: **Microsoft Defender Antivirus**  
3. Click **Create**  

## 🛡️ Step 3 – Configure Antivirus Settings  
1. Give your policy a name, e.g., `Defender Antivirus Baseline 24H2`  
2. Configure the following settings:  

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

## 🛡️ Step 4 – Assign Policy  
1. On the Assignments page, select the device group named Windows11/10 devices.

2. Click Next.

3. Then click Create to deploy the policy to all devices in that group.


## 🛡️ Step 5 – Validation  
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
![Defender_Validation](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/03_AzureAD_Sync_%26_Endpoint_Security/Screenshots/Defender_Validation.png)

## 🛡️ Step 6 - Report
- OR Go to Devices > Configuration > Defender Antivirus Baseline 24H2
- Select View Report

![Defender_Report](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/03_AzureAD_Sync_%26_Endpoint_Security/Screenshots/Defender_Report.png)

---


---



## 🧠 Notes

- These settings apply automatically once assigned to a device group.
- Devices must check in to Intune to receive policy updates.
- User Rights hardening helps prevent lateral movement in case of compromise.
- Defender AV and Firewall ensure compliance with endpoint protection baselines.

---

> This baseline is essential for maintaining core endpoint protection on all corporate-managed Windows devices.
