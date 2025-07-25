

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
