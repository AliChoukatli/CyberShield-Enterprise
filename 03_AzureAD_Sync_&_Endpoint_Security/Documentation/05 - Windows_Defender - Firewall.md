# 🛡️ Defender, Firewall & User Rights (via Intune)

## 🎯 Objective
To apply Microsoft recommended security configurations using the **Windows 10 and later Security Baseline** in Intune.  
Focus: Defender Antivirus, Firewall settings, and User Rights assignments.

# Deploy Microsoft Defender Antivirus Baseline via Intune

## Step 1 – Create a Security Baseline Profile

- Go to https://intune.microsoft.com  
- Navigate to **Devices → Configuration profiles**  
- Click **+ Create profile**  
- Select:  
  - Platform: Windows 10 and later  
  - Profile type: Security baseline  
- Click **Create**  
- Select **Security Baseline for Windows 10 and later (version 24H2)**  
- Click **Next**  

## Step 2 – Configure the Profile

- Name your profile (e.g., Defender Antivirus Baseline 24H2)  
- Click **Next** to browse the settings  
- In the **Microsoft Defender Antivirus** section, verify the following are enabled:  
  - Turn on Microsoft Defender Antivirus: Enabled  
  - Cloud-delivered protection: Enabled  
  - Submit samples automatically: Send safe samples automatically  
  - Scan all downloaded files and attachments: Enabled  
  - Check for latest virus definitions before each scan: Enabled  
  - Scan mapped network drives during full scan: Enabled  
- Leave other settings at default  
- Click **Next**  

## Step 3 – Assign the Profile

- In the **Assignments** page, click **Add groups**  
- Select your test devices group (e.g., Test Devices)  
- Click **Next** then **Create**  

## Step 4 – Validate Deployment

- On a target device, open PowerShell and run:  
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
