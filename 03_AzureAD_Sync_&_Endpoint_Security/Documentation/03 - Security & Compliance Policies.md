# ✅ Security & Compliance Policies

Now that device and user management is in place, this phase focuses on implementing key **security and compliance policies** to protect organizational resources.

---

## 🔐 Multi-Factor Authentication (MFA) – Recommended Methods


### FIDO2 Security Key (Passkey) – Recommended Settings

| Setting                     | Recommended Value | Description                                                                 |
|----------------------------|-------------------|-----------------------------------------------------------------------------|
| Allow self-service set up  | ✅ Yes            | Allows users to register their own FIDO2 security keys                      |
| Enforce attestation        | ❌ No             | Not required unless you need verified device metadata                      |
| Enforce key restrictions   | ✅ Yes            | Prevents use of unapproved or unknown FIDO2 keys                           |
| Restrict specific keys     | 🔒 Block          | Blocks specific keys by AAGUID (only if you want to restrict certain vendors) |
| Microsoft Authenticator    | ❌ No             | Not applicable for FIDO2; Microsoft Authenticator is a separate method     |



---


## 📱 Microsoft Authenticator – Recommended Settings

| Setting                                            | Recommended Value       | Description                                                                                   |
|----------------------------------------------------|--------------------------|-----------------------------------------------------------------------------------------------|
| **Enable and Target**                              | ✅ Enabled               | Method is enabled for users                                                                   |
| **Target**                                         | 🎯 All users             | Include all users or a specific security group                                                |
| **Allow use of Microsoft Authenticator OTP**       | ✅ Yes                  | Allows use of TOTP codes from the app in addition to push notifications                      |
| **Require number matching for push notifications** | ✅ Enabled (mandatory)   | Prevents MFA fatigue attacks by requiring users to enter the number shown on the screen      |
| **Show application name in notifications**         | ☁️ Microsoft-managed     | App name will be shown in push/passwordless notifications when rolled out by Microsoft       |
| **Show geographic location in notifications**      | ☁️ Microsoft-managed     | Location info is shown to help users detect suspicious logins                                |
| **Authenticator on companion apps**                | ☁️ Microsoft-managed     | Controls the use of Authenticator on devices like Apple Watch or other paired apps           |


| Method Name                  | Details                                                                 | Recommended Configuration                                                   |
|-----------------------------|-------------------------------------------------------------------------|------------------------------------------------------------------------------|
| Microsoft Authenticator     | Mobile app with push notifications. Most common and user-friendly.     | Enable push, number matching, and location context                          |
| Authenticator App (TOTP)    | Time-based one-time passcodes without push (offline mode).             | Enable as backup; enforce 6-digit codes, time-based                         |
| FIDO2 Security Key          | Physical security keys (e.g., YubiKey). Passwordless and phishing-resistant. | Require key registration; restrict to trusted devices                       |
| Temporary Access Pass (TAP) | Temporary one-time passcode used for first-time registration or recovery. | Enable one-time use, short lifetime (e.g., 1 hour), for registration only   |
| Windows Hello for Business  | Uses biometrics (face/fingerprint) or PIN tied to the device.          | Enable on compliant, hybrid-joined or Azure AD-joined devices               |
| SMS OTP                     | One-time passcode sent via text message. Convenient but less secure.   | Enable only as fallback; monitor for misuse; enforce phone number registration |


---

## 🎯 Conditional Access Policies

**Objective:** Define conditions and controls for secure sign-in and resource access.

### ✅ Key Policies to Implement:

### 1. **Block Legacy Authentication**
- Prevent sign-ins using outdated protocols (e.g., IMAP, POP).
- Policy settings:
  - **Users:** All users.
  - **Cloud apps:** All cloud apps.
  - **Conditions:** Client apps > Legacy authentication clients.
  - **Access controls:** Block access.

📸 *Insert screenshot: Legacy auth block policy.*

---

### 2. **Require MFA for All Users**
- Prompt MFA when accessing sensitive resources.

- **Users:** All users or targeted group.
- **Cloud apps:** Office 365 or All cloud apps.
- **Conditions:** Include all locations; exclude trusted locations if needed.
- **Access controls:** Grant access > Require MFA.

📸 *Insert screenshot: Conditional Access MFA policy.*

---

### 3. **Require Compliant or Hybrid Azure AD Joined Device**
- Restrict access only from trusted, managed devices.

- **Users:** All users.
- **Cloud apps:** All cloud apps.
- **Conditions:** Device state > Require compliant or hybrid Azure AD joined.
- **Access controls:** Grant access > Require device to be compliant.

📸 *Insert screenshot: Compliant device policy.*

---

### 4. **Block Access from Risky Sign-Ins**
- Automatically block sign-ins flagged as risky by Microsoft Entra ID.

- **Users:** All users.
- **Conditions:** Sign-in risk > Medium and above.
- **Access controls:** Block access.

📸 *Insert screenshot: Sign-in risk policy.*

---

## 📊 Monitoring & Reporting

- Use **Microsoft Entra Sign-in Logs** and **Audit Logs** to monitor the effects of your policies.
- Set up **alerts** via Microsoft Defender or Microsoft Sentinel to track policy violations or risk detections.

📸 *Insert screenshot: Sign-in logs or alert dashboard.*

---

## ✅ Summary

| Policy | Purpose | Status |
|--------|---------|--------|
| MFA for all users | Stronger authentication | ✅ Enabled |
| Block legacy authentication | Prevent insecure access | ✅ Enabled |
| Conditional Access: MFA | Enforce MFA in real-world | ✅ Enabled |
| Device compliance access | Secure endpoints only | ✅ Enabled |
| Block risky sign-ins | Stop known threats | ✅ Enabled |

---

**Next Step →** Phase04 - Endpoint Security & Device Compliance

