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
