# ✅ Security & Compliance Policies

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

