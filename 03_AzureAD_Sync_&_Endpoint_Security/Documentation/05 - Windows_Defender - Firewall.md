# 🛡️ Defender, Firewall & User Rights (via Intune)

## 🎯 Objective
To apply Microsoft recommended security configurations using the **Windows 10 and later Security Baseline** in Intune.  
Focus: Defender Antivirus, Firewall settings, and User Rights assignments.

# Deploy Microsoft Defender Antivirus Baseline via Intune (2025 Updated)

## Objective  
Apply Microsoft recommended security configurations for Microsoft Defender Antivirus on Windows 10/11 devices via Intune.

---

## Prerequisites  
- Access to [Microsoft Endpoint Manager](https://intune.microsoft.com)  
- Azure AD device groups ready for assignment

---

## Step-by-Step Deployment Guide

### Step 1 – Access Devices Configuration  
1. Sign in to [https://intune.microsoft.com](https://intune.microsoft.com)  
2. In the left menu, click **Devices**  
3. Click on **Configuration**  

### Step 2 – Create Defender Antivirus Profile  
1. Click **+ Create profile**  
2. Under **Platform**, select **Windows 10 and later**  
3. Under **Profile type**, select **Templates**  
4. From the list of templates, select **Microsoft Defender for Endpoint (Desktop devices running Windows 10 or later)**  
5. Click **Create**  

### Step 3 – Configure Profile  
1. Give the profile a clear name (e.g., `Defender Antivirus Baseline 24H2`)  
2. Click **Next** to navigate to configuration pages  
3. Configure Microsoft Defender Antivirus settings as follows:  

| Setting                              | Value           | Description                                     |
|------------------------------------|-----------------|-------------------------------------------------|
| Turn on Microsoft Defender Antivirus | ✅ Enabled       | Real-time protection enabled                      |
| Cloud-delivered protection          | ✅ Enabled       | Use Microsoft cloud for advanced threat protection |
| Submit samples automatically        | ✅ Send safe samples automatically | Automate sample submission, avoid user prompts   |
| Scan all downloaded files and attachments | ✅ Enabled | Ensures all downloads are scanned                 |
| Check for latest virus definitions before scan | ✅ Enabled | Keeps virus signatures updated                     |
| Scan mapped network drives during full scan | ✅ Enabled  | Detect lateral network threats                      |

4. Leave other settings as default or adjust based on your organization's needs  
5. Click **Next**  

### Step 4 – Assign the Profile  
1. Under **Assignments**, click **Add groups**  
2. Select your device groups to apply the profile  
3. Click **Next** and then **Create**  

---

## Step 5 – Validate Deployment  
- On a target device, open PowerShell and run:  
```powershell
Get-MpPreference
```
- Confirm Defender Antivirus is enabled and configured per the baseline
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
