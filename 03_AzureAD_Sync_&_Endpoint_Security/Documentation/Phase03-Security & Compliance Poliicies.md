## ✅ Phase03 – Apply Security and Compliance Policies via Intune

🎯 **Objective**  
Manage security baselines and compliance rules to protect devices.


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

















---

### 🔐 1. Create and Assign a Security Baseline

1. Go to **Intune Admin Center** → **Endpoint security** → **Security baselines**.
2. Click **+ Create profile**.
3. Choose a baseline (e.g., *Microsoft Defender for Endpoint Baseline*).
4. Configure the settings as needed (password length, screen lock timeout, etc.).
5. Click **Next**, assign to a group (e.g., *All Devices* or a test group).
6. Click **Create**.

📸 **Screenshot to take:**  
- Security baseline configuration page.  
- Assignment summary with targeted group.

---

### 📋 2. Create and Enforce a Compliance Policy

1. Go to **Devices** → **Compliance policies** → **+ Create policy**.
2. Select platform: **Windows 10 and later**.
3. Name the policy (e.g., *Windows Compliance Policy*).
4. Configure rules:
   - Require password.
   - Require encryption (BitLocker).
   - Require antivirus enabled and up to date.
   - Require firewall enabled.
5. Click **Next**, assign the policy to a device group.
6. Click **Create**.

📸 **Screenshots to take:**  
- Each configured setting (password, encryption, antivirus, etc.).  
- Group assignment screen.

---

### 📊 3. Monitor Device Compliance

1. Go to **Devices** → **Monitor** → **Device compliance**.
2. Review compliance status:
   - Count of **compliant / non-compliant** devices.
   - Details of non-compliant reasons (e.g., antivirus not active).

📸 **Screenshots to take:**  
- Compliance summary dashboard.  
- Example of a non-compliant device and details of failure.

---

💡 **Tips**  
You can simulate non-compliance (e.g., by turning off antivirus) to test and generate alerts for your report/demo.

---

➡️ Ready to move to **Step 4 – Configure Device Profiles** when you're done.

