# 🛡️ Phase 4 - Windows Security Baseline – Defender, Firewall & User Rights (via Intune)

## 🎯 Objective
To apply Microsoft recommended security configurations using the **Windows 10 and later Security Baseline** in Intune.  
Focus: Defender Antivirus, Firewall settings, and User Rights assignments.

---

## ✅ Baseline Used

- **Baseline Name**: Security Baseline for Windows 10 and later
- **Version**: 24H2
- **Deployed via**: Intune → Endpoint Security → Security Baselines

---

## 🦠 Microsoft Defender Antivirus Settings

| Setting | Value | Description |
|--------|-------|-------------|
| **Turn on Microsoft Defender Antivirus** | ✅ Enabled | Ensures real-time protection is active |
| **Cloud-delivered protection** | ✅ Enabled | Leverages Microsoft cloud for up-to-date protection |
| **Submit samples to Microsoft automatically** | ✅ Send safe samples automatically | Prevents user prompts during scans |
| **Scan all downloaded files and attachments** | ✅ Enabled | Scans every file for threats |
| **Check for latest virus definitions before scan** | ✅ Enabled | Ensures up-to-date definitions |
| **Scan mapped network drives during full scan** | ✅ Enabled | Ensures lateral threats are detected |

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
