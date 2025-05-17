# 🔐 BitLocker Configuration via Intune – Endpoint Protection Policy

## 🎯 Objective
To enforce BitLocker encryption on Windows 10/11 devices using Microsoft Intune, ensuring OS drives are secured and recovery information is safely stored in Azure AD.

---

## ✅ Steps to Configure BitLocker in Intune

### 1. Navigate to Disk Encryption
- Go to: **Intune Admin Center** → **Endpoint security** → **Disk encryption**

### 2. Create a New Policy
- Click **+ Create Policy**
- **Platform**: Windows 10 and later
- **Profile**: Endpoint Protection
- Click **Create**

---

### 3. Configure BitLocker Settings

#### 🔐 OS Drive Settings (BitLocker)
| Setting | Value | Description |
|--------|-------|-------------|
| **Enable full disk encryption for OS drives** | ✅ Yes | Enforces encryption of the system drive |
| **Encryption method for OS drive** | 🔐 XTS-AES 256-bit | Strongest recommended encryption |
| **Require device to back up recovery key to Azure AD** | ✅ Yes | Ensures recovery keys are securely saved |
| **Allow standard users to enable encryption during setup** | ✅ Yes | Useful if devices are enrolled by users |
| **Hide prompt about encryption method** | ✅ Yes | Simplifies the user experience |

---

### 4. Assign the Policy
- In the **Assignments** section:
  - Choose a group (e.g., `All Devices`, or `Security-Test` group)
- Click **Next** → then **Create**

---

## 📊 Monitoring
- Go to: **Endpoint security** → **Disk encryption**
- Click on your policy → Check **Per device status** and **Encryption compliance**

---

## 📌 Notes
- BitLocker policies are applied **separately** from security baselines.
- Ensure the device has TPM enabled in BIOS/UEFI for BitLocker to work.
- For best results, deploy this policy **at enrollment** or before shipping devices.

---

> This configuration is part of a layered security approach to ensure endpoint protection using encryption best practices.
