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
## 📌 Notes
- This section reflects tasks typically performed by an IAM analyst in a banking environment when onboarding applications into an IAM or IGA process.

- Access rights are aligned with business roles, ensuring security and compliance.

- Service accounts are managed with strict security settings and stored in dedicated OUs.

➡️ This lab simulates RBAC, group nesting, and technical account hygiene, which are essential practices for both operational IAM and future IGA integration (e.g., SailPoint).

---

## 📥 Onboarding and Offboarding Processes

This section simulates a typical user lifecycle in an enterprise environment: from account creation (onboarding) to deactivation and cleanup (offboarding). It reflects operational IAM tasks carried out by analysts in financial institutions.

---

### 👤 Onboarding a New Employee

### 🎯 Goal
Provision a new employee with the required access and apply security policies via GPO.

### 🪜 Steps

- [ ] Create user account: `clark.chou`
  - Name: Clark Chou
  - Username: `clark.chou`
  - Email: `clark.chou@lab.local`
  - Initial password set and "User must change password at next logon"
  - OU: `OU=IT,OU=Employees,DC=lab,DC=local`
  - ➡️ *Business Context*: Clark joins the IT department and requires specific application access.

- [ ] Add user to relevant **security groups**:
  - `IT-Users`
  - `APP_Swift_Read`
  - ➡️ *RBAC Justification*: `IT-Users` provides baseline access, while `APP_Swift_Read` grants read-only access to the Swift application.

- [ ] Map a personal **network drive**:
  - Drive letter: `U:\`
  - Path: `\\SRV-FILES\Users\clark.chou`
  - Permissions: Full access for `clark.chou` only
  - ➡️ *Best Practice*: Every user has a private storage space for documents.

- [ ] Apply a **Group Policy Object (GPO)**:
  - Restrict access to Control Panel
  - Enforce password complexity and minimum length
  - Redirect Documents folder to network drive
  - ➡️ *Security Controls*: Enforce enterprise standards and reduce misconfiguration risks.

---

### ❌ Offboarding a Departing Employee

### 🎯 Goal
Securely disable a user leaving the company and clean up related access.

### 🪜 Steps

- [ ] Disable user account: `john.doe`
  - ➡️ *Security Measure*: Immediate lockout upon HR notification.

- [ ] Remove from all security groups
  - Use PowerShell or manual ADUC removal
  - ➡️ *Least Privilege*: Prevent dormant access.

- [ ] Move account to `OU=DisabledUsers`
  - For archiving and retention
  - ➡️ *Audit Compliance*: Preserve records for 90 days (policy-based).

- [ ] Delete local profile from workstations
  - ➡️ *Hygiene*: Free up disk space and remove cached credentials.

- [ ] Archive user documents
  - Export content from `\\SRV-FILES\Users\john.doe` to secure backup
  - ➡️ *Retention*: Data may be needed for legal/audit purposes.

---

## 🧰 PowerShell Snippets

```powershell
# Disable and move user
Disable-ADAccount -Identity "john.doe"
Move-ADObject -Identity "CN=john.doe,OU=IT,OU=Employees,DC=lab,DC=local" `
  -TargetPath "OU=DisabledUsers,DC=lab,DC=local"

# Remove all group memberships
Get-ADUser "john.doe" -Properties MemberOf | ForEach-Object {
  $_.MemberOf | ForEach-Object {
    Remove-ADGroupMember -Identity $_ -Members "john.doe" -Confirm:$false
  }
}

