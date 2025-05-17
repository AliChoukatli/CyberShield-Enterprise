## ✅ Step 3 – Apply Security and Compliance Policies via Intune

🎯 **Objective**  
Manage security baselines and compliance rules to protect devices.

### 🔐 1. Create and Assign a Security Baseline

1. Go to **Intune Admin Center** → **Endpoint security** → **Security baselines**.
2. Click **+ Create profile**.
3. Choose a baseline (e.g., *Security Baseline for Windows 10 and later*).
4. Configure the settings as needed (password length, screen lock timeout, etc.).
5. Click **Next**, assign to a group (e.g., *All Devices* or a test group).
6. Click **Create**.

📸 **Screenshot to take:**  
- Security baseline configuration page.  
- Assignment summary with targeted group.

---

## 🔒 Recommended Settings – Windows Security Baseline (24H2)

This section highlights the most important security settings to enforce for Windows 10/11 endpoints in a small business environment.

---

### 🟦 BitLocker

| Setting | Recommended Value | Why |
|--------|--------------------|-----|
| Require BitLocker | ✅ Yes | Ensures full disk encryption |
| OS drive encryption method | XTS-AES 256-bit | Provides strong encryption |
| Back up recovery info to Azure AD | ✅ Yes | Automatically stores recovery key securely |

---

### 🟩 Windows Defender Antivirus

| Setting | Recommended Value | Why |
|--------|--------------------|-----|
| Real-time Protection | ✅ Enabled | Protects system continuously |
| Cloud-delivered protection | ✅ Enabled | Faster detection using Microsoft cloud |
| Submit samples automatically | ✅ Safe samples only | Helps improve Microsoft threat intelligence |
| Behavior Monitoring | ✅ Enabled | Detects suspicious behavior patterns |

---

### 🟥 Windows Defender Firewall

| Setting | Recommended Value | Why |
|--------|--------------------|-----|
| Firewall state (Domain/Private/Public) | ✅ On | Ensures network protection across all profiles |
| Inbound connections | Block (default) | Blocks unsolicited inbound traffic |

---

### 🟧 Security Options

| Setting | Recommended Value | Why |
|--------|--------------------|-----|
| Require password when computer wakes | ✅ Yes | Prevents unauthorized access after sleep |
| Administrator account status | ✅ Disabled | Disables the default local admin |
| Limit local accounts with blank passwords | ✅ Enabled | Prevents insecure logins |

---

### 🟨 Microsoft Defender SmartScreen

| Setting | Recommended Value | Why |
|--------|--------------------|-----|
| SmartScreen for Edge | ✅ Enabled | Blocks malicious sites and downloads |
| Prevent override | ✅ Enabled | Stops users from bypassing warnings |

---

### 🟪 User Rights Assignment

| Setting | Recommended Value | Why |
|--------|--------------------|-----|
| Deny log on locally (Guests) | ✅ Add Guests group | Prevents guest account usage |
| Allow log on locally | ✅ Users, Administrators | Restricts access to approved users |

---

📸 **Suggested Screenshots for GitHub:**
- Baseline configuration settings (full or by section)
- "Review + create" summary before creating
- Compliance status after deployment

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
