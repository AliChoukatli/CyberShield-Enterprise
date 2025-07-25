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
  - OU: `OU=ServiceAccounts,DC=corp,DC=aclab,DC=tech`  
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
# Define OUs
$OU_ServiceAccounts = "OU=Service Accounts,DC=corp,DC=aclab,DC=tech"
$OU_Groups = "OU=Groups,DC=corp,DC=aclab,DC=tech"
$OU_IT = "OU=IT,OU=Employees,DC=corp,DC=aclab,DC=tech"

# 1. Create the service account if it doesn't exist
if (-not (Get-ADUser -Filter {SamAccountName -eq "svc_sailpoint"})) {
    New-ADUser -Name "svc_sailpoint" -SamAccountName "svc_sailpoint" `
     -AccountPassword (ConvertTo-SecureString "StrongPasswd123$" -AsPlainText -Force) `
     -Enabled $true -PasswordNeverExpires $true -Path $OU_ServiceAccounts
    Write-Host "Service account 'svc_sailpoint' created."
} else {
    Write-Host "ℹService account 'svc_sailpoint' already exists."
}

# 2. Create the application groups if they don't exist
$groups = @("APP_Swift_Read", "APP_Swift_Admin", "APP_Swift_Global")

foreach ($group in $groups) {
    if (-not (Get-ADGroup -Filter {Name -eq $group})) {
        New-ADGroup -Name $group -GroupScope Global -GroupCategory Security -Path $OU_Groups
        Write-Host "Group $group created."
    } else {
        Write-Host "Group $group already exists."
    }
}

# 3. Nest Read/Admin groups into the Global group
Add-ADGroupMember -Identity "APP_Swift_Global" -Members "APP_Swift_Read", "APP_Swift_Admin"

# 4. Create a test user in the IT department if it doesn't exist
if (-not (Get-ADUser -Filter {SamAccountName -eq "testuser1"})) {
    New-ADUser -Name "testuser1" -SamAccountName "testuser1" `
     -AccountPassword (ConvertTo-SecureString "StrongPasswd123$" -AsPlainText -Force) `
     -Enabled $true -Path $OU_IT
    Write-Host "User 'testuser1' created in IT."
} else {
    Write-Host "User 'testuser1' already exists."
}

# 5. Add testuser1 to the Read group
Add-ADGroupMember -Identity "APP_Swift_Read" -Members "testuser1"
Write-Host "User 'testuser1' added to 'APP_Swift_Read'."


```
### 🔎 Explanation

| **Component**         | **Purpose**                                                             |
|-----------------------|-------------------------------------------------------------------------|
| `svc_sailpoint`       | A service account used by IGA tools like SailPoint                     |
| `APP_Swift_Read`      | Read-only access group for the SWIFT application                       |
| `APP_Swift_Admin`     | Admin-level access for SWIFT                                            |
| `APP_Swift_Global`    | Group that includes both Read & Admin (for high-level audit/policy)    |
| `testuser1`           | Simulated end-user added to the read group                             |


## 📌 Notes
- [ ] This section reflects tasks typically performed by an IAM analyst in a banking environment when onboarding applications into an IAM or IGA process.
- [ ] Access rights are aligned with business roles, ensuring security and compliance.
- [ ] Service accounts are managed with strict security settings and stored in dedicated OUs.

➡️ This lab simulates RBAC, group nesting, and technical account hygiene, which are essential practices for both operational IAM and future IGA integration (e.g., SailPoint).
