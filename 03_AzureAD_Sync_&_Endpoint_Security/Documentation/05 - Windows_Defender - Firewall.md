# 🛡️ Defender, Firewall & User Rights (via Intune)

## 🎯 Objective
To apply Microsoft recommended security configurations using the **Windows 10 and later Security Baseline** in Intune.  
Focus: Defender Antivirus, Firewall settings, and User Rights assignments.

# Configure Microsoft Defender Antivirus via Intune Endpoint Security

## Objective  
Apply Microsoft recommended Defender Antivirus settings using Intune Endpoint Security Antivirus policy.

---

## 🛡️ Step 1 – Access Endpoint Security Policies  
1. Go to [https://intune.microsoft.com](https://intune.microsoft.com)  
2. In the left menu, click **Endpoint security**  
3. Click on **Antivirus**  

## 🛡️ Step 2 – Create Antivirus Policy  
1. Click **+ Create Policy**  
2. Select:  
   - Platform: **Windows 10 and later**  
   - Profile: **Microsoft Defender Antivirus**  
3. Click **Create**  

## 🛡️ Step 3 – Configure Antivirus Settings  
1. Give your policy a name, e.g., `Defender Antivirus Baseline 24H2`  
2. Configure the following settings:  

# Microsoft Defender for Endpoint Configuration

## 🔒 Core Protection Settings

- **Turn on Microsoft Defender Antivirus**: ✔️ Enabled  
- **Real-Time Protection**: ✔️ Enabled  
- **Cloud-Delivered Protection**: ✔️ Enabled  
- **Automatic Sample Submission**: ✔️ Always send (no user prompt)  
- **Potentially Unwanted Application (PUA) Protection**: ✔️ Enabled  
- **Network Protection**: ✔️ Enabled (Block mode)  

---

## 🧠 Behavior Monitoring & File Scanning

- **Behavior Monitoring**: ✔️ Enabled  
- **Script Scanning (PowerShell, JavaScript, etc.)**: ✔️ Enabled  
- **Archive File Scanning (.zip, .rar, etc.)**: ✔️ Enabled  
- **Email Attachments & Downloads Scanning**: ✔️ Enabled  
- **Email Body Scanning**: ✔️ Enabled  
- **Network Files Scanning**: ✔️ Enabled  
- **Removable & Network Drive Scanning**: ✔️ Enabled  

---

## 🕒 Scheduled Scans

- **Scan Type**: Full Scan  
- **Frequency**: Daily  
- **Scheduled Time**: 2:00 AM  
- **Catch-up Scan (if device was off)**: ✔️ Enabled  
- **Low CPU Priority During Scan**: ✔️ Enabled  

---

## 🔁 Remediation & Quarantine

- **Automatic Actions**: ✔️ Enabled (Remove or Quarantine)  
- **User Interaction**: ❌ Disabled (no end-user decision)  
- **Quarantine Retention Period**: 30 Days  
- **Real-Time Threat Mitigation**: ✔️ Enabled  

---

## 🛡️ Attack Surface Reduction (ASR) Rules (Recommended)

- Block executable content from email/webmail  
- Block credential stealing from LSASS  
- Use advanced protection against ransomware  
- Block Office macros from the internet  
- Enable AMSI for Office applications  

---

## 📈 Reporting & Alerts

- **Alert Notifications**: ✔️ Enabled  
- **Device Compliance Reporting**: ✔️ Enabled  
- **Send data to Microsoft Security Center**: ✔️ Enabled  
- **Tamper Protection**: ✔️ Enabled (prevents settings changes)  

---

## 🔐 Additional Recommendations

- Integrate with **Microsoft Defender for Endpoint** for EDR, threat analytics, and advanced hunting.  
- Apply **Endpoint Detection and Response (EDR) in block mode**.  
- Combine with **Zero Trust policies** and **Conditional Access**.  
- Keep Defender and platform updates enabled via Windows Update or WSUS.  



3. Click **Next**  

---

## 🛡️ Step 4 – Assign Policy  
1. On the Assignments page, select the device group named Windows11/10 devices.

2. Click Next.

3. Then click Create to deploy the policy to all devices in that group.

![Defender_Policy](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/03_AzureAD_Sync_%26_Endpoint_Security/Screenshots/Defender_Policy.png)

## 🛡️ Step 5 – Validation  
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
