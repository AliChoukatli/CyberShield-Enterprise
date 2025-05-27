# 🛡️ Defender, Firewall & User Rights (via Intune)

## 🎯 Objective
To apply Microsoft recommended security configurations using the **Windows 10 and later Security Baseline** in Intune.  
Focus: Defender Antivirus, Firewall settings, and User Rights assignments.

# 🛡️ Step-by-Step: Applying Microsoft Defender Antivirus Baseline via Intune (P1)

This guide explains how to deploy the **Microsoft recommended Defender Antivirus settings** using the **Windows 10 and later Security Baseline (version 24H2)** in Microsoft Intune.

---

## 🎯 Objective

Deploy Defender Antivirus settings through Intune to ensure real-time protection, cloud-delivered intelligence, and optimal malware defense across your endpoints.

---

## ✅ Prerequisites

- Microsoft Intune subscription (P1 is sufficient)
- At least one Windows 10/11 device enrolled and assigned to a group
- Admin access to Intune portal: [https://intune.microsoft.com](https://intune.microsoft.com)

---

## 🧭 Step-by-Step Instructions

### 🔹 Step 1 – Access Security Baselines

1. Go to: [https://intune.microsoft.com](https://intune.microsoft.com)
2. In the left-hand menu, click on **Endpoint Security**
3. Select **Security Baselines**
4. Click **+ Create Profile**
5. Select:
   - **Platform**: Windows 10 and later
   - **Profile**: *Security Baseline for Windows 10 and later*
   - **Version**: *24H2*
6. Click **Create**

---

### 🔹 Step 2 – Configure Defender Antivirus Settings

1. Name your profile (e.g., `Defender Baseline 24H2`)
2. Click **Next** until you reach the **Microsoft Defender Antivirus** section.
3. Make sure the following settings are configured:

| Setting                                             | Value                                  |
|-----------------------------------------------------|----------------------------------------|
| Turn on Microsoft Defender Antivirus                | ✅ Enabled                              |
| Cloud-delivered protection                          | ✅ Enabled                              |
| Submit samples to Microsoft automatically           | ✅ Send safe samples automatically      |
| Scan all downloaded files and attachments           | ✅ Enabled                              |
| Check for latest virus definitions before each scan | ✅ Enabled                              |
| Scan mapped network drives during full scan         | ✅ Enabled                              |

4. Leave other settings as default, or configure them based on your organization.
5. Click **Next**, assign the baseline to a **device group**, and complete the wizard.

---

### 📸 Recommended Screenshots

> Make sure your screenshots are clean, full-screen, and well-labeled.

1. **Baseline Overview**
   - Location: Endpoint Security → Security Baselines
   - Show: Your new profile (name, version, type)

2. **Defender Settings**
   - Click on the created profile → Edit or View Report
   - Show: The six Antivirus settings marked as "Configured"

3. **Device Assignment (Optional)**
   - Location: Endpoint Security → Security Baselines → Assigned groups
   - Show: At least one group with enrolled test device(s)

---

## 🧪 Validation (Optional)

You can validate if the settings are applied by:

- Navigating to **Devices → [Your device] → Endpoint Security**
- Or running `Get-MpPreference` in PowerShell on the client machine

---

## ✅ Summary

| Task                                      | Status       |
|-------------------------------------------|--------------|
| Baseline profile created in Intune        | ✅ Completed |
| Defender Antivirus settings configured    | ✅ Completed |
| Profile assigned to test devices          | ⬜ To do     |
| Screenshots captured and documented       | ⬜ To do     |

---

## 📝 Notes

- These Defender settings follow Microsoft’s security recommendations as of version 24H2.
- You can reuse this baseline structure for other profiles like Firewall and User Rights.


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
