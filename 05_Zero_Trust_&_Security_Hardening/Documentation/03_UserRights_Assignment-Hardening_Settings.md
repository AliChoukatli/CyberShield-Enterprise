# 👤 User Rights Assignment – Hardening Settings (Hybrid or Local AD Environnment)

## 📋 Overview
User Rights Assignment controls which users or groups have specific privileges on a system. Hardening these settings is essential to reduce attack surfaces and limit lateral movement.

## 🧭 Step-by-Step Guide (GPO)

### 1. 🎯 Open Group Policy Management Console (GPMC)
- On a domain-joined server or admin PC, run:
gpmc.msc

### 2. 🛠️ Create or Edit a GPO
- Right-click on the target OU (e.g., `Devices`)  
- Select `Create a GPO in this domain and Link it here...`  
- Name it: `Baseline – User Rights Assignment`  
- Right-click the GPO → `Edit`

### 3. 🔍 Navigate to the Policy Path:
Computer Configuration → Windows Settings → Security Settings → Local Policies → User Rights Assignment

### 4. 🧱 Apply Recommended Settings:
##### ✅ Recommended Settings

| Setting | Value | Description |
|--------|-------|-------------|
| **Allow log on locally** | ✅ `Administrators only` | Prevents unauthorized users from logging in at the console |
| **Deny access to this computer from the network** | ✅ `Guests` | Blocks remote access by unauthenticated users |
| **Deny log on through Remote Desktop Services** | ✅ `Guests` | Reduces RDP attack surface by denying unauthenticated sessions |
| **Shut down the system** | ✅ `Administrators` | Prevents standard users from powering off systems |
| **Access this computer from the network** | ✅ `Administrators, Authenticated Users` | Ensures only authorized users can connect over the network |


![UR-GPO](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/04_Zero%20Trust%20%26%20Security%20Hardening/Screenshots/User_Rights_GPO.png)

---

### 💡 Tips

- 🛡️ Avoid giving `Domain Users` access to “Allow log on locally” unless necessary.
- 🧪 Test GPO on limited OU before full deployment.
- 🔐 Combine with LAPS, BitLocker, and Defender policies for a full hardening baseline.

---

