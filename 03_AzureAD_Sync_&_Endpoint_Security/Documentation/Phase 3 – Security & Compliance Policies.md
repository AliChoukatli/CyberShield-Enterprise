
# Phase03 - Security & Compliance Policies

Now that device and user management is in place, this phase focuses on implementing key **security and compliance policies** to protect organizational resources.

---

## 🔐 Multi-Factor Authentication (MFA)

**Objective:** Enforce MFA for all users to ensure secure access.

### ✅ Steps:
1. Go to **Microsoft Entra Admin Center**.
2. Navigate to **Protection** > **Authentication Methods** > **Policies**.
3. Enable **Microsoft Authenticator** and other preferred methods (e.g., SMS, FIDO2).
4. Under **Users**, include **All Users** (or create a group-based policy).
5. Save and monitor user registration status.

📸 *Insert screenshot: MFA registration policy screen.*

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

