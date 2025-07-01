# 🧩 02_AD_Integration_User_Management

## 🎯 Objective  
This chapter focuses on essential user and group management within Active Directory.  
You'll learn to:
- Create and organize Organizational Units (OUs)
- Manage user accounts and security groups
- Configure file share and NTFS permissions
- Control RDP access via Group Policy
- Safely delete user accounts

---

## 📝 Introduction  
Effective user and group management is crucial for maintaining a secure and organized Active Directory environment.  
This chapter dives into practical steps for:
- Structuring your directory
- Assigning permissions
- Implementing access control and security policies

These operations streamline administrative tasks, reinforce your security posture, and support compliance through proper user lifecycle management.

---

## 📘 Table of Contents  
- **2.1**: [Creating and Managing Organizational Units (OUs)](#21-creating-and-managing-organizational-units-ous)  
- **2.2**: [Managing Users and Security Groups in Active Directory](#22-managing-users-and-security-groups-in-active-directory)  
- **2.3**: [File Share & NTFS Permissions Configuration](#23-file-share--ntfs-permissions-configuration)  
- **2.4**: [RDP Access Control via Group Policy](#24-rdp-access-control-via-group-policy)  
- **2.5**: [Deleting a User Account in Active Directory](#25-deleting-a-user-account-in-active-directory)  

---

## 2.1: Creating and Managing Organizational Units (OUs)  
This section covers:
- Creating OUs for department-level segregation
- Delegating control over OUs securely
- Disabling accidental deletion protection before removing an OU

Includes step-by-step instructions and screenshots for:
- Using Active Directory Users and Computers (ADUC)
- PowerShell commands to automate OU creation

---

## 2.2: Managing Users and Security Groups in Active Directory  
Learn how to:
- Create, modify, and disable user accounts
- Organize users via security groups (e.g., IT-Admins, IT-Users)
- Implement group nesting and role-based access

Covers both GUI and PowerShell-based management for:
- Bulk user creation
- Group membership assignment
- Password policies and user properties

---

## 2.3: File Share & NTFS Permissions Configuration  
Understand how to:
- Create shared folders for departments or teams
- Apply NTFS permissions using the **least privilege** principle
- Differentiate between Share and NTFS permissions

Hands-on labs:
- Configuring ACLs
- Testing access with different user groups
- Auditing permissions

---

## 2.4: RDP Access Control via Group Policy  
In this section, you’ll configure GPOs to:
- Allow or restrict RDP access based on group membership
- Harden RDP security settings (e.g., NLA, audit policies)

Topics include:
- Editing Local and Domain GPOs
- Using `gpresult` and `rsop.msc` for verification
- Creating a dedicated “RDP-Allowed” security group

---

## 2.5: Deleting a User Account in Active Directory  
Best practices for offboarding:
- Disable account before deletion
- Back up user profile/data
- Remove from groups and revoke permissions

Includes:
- PowerShell scripts for disabling and removing users
- Steps to ensure minimal disruption and no data loss

---

## 🔚 Conclusion  
By completing this chapter, you now understand how to:
- Structure and manage your AD environment with clarity
- Control access to shared resources and remote connections
- Follow best practices for user lifecycle management

These skills form the foundation of secure identity and resource governance in enterprise IT environments.

