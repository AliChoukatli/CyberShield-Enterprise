# 📲 Microsoft Intune – Device Enrollment & Auto-Registration

## 🎯 Objective
Ensure all Windows devices are automatically enrolled into Intune using Azure AD credentials via Group Policy, allowing centralized compliance and configuration enforcement.

---

## 📝 Introduction

This section guides you through enrolling Windows devices into **Microsoft Intune** for centralized management and security enforcement. After hybrid joining your devices to Azure AD, the next step is enabling **automatic MDM enrollment** via Group Policy and ensuring DNS resolution and connectivity to Microsoft services.

Whether deploying new machines or onboarding existing endpoints, this process allows IT admins to manage device compliance, apply security baselines, and monitor assets directly from the **Microsoft Endpoint Manager Admin Center**.

---

## 🧰 Prerequisites
- Microsoft 365 tenant with Intune licenses assigned (e.g., Business Premium)  
- Devices must be Hybrid Azure AD Joined or Azure AD Joined  
- Network connectivity allowing devices to reach Intune endpoints  
- User accounts with appropriate permissions to enroll devices  


## 🚀 **Steps:**

### 🚀 **Step 1 – Access the Intune Portal**
- Log in to the [Microsoft Endpoint Manager Admin Center](https://endpoint.microsoft.com/)  
- Confirm your admin account has the **Intune Administrator** role or equivalent  

![Intune-Admin](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/04_AzureAD_Sync_%26_Endpoint_Security/Screenshots/intune-admin.png)

---

### 🚀 **Step 2 – Configure Automatic Enrollment**
- Navigate to **Devices > Enroll devices > Automatic Enrollment**  
- Enable **MDM user scope** for targeted groups (e.g., All or specific Azure AD groups)  
- Save the configuration  

![Auto-Enrollement](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/04_AzureAD_Sync_%26_Endpoint_Security/Screenshots/auto-enrollement.png)

---

### 🚀 **Step 3 – Prepare Devices for Intune Enrollment via GPO**

💡 If you already created a GPO named `Auto Device Registration` for Hybrid Azure AD Join, you can now **extend** it to include Intune MDM auto-enrollment.

#### 📍 GPO Path:

Computer Configuration
→ Policies
→ Administrative Templates
→ Windows Components
→ MDM

---

#### 🛠️ Enable the following policy:

- **Policy Name**: *Enable automatic MDM enrollment using default Azure AD credentials*
- **State**: Enabled  
- **Option**: User Credential  
- 👉 Click **Apply**, then **OK**

📎 This policy ensures automatic enrollment into **Microsoft Intune** after Hybrid Azure AD Join.

---

#### 🔄 Apply the GPO:
Run the following command on the device or via deployment:

```bash
gpupdate /force
```

---

#### ✅ Additional Device Preparation Checklist:

- Ensure devices are **Hybrid Azure AD Joined** or **Azure AD Joined**
- Confirm all devices are **fully updated** with Windows Updates
- Verify each device user has a **valid Intune license** assigned

---

### 🚀 **Step 4 – DNS Forwarders**

Before enrolling devices, ensure your Domain Controller’s DNS can resolve internet domain names by configuring DNS forwarders. This step is essential for devices to communicate properly with Azure AD and Microsoft services during enrollment.

**Steps to configure DNS forwarders:**  
1. Open **DNS Manager** on your Domain Controller.  
2. Right-click your server name and select **Properties**.  
3. Go to the **Forwarders** tab.  
4. Add one or more reliable public DNS server IPs, such as:  
   - `8.8.8.8` (Google DNS)  
   - `1.1.1.1` (Cloudflare DNS)  
5. Click **OK** to save the settings.

This setup enables your DNS server to forward unresolved queries to public DNS servers, ensuring smooth device enrollment and uninterrupted internet access.

---

### 🚀 **Step 5 - Device Enrollment**

#### Enrolling New Devices (During OOBE)
- When setting up a new device for the first time (Out-of-Box Experience), **sign in with your Azure AD credentials**.
- This will automatically enroll the device into Azure AD and Intune.

#### Enrolling Existing Devices
- Users can manually enroll their existing devices by:  
  1. Opening **Settings**  
  2. Navigating to **Accounts**  
  3. Selecting **Access work or school**  
  4. Clicking **Connect** and signing in with their Azure AD account.

![Enroll Device Screenshot](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/04_AzureAD_Sync_%26_Endpoint_Security/Screenshots/Enroll-Connect.jpg)


- When you sign in, you will be prompted to secure your account using the Microsoft Authenticator app.
Simply follow the on-screen instructions and scan the provided QR code to complete the setup

![Enroll-Success](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/04_AzureAD_Sync_%26_Endpoint_Security/Screenshots/Enroll-Success.png)


#### Bulk Enrollment (Optional)
- For enrolling multiple devices at once, consider automating enrollment through:  
  - Group Policy for automatic enrollment configuration, or  
  - Provisioning packages for streamlined deployment.

---

### 🚀 **Step 6 – Verify Enrollment Status**
- In the Endpoint Manager portal, go to **Devices > All devices**  
- Confirm devices appear with status **Compliant** or **Enrolled**

![Devices-List](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/04_AzureAD_Sync_%26_Endpoint_Security/Screenshots/Devices-List.png)
  
- On client devices, run and you will see the MDM URL

```powershell
dsregcmd /status
```
Your environment is now ready to leverage **Microsoft Intune** for full device lifecycle management, including compliance monitoring, app deployment, and conditional access policy enforcement.
![dsregcmd-MDM](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/04_AzureAD_Sync_%26_Endpoint_Security/Screenshots/dsregcmd_mdm.png)

---

### 🔚 Conclusion

By completing this section, you have:

- Configured **automatic MDM enrollment** using Azure AD credentials via GPO.
- Verified DNS forwarders to ensure cloud connectivity.
- Understood the different methods to enroll new and existing devices.
- Validated successful Intune registration and device compliance.
