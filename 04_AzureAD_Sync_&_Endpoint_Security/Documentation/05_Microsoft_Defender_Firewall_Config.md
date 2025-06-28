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

1. [Objective](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/04_AzureAD_Sync_%26_Endpoint_Security/Documentation/05_Microsoft_Defender_Firewall_Config.md#-objective)  
2. [Method 1: Full Cloud with Microsoft Intune](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/04_AzureAD_Sync_&_Endpoint_Security/Documentation/05_Microsoft_Defender_Firewall_Config.md#%EF%B8%8F-method-1-full-cloud-with-microsoft-intune)  
3. [Method 2: Hybrid with Group Policy (GPO)](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/04_AzureAD_Sync_&_Endpoint_Security/Documentation/05_Microsoft_Defender_Firewall_Config.md#-method-2-hybrid-with-group-policy-gpo)  
4. [Best Practices](#best-practices)  

---

## 🎯 Objective

To ensure a secure and consistent firewall configuration across all network profiles (Domain, Private, Public) using Microsoft Defender Firewall, aligned with Zero Trust principles. The firewall should block unsolicited inbound traffic and allow trusted outbound communication.

---

## ✅ Method 1: Full Cloud with Microsoft Intune

Used for Azure AD-joined devices managed through Intune.

### 📦 Steps

1. Go to **Microsoft Intune**:  
   `Endpoint security` → `Firewall` → `+ Create Policy`
2. Choose:
   - **Platform**: Windows 10 and later  
   - **Profile**: Windows Firewall

3. Recommanded Setting

![Firewall_Setting](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/04_AzureAD_Sync_%26_Endpoint_Security/Screenshots/Firewall_Setting.png)

4. Do the same setting to Public and Private network
5. Assign the policy to a target Azure AD group  
6. Save and deploy

---

## ✅ Method 2: Hybrid with Group Policy (GPO)

Used for on-premise Active Directory environments with GPO-based management.

### ✅ Steps

1. Open the **Local Group Policy Editor**: `gpedit.msc`
2. Navigate to:  
   `Computer Configuration` → `Policies` → `Windows Settings` → `Security Settings` → `Windows Defender Firewall with Advanced Security`
3. Click **Windows Defender Firewall Properties**
4. Configure each profile (**Domain**, **Private**, **Public**) as follows:

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


![GPO-Firewall](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/04_AzureAD_Sync_%26_Endpoint_Security/Screenshots/GPO-Firewall.png)

5. Apply this options on Public and Private Profile and Select `Ok`

---

## ✅ Conclusion

Implementing Microsoft Defender Firewall with these recommended settings ensures baseline security for all managed endpoints. The dual approach using Intune and Group Policy accommodates diverse infrastructure needs while maintaining consistent enforcement of firewall policies. Proper firewall configuration is a crucial layer in a comprehensive Zero Trust security model, protecting devices from unauthorized network access while enabling legitimate communications.

