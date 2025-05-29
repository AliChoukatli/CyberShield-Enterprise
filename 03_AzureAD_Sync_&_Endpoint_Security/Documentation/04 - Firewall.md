
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
   - **Profile**: Microsoft Defender Firewall
3. For each network profile (**Domain**, **Private**, **Public**), configure the following:

| Setting                                | Value           |
|----------------------------------------|-----------------|
| Firewall state                         | **Enabled**     |
| Inbound connections                    | **Block (default)** |
| Outbound connections                   | **Allow (default)** |
| Allow local firewall rules             | **Yes**         |
| Allow local connection security rules  | **Yes**         |

4. Assign the policy to a target Azure AD group  
5. Save and deploy

---

## 🏢 Method 2: Hybrid with Group Policy (GPO)

Used for on-premise Active Directory environments with GPO-based management.

### ✅ Steps

1. Open the **Local Group Policy Editor**: `gpedit.msc`
2. Navigate to:  
   `Computer Configuration` → `Windows Settings` → `Security Settings` → `Windows Defender Firewall with Advanced Security`
3. Click **Windows Defender Firewall Properties**
4. Configure each profile (**Domain**, **Private**, **Public**) as follows:

| Setting                                | Value           |
|----------------------------------------|-----------------|
| Firewall state                         | **On (recommended)** |
| Inbound connections                    | **Block (default)** |
| Outbound connections                   | **Allow (default)** |
| Apply local firewall rules             | **Yes**         |
| Apply local connection security rules  | **Yes**         |

5. Apply and close

---

## ✅ Best Practices

- Enable logging for dropped packets and successful connections
- Use firewall rules to explicitly allow required apps and ports
- Block all unsolicited inbound connections by default
- Regularly review and audit firewall policies

---

## 📸 Screenshots

Place all relevant screenshots in the `/04 Azure AD and Endpoint Security/Firewall Configuration/` folder:

- `intune-firewall-policy.png`  
- `domain-profile-settings.png`  
- `private-profile-settings.png`  
- `public-profile-settings.png`  
- `gpo-domain-profile.png` *(if applicable)*  
- `gpo-private-profile.png` *(if applicable)*  
- `gpo-public-profile.png` *(if applicable)*  

---

> ✅ This dual-method approach ensures your project is adaptable for both modern and legacy enterprise environments.
