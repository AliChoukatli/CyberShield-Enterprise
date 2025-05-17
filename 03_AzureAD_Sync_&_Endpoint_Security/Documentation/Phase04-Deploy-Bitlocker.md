## ✅ Phase 4 – Deploy BitLocker Encryption
🎯 Objective  
Protect data on devices by enabling BitLocker encryption.

- Deploy BitLocker policies via Intune or Group Policy.
- Ensure BitLocker recovery keys are backed up securely to Azure AD or on-premises AD.
- Monitor BitLocker encryption status on devices.


----


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

