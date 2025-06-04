# 🔹Defender for Endpoint Onboarding

-> To enable full integration between your Windows devices and Microsoft Defender for Endpoint (MDE), each device must be properly onboarded. Below are two common methods: **Local Script** and **Group Policy (GPO)**.

---

## 🟢 Method 1 - Onboarding via Local Script (Single Device, Full Cloud)

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

## 🟢 Method 2 - Onboarding via Intune (Mulitple Devices / Full Cloud)

This guide explains how to onboard Windows 10/11 devices to Microsoft Defender for Endpoint using Microsoft Intune in a full cloud environment (Azure AD joined devices).

---
### Step 1 – Create an onboarding profile for Defender for Endpoint

1. In the Microsoft Endpoint Manager portal ([https://endpoint.microsoft.com](https://endpoint.microsoft.com)), go to **Devices** in the left-hand menu.
2. Click on **Configuration**.
3. Click **+ Create profile**.
4. For **Platform**, select **Windows 10 and later**.
5. For **Profile type**, select **Templates**.
6. Choose **Microsoft Defender for Endpoint (Desktop devices running Windows 10 or later)**.
7. Click **Create**.
8. Give the profile a name, e.g., `Defender for Endpoint Onboarding`.
9. Configure the following settings:
    
| Setting                                | Value      | Description                                                                |
|----------------------------------------|------------|----------------------------------------------------------------------------|
| Sample sharing for all files           | ❌ Block   | Blocks automatic sample sharing to Microsoft for privacy.                  |
| Expedite telemetry reporting frequency | ✅ Enable     | Enables more frequent telemetry data reporting for faster threat detection. |

10. Click **Next**.

---

### Step 2 – Assignments

1. Under **Assignments**, select the Azure AD groups that include the devices to onboard.
   - EG:  assign to **Windows 10/11 Devices**
2. Click **Next** to continue.

---

### Step3 - Applicability Scope

| Rule Type          | Property     | Value(s)                                                        | Description                                                  |
|--------------------|--------------|-----------------------------------------------------------------|--------------------------------------------------------------|
|✅ Assign profile if  | OS version   | From `10.0.19041.0` to `10.0.99999.99999`                       | Apply to Windows 10 (2004+) and all Windows 11 versions      |
|✅ Assign profile if  | OS edition   | Enterprise, Professional, Education, Professional Education     | Only apply to supported business editions                    |


> **Note:** Adjust version numbers or add rules as needed to target specific devices.

### Step 3 – Review and create

1. Review the profile settings.

![Defender_EP_intune](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/03_AzureAD_Sync_%26_Endpoint_Security/Screenshots/Defender_EP_intune.png)

3. Click **Create** to deploy the profile.

---

### Step 4 – Verify onboarding on target devices

1. Go to **Devices** in the Microsoft Endpoint Manager admin center.
2. Click on **Configuration**.
3. Locate your **Defender for Endpoint onboarding** profile.
4. Check the **deployment status** and **device check-in results** to confirm successful application.


![Defender_EP_Overview](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/03_AzureAD_Sync_%26_Endpoint_Security/Screenshots/Defender_Endpoint_Overview.png)

or On any onboarded Windows 10/11 device:

1. Open **PowerShell** as Administrator.
2. Check if the **Sense** service (Microsoft Defender for Endpoint sensor) is running:

   ```powershell
   Get-Service -Name Sense
   ```
   - Status should be Running.

3. Check onboarding state from the registry:
```powershell
(Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows Advanced Threat Protection\Status").OnboardingState
```
- A value of 1 means the device is successfully onboarded.

---

## 🟢  Method 3 - Onboarding via Group Policy (GPO) (Hybride / On-premises)

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
### 📦 Step 3 – Create a network shared folder for onboarding files

1. On your Domain Controller (DC) or a file server, create a folder, e.g., `C:\Onboarding`.  
2. Copy the following files into this folder:  
   - `WindowsDefenderATPOnboardingScript.cmd`   
3. Share this folder over the network with read permissions for the computers and users that will apply the GPO.  
   - Example share path: `\\DC01\Onboarding`  
4. Make sure the shared folder is accessible by target devices.

![Onboarding_Sharing](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/03_AzureAD_Sync_%26_Endpoint_Security/Screenshots/Onboarding_Sharing.png)

---

### 📦 Step 4 – Add the onboarding ADMX template to Group Policy

1. Open **Group Policy Management Console (GPMC)** by running `gpmc.msc` on the DC.  
2. If you want to add the template to the Central Store:  
   - Copy the `.admx` file to `\\<domain>\SYSVOL\<domain>\Policies\PolicyDefinitions\`  
   - Copy the `.adml` file to the corresponding language folder, e.g., `en-US`
  
![ADMX](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/03_AzureAD_Sync_%26_Endpoint_Security/Screenshots/admx.png)

---

### 📦 Step 5 – Configure the onboarding policy in GPO

1. Edit or create a GPO that targets the devices you want to onboard.  
2. Navigate to: `Computer Configuration → Policies → Windows Settings → Scripts (Startup/Shutdown)`  
3. Select **Startup**, then click **Properties**.
4. Click **Add...**, then **type the path of on your shared folder** (e.g., `\\DC1\Onboarding\WindowsDefenderATPOnboardingScript.cmd`).
5. Add the script and confirm.
6. **Apply the Group Policy:**
   - On target machines, run the following command to force policy update:

   ```cmd
   gpupdate /force
   ```
### 📦 Step 6 - Verify onboarding success:

On client devices, use PowerShell to confirm onboarding status:

```powershell
# Check onboarding state from registry (1 = onboarded)
$onboardingState = (Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows Advanced Threat Protection\Status" -ErrorAction SilentlyContinue).OnboardingState

if ($onboardingState -eq 1) {
    Write-Output "✅ Device is successfully onboarded to Microsoft Defender for Endpoint."
} else {
    Write-Output "❌ Device is NOT onboarded to Microsoft Defender for Endpoint."
}

# Optional: Check that the Sense Service((Windows Defender Advanced Threat Protection) is running
$senseService = Get-Service -Name Sense -ErrorAction SilentlyContinue
if ($senseService.Status -eq 'Running') {
    Write-Output "✅ Sense service is running."
} else {
    Write-Output "❌ Sense service is NOT running."
}
```
![Verif_Onboard_PS](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/03_AzureAD_Sync_%26_Endpoint_Security/Screenshots/verif_onboard_PS.png)

---

## 🔹 Conclusion

Onboarding devices to **Microsoft Defender for Endpoint** enables enhanced security and centralized management.

- Use **Local Script** for cloud-only or standalone devices.
- Use **Group Policy (GPO)** for domain-joined devices.

Verify onboarding by checking the registry and ensuring the **Sense service** is running. Once onboarded, manage and monitor devices via the Microsoft 365 Defender portal.

