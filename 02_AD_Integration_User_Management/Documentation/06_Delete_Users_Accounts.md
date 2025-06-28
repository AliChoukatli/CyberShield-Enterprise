# 🗑️ 02.6 – Deleting a User Account in Active Directory

## 🎯 Objective

Safely and securely delete a user account in Active Directory while minimizing the risk of data loss or operational disruption. This process includes disabling the account first as a safety measure.

## 📝 Introduction

Proper user lifecycle management is essential for operational hygiene and security compliance. Whether an employee leaves the organization or an account is no longer needed, **removing it correctly** from Active Directory helps maintain a clean, secure directory environment.

Before deleting an account:
- Disable it temporarily to allow time for audits or rollback.
- Confirm the user no longer has assigned resources or roles.
- Ensure the account isn't linked to critical services (e.g., mailboxes, shared folders).

---

## 🔴 **Delete a User in Active Directory**

1. Open **ADUC**
2. Navigate to the appropriate OU
3. Right-click the user > **Delete** > Confirm

![Delete-user](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/Screenshots/Phase%202/delete_user.png)


### 🧑‍💻 **Pro Tip:**

Disable the account before deleting to avoid accidental data loss.

![* Disable account dialog](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/Screenshots/Phase%202/Disable_acc.png)


### ✅ Conclusion

By following this process, you ensure that user accounts are properly removed from Active Directory while minimizing the risk of unintentional consequences. Disabling the account first adds an extra layer of safety, making account management both secure and reversible if needed.
