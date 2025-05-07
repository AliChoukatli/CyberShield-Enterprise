# Phase 5: Security & Zero Trust (MFA, CA, BitLocker)

## 🎯 Objectives
This day focuses on enhancing security following a Zero Trust approach by enabling:
- Multi-Factor Authentication (MFA)
- Conditional Access (CA)
- BitLocker encryption
- A basic PowerShell script to check device security status

---

## 1. 🔐 Multi-Factor Authentication (MFA)
### Why?
MFA adds an extra layer of security by requiring users to provide two or more verification factors.

### 🔧 Steps:
- Go to [Microsoft 365 Admin Center](https://admin.microsoft.com)
- Navigate to **Users > Active Users**
- Click **Multi-factor authentication** on the top menu
- Enable MFA for test users or all users

### 📸 Capture to Take:
- The MFA management page with at least one user activated

---

## 2. 🎯 Conditional Access (CA)
### Why?
Conditional Access policies help control how and when users access your resources.

### 🔧 Steps:
- Go to [Microsoft Entra Portal](https://entra.microsoft.com)
- Navigate to **Protection > Conditional Access**
- Click **+ New policy**
- Name: Block Legacy Authentication (or any policy you define)
- Assign to test users
- Cloud apps: Select Microsoft 365
- Conditions: Choose client apps, select legacy auth protocols
- Access Controls: Block access
- Turn On: Yes

### 📸 Capture to Take:
- Conditional Access policy page with your settings visible

---

## 3. 💾 BitLocker Device Encryption
### Why?
BitLocker protects data by encrypting the entire drive.

### 🔧 Steps:
- On the client machine, search for **BitLocker** in Start Menu
- Click **Turn on BitLocker** for the system drive
- Save recovery key to a secure location (e.g., USB or OneDrive)
- Let encryption complete

### 📸 Capture to Take:
- BitLocker encryption status screen

---

## 4. 📜 PowerShell Script: Get-SecurityStatus.ps1
### Why?
To collect basic security status info like firewall, antivirus, and BitLocker state.

### 🧰 Sample Script:
```powershell
Get-BitLockerVolume
Get-MpComputerStatus | Select-Object AMServiceEnabled, AntispywareEnabled, RealTimeProtectionEnabled
Get-NetFirewallProfile | Select-Object Name, Enabled
```

### 📸 Capture to Take:
- Screenshot of script execution and output

---

## 🧠 Pro Tips:
- Use Conditional Access templates from Microsoft to quickly deploy recommended policies
- Set BitLocker policy via Intune later (Day 4+)
- Add exclusions to Defender if you're using testing tools

---

✅ At the end of Phase 6, you should have a working MFA, a Conditional Access policy, BitLocker enabled, and a way to check your security posture via PowerShell.

Ready for Day 4: Active Directory User Management & IT Support Tasks? Let's go! 🚀



