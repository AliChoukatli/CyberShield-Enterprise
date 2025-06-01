# 🔹Defender for Endpoint Onboarding.

-> To enable full integration between your Windows devices and Microsoft Defender for Endpoint (MDE), each device must be properly onboarded. Below are two common methods: **Local Script** and **Group Policy (GPO)**.

---

### 🟢 Method 1: Onboarding via Local Script (Full Cloud)

1. Go to the Microsoft 365 Defender portal:  [https://security.microsoft.com](https://security.microsoft.com)

2. Navigate to:  
   `Settings` → `Endpoints` → `Onboarding`

3. Connectivity type : Standard 

4. Select the device type:  
   ➤ *Windows 10 and 11*

5. Under **Deployment method**, choose:  
   ➤ *Local Script*

6. Click **Download package** to get a `.zip` file containing the onboarding script.

![OnBoarding_Page](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/03_AzureAD_Sync_%26_Endpoint_Security/Screenshots/OnBoarding_Page.png)

7. On the target machine:
   - Extract the `.zip` file.
   - Open **PowerShell as Administrator**.
   - Run the onboarding script:

   ```cmd
   WindowsDefenderATPOnboardingScript.cmd
   ```
![Script_Successful](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/03_AzureAD_Sync_%26_Endpoint_Security/Screenshots/Successful_Onboard_cmd.png)

8. Wait a few minutes. The device should appear in the Defender portal under Device inventory.

![LTP-HLP_DEF_Status](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/03_AzureAD_Sync_%26_Endpoint_Security/Screenshots/LTP-HLP_DEF_Status.png)

---

### 🟢  Method 2: Onboarding via Group Policy (GPO) (Hybride / On-premises)

This method is recommended for organizations managing domain-joined Windows devices via Group Policy.


### 📦 Step 1 – Download the Onboarding Package

1. Go to the Microsoft 365 Defender portal: [https://security.microsoft.com](https://security.microsoft.com)
2. Navigate to: **Settings → Endpoints → Onboarding**
3. Platform: **Windows 10 and 11**
4. Deployment Method: **Group Policy**
5. Click **Download package**

This will download a `.zip` file containing:

- `WindowsDefenderATPOnboardingScript.cmd`
- `WindowsDefenderATPOnboarding.admx`
- `WindowsDefenderATPOnboarding.adml`

---

### 📦 Step 2 – Prepare the Files

1. Extract the `.zip` package
2. Copy:
   - The `.cmd` onboarding script to a shared location (e.g. `\\DC1\Onboarding\WindowsDefenderATPOnboardingScript.cmd`)
   - The `.admx` file to: `C:\Windows\PolicyDefinitions`
   - The `.adml` file to: `C:\Windows\PolicyDefinitions\en-US` (or your language folder)

---
   - Copy both files to a central and accessible location (e.g., a shared folder on the network)

3. **Open the Group Policy Management Console (GPMC)**:
   - On a domain controller, open `gpmc.msc`

4. **Create or edit an existing GPO** targeting the devices you want to onboard. `eg: Devices`

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
