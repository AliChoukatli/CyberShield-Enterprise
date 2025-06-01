# 🛡️  Microsoft Defender Antivirus & Defender for Endpoint Integration

# 🔹 Part 1 - Configure Microsoft Defender Antivirus via Intune

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
![Defender_Validation](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/03_AzureAD_Sync_%26_Endpoint_Security/Screenshots/Defender_Validation.png)

### 🛡️ Step 6 - Report
- Go to Devices > Configuration
- Select policy: Defender Antivirus Baseline 24H2
- Select View Report

![Defender_Report](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/03_AzureAD_Sync_%26_Endpoint_Security/Screenshots/Defender_Report.png)

---

# Part 2 - Onboard Devices to Microsoft Defender for Endpoint


# Microsoft Defender for Endpoint - Onboarding Windows Devices

To enable full integration between your Windows devices and Microsoft Defender for Endpoint (MDE), each device must be properly onboarded. Below are two common methods: **Local Script** and **Group Policy (GPO)**.

---

## ✅ Prerequisites

- A valid Microsoft Defender for Endpoint license (Plan 1/Plan 2, or Microsoft 365 E5 Security).
- Admin access on each machine.
- Internet connectivity for communication with MDE.

---

## 🔸 Method 1: Onboarding via Local Script (Recommended for testing or small environments)

### Steps:

1. **Go to the Microsoft 365 Defender portal**:  
   [https://security.microsoft.com](https://security.microsoft.com)

2. Navigate to:  
   `Settings` → `Endpoints` → `Onboarding`

3. Select the device type:  
   ➤ *Windows 10 and 11*

4. Under **Deployment method**, choose:  
   ➤ *Local Script*

5. Click **Download package** to get a `.zip` file containing the onboarding script.

6. On the target machine:
   - Extract the `.zip` file.
   - Open **PowerShell as Administrator**.
   - Run the onboarding script:

   ```cmd
   WindowsDefenderATPOnboardingScript.cmd
   ```
7. Wait a few minutes. The device should appear in the Defender portal under Device inventory.

---

## 🔸 Method 2: Onboarding via Group Policy (GPO)

This method is recommended for organizations managing domain-joined Windows devices via Group Policy.

---

### 🪟 Steps:

1. **Download the onboarding package:**
   - Go to [https://security.microsoft.com](https://security.microsoft.com)
   - Navigate to: `Settings → Endpoints → Onboarding`
   - Choose: **Windows 10 and 11**
   - Deployment method: **Group Policy**
   - Click **Download package** to get a `.zip` file

2. **Prepare the onboarding files:**
   - Extract the ZIP package
   - Locate:
     - The `.cmd` onboarding script
     - The `.adm` administrative template
   - Copy both files to a central and accessible location (e.g., a shared folder on the network)

3. **Open the Group Policy Management Console (GPMC)**:
   - On a domain controller, open `gpmc.msc`

4. **Create or edit an existing GPO** targeting the devices you want to onboard.

5. **Add the onboarding ADM template:**
   - Navigate to:  
     `Computer Configuration → Administrative Templates`
   - Right-click **Administrative Templates** and select **Add/Remove Templates**
   - Click **Add**, then select the `.adm` file from the extracted onboarding package

6. **Configure the onboarding policy:**
   - Go to:  
     `Computer Configuration → Administrative Templates → Windows Components → Windows Defender Antivirus → Microsoft Defender for Endpoint`
   - Open the policy setting: **"Specify onboarding script"** (or similar, based on template)
   - Enable the policy
   - Provide the path to the `.cmd` script (e.g., `\\server\share\WindowsDefenderATPOnboardingScript.cmd`)

7. **Apply the Group Policy:**
   - On target machines, run the following command to force policy update:

   ```cmd
   gpupdate /force
   ```
8. Verify onboarding success:

   - On client devices, use PowerShell to confirm:
  ```powershell
   Get-SenseManaged
   ```

   - If it returns True, the device is successfully onboarded to Microsoft Defender for Endpoint.
---

## 📌 Once onboarded, the device will begin sending telemetry and alerts to the Microsoft 365 Defender portal, visible under Device inventory.
