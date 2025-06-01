# 🔹Defender for Endpoint Onboarding.

-> To enable full integration between your Windows devices and Microsoft Defender for Endpoint (MDE), each device must be properly onboarded. Below are two common methods: **Local Script** and **Group Policy (GPO)**.

---

### 🟢 Method 1: Onboarding via Local Script (Full Cloud)

### Steps:

1. **Go to the Microsoft 365 Defender portal**:  [https://security.microsoft.com](https://security.microsoft.com)

2. Navigate to:  
   `Settings` → `Endpoints` → `Onboarding`

3. Connectivity type : Standard 

4. Select the device type:  
   ➤ *Windows 10 and 11*

5. Under **Deployment method**, choose:  
   ➤ *Local Script*

6. Click **Download package** to get a `.zip` file containing the onboarding script.

7. On the target machine:
   - Extract the `.zip` file.
   - Open **PowerShell as Administrator**.
   - Run the onboarding script:

   ```cmd
   WindowsDefenderATPOnboardingScript.cmd
   ```
8. Wait a few minutes. The device should appear in the Defender portal under Device inventory.

---

### 🟢  Method 2: Onboarding via Group Policy (GPO) (Hybride / On-premises)

This method is recommended for organizations managing domain-joined Windows devices via Group Policy.

---

### 🪟 Steps:

1. **Download the onboarding package:**
   - Go to the Microsoft 365 Defender portal:[https://security.microsoft.com](https://security.microsoft.com)
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
