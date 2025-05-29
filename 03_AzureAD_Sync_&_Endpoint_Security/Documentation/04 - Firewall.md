
# 🔥 Windows Defender Firewall Configuration

This document covers the full configuration of Microsoft Defender Firewall using two approaches:

- ✅ **Full Cloud** — Using Microsoft Intune (Azure AD joined devices)
- 🏢 **Hybrid** — Using Group Policy (Active Directory joined devices)

---

## 📘 Table of Contents

1. [Objective](#objective)  
2. [Method 1: Full Cloud with Microsoft Intune](#method-1-full-cloud-with-microsoft-intune)  
3. [Method 2: Hybrid with Group Policy (GPO)](#method-2-hybrid-with-group-policy-gpo)  
4. [Best Practices](#best-practices)  
5. [Screenshots](#screenshots)

---

## 🎯 Objective

To ensure a secure and consistent firewall configuration across all network profiles (Domain, Private, Public) using Microsoft Defender Firewall, aligned with Zero Trust principles. The firewall should block unsolicited inbound traffic and allow trusted outbound communication.

---

## 🛡️ Method 1: Full Cloud with Microsoft Intune

Used for Azure AD-joined devices managed through Intune.

### ✅ Steps

1. Go to **Microsoft Intune**:  
   `Endpoint security` → `Firewall` → `+ Create Policy`
2. Choose:
   - **Platform**: Windows 10 and later  
   - **Profile**: Windows Firewall

3. Recommanded Setting

![Firewall_Setting](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/03_AzureAD_Sync_%26_Endpoint_Security/Screenshots/Firewall_Setting.png)

4. Do the same setting to Public and Private network
5. Assign the policy to a target Azure AD group  
6. Save and deploy

---

## 🏢 Method 2: Hybrid with Group Policy (GPO)

Used for on-premise Active Directory environments with GPO-based management.

### ✅ Steps

1. Open the **Local Group Policy Editor**: `gpedit.msc`
2. Navigate to:  
   `Computer Configuration` → `Policies` → `Windows Settings` → `Security Settings` → `Windows Defender Firewall with Advanced Security`
3. Click **Windows Defender Firewall Properties**
4. Configure each profile (**Domain**, **Private**, **Public**) as follows:

| Setting                                | Value           |
|----------------------------------------|-----------------|
| Firewall state                         | **On (recommended)** |
| Inbound connections                    | **Block (default)** |
| Outbound connections                   | **Allow (default)** |
| Apply local firewall rules             | **Yes**         |
| Apply local connection security rules  | **Yes**         |

![GPO-Firewall](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/03_AzureAD_Sync_%26_Endpoint_Security/Screenshots/GPO-Firewall.png)

5. Apply this options on Public and Private Profile and Select `Ok`

> ✅ This dual-method approach ensures your project is adaptable for both modern and legacy enterprise environments.

