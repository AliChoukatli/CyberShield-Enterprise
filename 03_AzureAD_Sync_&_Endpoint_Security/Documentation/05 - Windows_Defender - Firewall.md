# 🛡️ Defender, Firewall & User Rights (via Intune)

## 🎯 Objective
To apply Microsoft recommended security configurations using the **Windows 10 and later Security Baseline** in Intune.  
Focus: Defender Antivirus, Firewall settings, and User Rights assignments.

# Configure Microsoft Defender Antivirus via Intune Endpoint Security

## Objective  
Apply Microsoft recommended Defender Antivirus settings using Intune Endpoint Security Antivirus policy.

---

## Step 1 – Access Endpoint Security Policies  
1. Go to [https://intune.microsoft.com](https://intune.microsoft.com)  
2. In the left menu, click **Endpoint security**  
3. Click on **Antivirus**  

## Step 2 – Create Antivirus Policy  
1. Click **+ Create Policy**  
2. Select:  
   - Platform: **Windows 10 and later**  
   - Profile: **Microsoft Defender Antivirus**  
3. Click **Create**  

## Step 3 – Configure Antivirus Settings  
1. Give your policy a name, e.g., `Defender Antivirus Baseline 24H2`  
2. Configure the following settings:  

# Microsoft Defender for Endpoint Configuration

| Setting                                      | Policy Name / Description                          | Expected Value / Notes                             |
|----------------------------------------------|--------------------------------------------------|---------------------------------------------------|
| Turn on Microsoft Defender Antivirus          | Allow Realtime Monitoring                         | Enable                                            |
| Cloud-delivered protection                    | Allow Cloud Protection                            | Enable                                            |
| Submit samples automatically                  | Submit Samples Consent                            | Send safe samples automatically (no user prompt) |
| Scan all downloaded files and attachments    | Allow scanning of all downloaded files and attachments | Enable                                    |
| Scan mapped network drives during full scan  | Allow Full Scan On Mapped Network Drives         | Enable                                            |


3. Leave other settings as default unless your company needs other specific settings  
4. Click **Next**  

## Step 4 – Assign Policy  
1. On the Assignments page, select the device group named Windows11/10 devices.

2. Click Next.

3. Then click Create to deploy the policy to all devices in that group.

![Defender_Policy](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/03_AzureAD_Sync_%26_Endpoint_Security/Screenshots/Defender_Policy.png)

## Step 5 – Validation  
- On a client machine, open PowerShell and run:  
  ```powershell
  Get-MpPreference
  ```
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
