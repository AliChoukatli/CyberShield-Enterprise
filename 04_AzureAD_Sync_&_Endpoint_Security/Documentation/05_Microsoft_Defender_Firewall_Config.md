# 🔥 Microsoft Defender Firewall Configuration

## 🎯 Objective

Ensure a secure and consistent firewall configuration across all network profiles (Domain, Private, Public) using Microsoft Defender Firewall. The goal is to block unsolicited inbound traffic and allow trusted outbound communication, following Zero Trust security principles.

## 📝 Introduction

This guide covers two approaches to configuring Microsoft Defender Firewall for enterprise environments:

- **Full Cloud:** Managing Azure AD joined devices via Microsoft Intune.  
- **Hybrid:** Managing Active Directory joined devices using Group Policy (GPO).

By applying these configurations, organizations can maintain a robust firewall posture across both modern cloud-managed and traditional on-premises devices.

---

## 📘 Table of Contents

* [🎯 Objective](#-objective)
* [✅ Method 1 - Hybrid with Group Policy (GPO)](#-method-1---hybrid-with-group-policy-gpo)
* [✅ Method 2 - Full Cloud with Microsoft Intune](#-method-2---full-cloud-with-microsoft-intune)
* [🔚 Conclusion](#-conclusion)
  
---

## ✅ Method 1 - Hybrid with Group Policy (GPO)

Used for on-premise Active Directory environments with GPO-based management.

### 🧭 **Steps**

1. Open the **Group Policy Management Console**: `gpmc.msc`
2. Edit an existing GPO that targets your devices, or create a new one and link it to the Organizational Unit (OU) containing the relevant computers
3. Navigate to:  
   `Computer Configuration` → `Policies` → `Windows Settings` → `Security Settings` → `Windows Defender Firewall with Advanced Security`
4. Click **Right-click Windows Defender Firewall with Advanced Security** and select **Properties**
5. Configure each profile (**Domain**, **Private**, **Public**) as follows:

## 🔥 Windows Defender Firewall – Recommended Global Settings

| Setting | Value | Description |
|---------|-------|-------------|
| **Firewall State** | ✅ Enabled (All Profiles) | Ensures firewall protection is active in all scenarios (Domain, Private, Public) |
| **Inbound Connections** | ✅ Block (Default) | Blocks all unsolicited incoming traffic unless explicitly allowed |
| **Outbound Connections** | ✅ Allow (Default) | Permits outbound traffic unless specifically blocked |
| **Inbound Rules** |  ✅ Allow only what's necessary | Define explicit rules for allowed services (e.g., RDP, SMB) |
| **Display a notification** | ❌ Disabled | Prevents unnecessary pop-ups and reduces exposure of blocked actions |
| **Allow unicast responses to multicast or broadcast** | ❌ Disabled | Prevents attackers from discovering devices through network scanning |
| **Logging: Dropped Packets** | ✅ Enabled | Helps in troubleshooting and auditing rejected connections |
| **Logging: Successful Connections** | ✅ Enabled (Hybrid only) | Useful in hybrid/on-prem environments for visibility, not required in full cloud |
| **Log File Path** | `%systemroot%\system32\LogFiles\Firewall\pfirewall.log` | Default location for firewall logs |
| **Log File Size Limit** | `16,384 KB` or more | Ensures sufficient history for auditing |

> 📝 **Note:** In Full Cloud deployments, logging successful connections may be optional to reduce noise and storage usage.

6. Ensure these settings are configured for the Domain Profile, Private Profile, and Public Profile tabs, then click OK.

7. Force a Group Policy update on client machines:

![GPO-Firewall](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/04_AzureAD_Sync_%26_Endpoint_Security/Screenshots/GPO-Firewall.png)

---


## ✅ Method 2 - Full Cloud with Microsoft Intune

Used for Azure AD-joined devices managed through Intune.

### 🧭 **Steps**

1. Go to **Microsoft Intune**:  
   `Endpoint security` → `Firewall` → `+ Create Policy`
2. Choose:
   - **Platform**: Windows 10 and later  
   - **Profile**: Windows Firewall

3. Give your policy a Name (e.g., Defender Firewall Baseline) and Description.
4. Configure the settings based on the recommendations below. These settings will apply to all network profiles (Domain, Private, Public) on the target devices.

![Firewall_Setting](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/04_AzureAD_Sync_%26_Endpoint_Security/Screenshots/Firewall_Setting.png)

5. Assign the policy to a target Azure AD group (e.g., All Windows 10/11 Devices).

6. Review and Create the policy to save and deploy.

---

## 🔚 Conclusion

Implementing Microsoft Defender Firewall with these recommended settings ensures baseline security for all managed endpoints. The dual approach using Intune and Group Policy accommodates diverse infrastructure needs while maintaining consistent enforcement of firewall policies. Proper firewall configuration is a crucial layer in a comprehensive Zero Trust security model, protecting devices from unauthorized network access while enabling legitimate communications.

