# 💼 Identity Lifecycle in Active Directory (Onboarding & Offboarding)

This chapter simulates real-world IAM analyst responsibilities in a banking context using Active Directory. It focuses on identity lifecycle management, access provisioning, service account creation, and audit readiness.

---

## 🧱 Prerequisites

- ✅ Windows Server 2022 installed
- ✅ Active Directory Domain Services (AD DS) configured
- ✅ Users and Security Groups created (see Chapter 2)
- ✅ Operational lab environment

---

## 🔐 1. Advanced Account and Access Management

### 🎯 Goal
Simulate technical account creation, nested security group strategy, and resource-based access control.

### 🪜 Steps

- [ ] Create a **service account** `svc_sailpoint`
  - OU: `OU=ServiceAccounts,DC=lab,DC=local`
  - Options: Password never expires, cannot change password
  - ➡️ *Justification*: Used by SailPoint (or any IGA tool) to connect to AD for provisioning/deprovisioning.

- [ ] Create the following **security groups**:
  - `APP_Swift_Read`
  - `APP_Swift_Admin`
  - `APP_Swift_Global` (nested group containing the two above)
  - ➡️ *Justification*: Implements role-based access control (RBAC) for the Swift application.

- [ ] Add test user `testuser1` to the groups:
  - `APP_Swift_Read` → read-only access
  - `APP_Swift_Admin` → full access
  - ➡️ *Note*: Use group nesting to simplify future administration.

- [ ] Create a **shared folder** `\\SRV-FILES\SwiftDocs`
  - Apply NTFS & Share permissions:
    - `APP_Swift_Read` → Read
    - `APP_Swift_Admin` → Full Control
  - ➡️ *Security Principle*: Least Privilege Access

- [ ] Test access with `testuser1`:
  - Verify role-based access via group membership
  - Document results in `Access_Test_Results.md`

---

## 🧰 Bonus: PowerShell Snippets

```powershell
# Create service account
New-ADUser -Name "svc_sailpoint" -SamAccountName "svc_sailpoint" `
-AccountPassword (ConvertTo-SecureString "StrongPassword123!" -AsPlainText -Force) `
-Enabled $true -PasswordNeverExpires $true -Path "OU=ServiceAccounts,DC=lab,DC=local"

# Create groups
New-ADGroup -Name "APP_Swift_Read" -GroupScope Global -GroupCategory Security -Path "OU=Groups,DC=lab,DC=local"
New-ADGroup -Name "APP_Swift_Admin" -GroupScope Global -GroupCategory Security -Path "OU=Groups,DC=lab,DC=local"
New-ADGroup -Name "APP_Swift_Global" -GroupScope Global -GroupCategory Security -Path "OU=Groups,DC=lab,DC=local"

# Add nesting
Add-ADGroupMember -Identity "APP_Swift_Global" -Members "APP_Swift_Read","APP_Swift_Admin"

# Add test user to a group
Add-ADGroupMember -Identity "APP_Swift_Read" -Members "testuser1"
```
