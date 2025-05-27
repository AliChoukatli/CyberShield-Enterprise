# 🛡️ Defender, Firewall & User Rights (via Intune)

## 🎯 Objective
To apply Microsoft recommended security configurations using the **Windows 10 and later Security Baseline** in Intune.  
Focus: Defender Antivirus, Firewall settings, and User Rights assignments.

# Deploy Microsoft Defender Antivirus Baseline via Intune

## Objective  
Apply Microsoft recommended security configurations for Microsoft Defender Antivirus using the Windows 10 and later Security Baseline (version 24H2) in Intune.

---

## Prerequisites  
- Access to [Microsoft Endpoint Manager Admin Center](https://intune.microsoft.com)  
- Device groups already created in Azure AD for assignment

---

## Step-by-Step Deployment Guide

### Step 1 – Access Devices Configuration  
1. Log in to [https://intune.microsoft.com](https://intune.microsoft.com)  
2. In the left-hand menu, click **Devices**  
3. Click on **Configuration** (or **Configuration profiles**)  

### Step 2 – Create Security Baseline Profile  
1. Click **+ Create profile** (top menu)  
2. In the profile creation window, select the tab **Templates**  
3. From the list, select **Security baselines**  
4. Choose **Security Baseline for Windows 10 and later (version 24H2)**  
5. Click **Create**  

### Step 3 – Configure Profile  
1. Provide a clear name for your profile, e.g., `Defender Antivirus Baseline 24H2`  
2. Click **Next** to navigate through configuration pages until you reach **Microsoft Defender Antivirus** settings  
3. Verify the following settings are enabled by default (Microsoft recommended):  

| Setting                              | Value           | Description                                     |
|------------------------------------|-----------------|-------------------------------------------------|
| Turn on Microsoft Defender Antivirus | ✅ Enabled       | Real-time malware protection activated          |
| Cloud-delivered protection          | ✅ Enabled       | Leverages Microsoft cloud protection             |
| Submit samples automatically        | ✅ Send safe samples automatically | Avoids user prompts during scans               |
| Scan all downloaded files and attachments | ✅ Enabled | Ensures downloaded files are scanned             |
| Check for latest virus definitions before each scan | ✅ Enabled | Keeps virus signatures up to date                |
| Scan mapped network drives during full scan | ✅ Enabled  | Detects lateral network threats                   |

4. Leave other settings as default or customize if needed  
5. Click **Next**

### Step 4 – Assign the Profile  
1. Under **Assignments**, click **Add groups**  
2. Select the device group(s) to which you want to apply this baseline (e.g., your test devices)  
3. Click **Next** then **Create** to finish the deployment  

---

## Step 5 – Validation (Optional)  
On a targeted device, open PowerShell and run:  
```powershell
Get-MpPreference

---

## 🔥 Windows Firewall Settings

| Setting | Value | Description |
|--------|-------|-------------|
| **Enable Windows Defender Firewall (Domain, Private, Public)** | ✅ Enabled | Ensures all profiles are protected |
| **Apply local firewall rules** | ✅ Yes | Merges local firewall rules unless explicitly blocked |
| **Apply local connection security rules** | ✅ Yes | Allows local IPsec rules |
| **Inbound connections** | Block (default) | Blocks unsolicited incoming traffic |
| **Outbound connections** | Allow (default) | Allows trusted outbound traffic |

---

## 👤 User Rights Assignment Settings

| Setting | Value | Description |
|--------|-------|-------------|
| **Allow log on locally** | ✅ Administrators only | Prevents unauthorized logon |
| **Deny access to this computer from the network** | ✅ Guests | Hardens remote access exposure |
| **Deny log on through Remote Desktop Services** | ✅ Guests | Reduces RDP attack surface |
| **Shut down the system** | ✅ Administrators | Restricts who can power off machines |
| **Access this computer from the network** | ✅ Administrators, Authenticated Users | Ensures only trusted users have network access |

---

## 🧠 Notes

- These settings apply automatically once assigned to a device group.
- Devices must check in to Intune to receive policy updates.
- User Rights hardening helps prevent lateral movement in case of compromise.
- Defender AV and Firewall ensure compliance with endpoint protection baselines.

---

> This baseline is essential for maintaining core endpoint protection on all corporate-managed Windows devices.
