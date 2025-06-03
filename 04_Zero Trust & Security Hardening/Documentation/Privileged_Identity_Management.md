
# 🔐 Azure AD Privileged Identity Management (PIM) – Configuration & Best Practices

## 📋 Overview

Privileged Identity Management (PIM) in Azure AD provides just-in-time (JIT) privileged access, conditional activation, approval workflows, and detailed auditing for high-privilege roles. This approach supports Zero Trust principles by minimizing the attack surface and preventing persistent elevated access.

This documentation outlines how to implement PAM using Azure AD PIM in a cloud-only environment.

---

## 🎯 Objective

> Enforce strict control and auditing over privileged role assignments in Azure AD by enabling just-in-time access and requiring justification, MFA, and approval where necessary.

---

## 🧱 Prerequisites

- Azure AD Premium P2 license
- Global Administrator or Privileged Role Administrator privileges to configure PIM

---

## 🛠️ Step-by-Step Configuration

### 1. Enable PIM
1. Sign in to the [Azure Portal](https://portal.azure.com/)
2. Go to **Azure Active Directory** > **Privileged Identity Management**
3. Select **Azure AD roles**
4. Click **Consent to PIM** to enable it if prompted

---

### 2. Assign Roles via PIM

> Always assign roles as "eligible" rather than "active".

1. In **PIM > Azure AD roles**, click **Roles**
2. Choose a critical role (e.g., **Global Administrator**, **Security Administrator**, **Intune Administrator**)
3. Select **Add assignments**
4. Choose a user and set assignment type to **Eligible**
5. Define start/end dates if needed

---

### 3. Configure Activation Settings

1. Go to **PIM > Azure AD roles > Settings**
2. Choose the role to configure (e.g., Global Administrator)
3. Set:
   - **Activation duration**: 1 or 4 hours
   - **Require MFA**: ✅ Yes
   - **Require justification**: ✅ Yes
   - **Require approval**: Optional (recommended for sensitive roles)
   - **Require ticket number**: Optional for enterprise environments

---

### 4. Set Notifications and Alerts

Navigate to **PIM > Alerts** and enable:

- Unused role assignments
- Too many permanent role assignments
- Activation without MFA
- Activation outside approved hours

Optionally, route these alerts to Microsoft Sentinel or a dedicated mailbox.

---

## 🔍 Monitoring & Auditing

Access logs via:

- **PIM > Audit History**
- **Azure AD > Sign-in logs**
- **Azure AD > Roles > Assignments history**
- Integration with **Log Analytics** or **Microsoft Sentinel** for custom dashboards

---

## 🧠 Best Practices

| Practice                                     | Recommendation                   |
|---------------------------------------------|-----------------------------------|
| Permanent Global Admin assignments          | ❌ Avoid – use PIM JIT instead     |
| MFA for all privileged activations          | ✅ Mandatory                      |
| Role assignment type                        | ✅ Eligible (not Active)          |
| Justification for every activation          | ✅ Yes                            |
| Approval before elevation                   | ✅ For high-risk roles            |
| Review role usage regularly                 | ✅ Audit quarterly                |
| Separate admin workstations (PAW)           | ✅ Recommended                    |

---

## 💡 Advanced Ideas (Optional)

- Use **Workbooks in Log Analytics** to visualize PIM activations over time.
- Configure **custom alerts** in Sentinel for elevated access.
- Use **PowerShell or Microsoft Graph API** to:
  - List all active role assignments
  - Detect permanent role usage
  - Automate assignment reviews

---

## 📸 Screenshots (Recommended)

Include in your GitHub:
- Role assignment panel in PIM
- JIT role activation with justification and MFA
- Audit log of role activation
- Alert configuration panel

---

## 🧾 Comparison: Azure AD PIM vs On-Prem PAM

| Feature                           | Azure AD PIM (Cloud)     | On-Prem PAM (MIM, GPO)         |
|----------------------------------|---------------------------|---------------------------------|
| Just-in-Time Access              | ✅ Built-in               | ✅ With complex setup           |
| MFA Enforcement for elevation    | ✅ Native                 | ❌ Manual integration required |
| Approval workflow                | ✅ Built-in               | ❌ Not supported                |
| Auditing and alerting            | ✅ Centralized            | 🟡 Event Viewer only           |
| Role expiration                  | ✅ Automatic              | ❌ Manual                      |
| Ease of deployment               | ✅ Easy                   | ❌ Complex and manual          |

---

## ✅ Conclusion

Azure AD PIM provides a robust, cloud-native way to implement Privileged Access Management in modern environments. By enforcing just-in-time access, MFA, and audit trails, PIM strengthens security posture and supports Zero Trust architecture.

For any privileged role: **If it’s always active, it’s always a risk. Use PIM.**

