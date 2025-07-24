# 💼  Identity Lifecycle in Active Directory (Onboarding & Offboarding)

This chapter simulates real IAM analyst tasks in a banking environment.

## 🧱 Prerequisites
- ✅ Windows Server 2022 installed
- ✅ Active Directory (AD DS) configured
- ✅ Users and Security Groups already created (see Chapter 2)
- ✅ Lab environment is operational

---

## 🔐 1. Advanced Account and Access Management

### 🎯 Goal:
Create service accounts, nested security groups, and test resource access rights.

#### 🔧 Steps:
- [ ] Create a service account `svc_sailpoint` (password never expires, stored in a dedicated OU)
- [ ] Create the following groups:
  - `APP_Swift_Read`
  - `APP_Swift_Admin`
  - `APP_Swift_Global` (parent group including the two above)
- [ ] Add a test user (`testuser1`) to those groups
- [ ] Create a shared folder `\\SRV-FILES\SwiftDocs` and apply permissions based on the groups
- [ ] Verify access based on roles (read-only vs full control)

---

## 📥 2. Onboarding and Offboarding Processes

### 🎯 Goal:
Simulate the full user lifecycle: joining and leaving the company with access management.

#### Onboarding:
- [ ] Create a new user account `clark.chou`
- [ ] Add to groups: `IT-Users`, `APP_Swift_Read`
- [ ] Map a personal network drive `U:\` with access only for that user
- [ ] Apply a basic GPO (e.g., restrict Control Panel, enforce password complexity)

#### Offboarding:
- [ ] Disable `john.doe` account
- [ ] Remove from all groups
- [ ] Delete local profile
- [ ] Archive user documents (local backup or export)

---

## 📊 3. Access Requests and Ticket Management

### 🎯 Goal:
Simulate an ITSM ticket for an application access request.

#### Scenario:
> "A user requests read-only access to the Swift Alliance application"

- [ ] Create a mock ITSM ticket (description, user, timestamp)
- [ ] Add the user to the `APP_Swift_Read` group
- [ ] Log the request (type, action, date, group added)
- [ ] Track the action in a file like `IAM_Access_Log.md` or a `.csv`

---

## 📁 4. Audit and Compliance

### 🎯 Goal:
Export access rights for internal audit and reporting purposes.

- [ ] List group members using PowerShell:
```powershell
Get-ADGroupMember -Identity "APP_Swift_Admin" | Select Name, SamAccountName
```
- [ ] Export to .csv:
```powershell
Get-ADGroupMember -Identity "APP_Swift_Admin" | 
Select Name, SamAccountName |
Export-Csv -Path "C:\Audit\Swift_Admin_Members.csv" -NoTypeInformation
```
