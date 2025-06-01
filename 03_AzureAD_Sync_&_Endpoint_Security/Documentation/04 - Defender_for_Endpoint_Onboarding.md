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

![Onboarding_H](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/03_AzureAD_Sync_%26_Endpoint_Security/Screenshots/OnBoarding_Page_H.png)

---

### 📦 Step 2 – Prepare the Files

1. Extract the `.zip` package
2. Locate the following files inside the extracted folder:  
   - `WindowsDefenderATPOnboardingScript.cmd` (the onboarding script)  
   - `WindowsDefenderATPOnboarding.admx` (administrative template)  
   - `WindowsDefenderATPOnboarding.adml` (language file for the ADMX)
   
--- 
## 📦 Step 3 – Create a network shared folder for onboarding files

1. On your Domain Controller (DC) or a file server, create a folder, e.g., `C:\Onboarding`.  
2. Copy the following files into this folder:  
   - `WindowsDefenderATPOnboardingScript.cmd`   
3. Share this folder over the network with read permissions for the computers and users that will apply the GPO.  
   - Example share path: `\\DC1\Onboarding`  
4. Make sure the shared folder is accessible by target devices.

![Onboarding_Sharing](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/03_AzureAD_Sync_%26_Endpoint_Security/Screenshots/Onboarding_Sharing.png)

---

## 📦 Step 4 – Add the onboarding ADMX template to Group Policy

1. Open **Group Policy Management Console (GPMC)** by running `gpmc.msc` on the DC.  
2. If you want to add the template to the Central Store:  
   - Copy the `.admx` file to `\\<domain>\SYSVOL\<domain>\Policies\PolicyDefinitions\`  
   - Copy the `.adml` file to the corresponding language folder, e.g., `en-US`  
3. If you don't use a Central Store, add the template locally in GPMC:  
   - In GPMC, right-click **Administrative Templates** under a GPO → **Add/Remove Templates...**  
   - Click **Add**, then select the `WindowsDefenderATPOnboarding.admx` file.

---

## 📦 Step 5 – Configure the onboarding policy in GPO

1. Edit or create a GPO that targets the devices you want to onboard.  
2. Navigate to:  
   `Computer Configuration → Administrative Templates → Windows Components → Windows Defender Antivirus → Microsoft Defender for Endpoint`  
3. Open the policy **Specify onboarding script** (or similar name).  
4. Set the policy to **Enabled**.  
5. In the script path field, enter the UNC path to the onboarding script:  

7. **Apply the Group Policy:**
   - On target machines, run the following command to force policy update:

   ```cmd
   gpupdate /force
   ```
## 📦 Step 6 - Verify onboarding success:

   - On client devices, use PowerShell to confirm:
  ```powershell
   Get-SenseManaged
   ```

   - If it returns True, the device is successfully onboarded to Microsoft Defender for Endpoint.
---

## 📌 Once onboarded, the device will begin sending telemetry and alerts to the Microsoft 365 Defender portal, visible under Device inventory.
