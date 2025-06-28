# 👥 Managing Users and Security Groups in Active Directory

## 🎯 Objective

Establish a structured and secure user identity system within Active Directory by creating user accounts, assigning them to appropriate Organizational Units (OUs), and organizing them into **Security Groups**. This enables **Role-Based Access Control (RBAC)**, policy targeting, and simplified administrative management across the environment.

## 📝 Introduction

In this section, you’ll learn how to create and organize **Active Directory user accounts** representing employees across different departments, and manage their membership in **security groups**. 

This logical grouping will serve as the basis for applying permissions, Group Policy Objects (GPOs), and security baselines across IT infrastructure. You’ll also explore **PowerShell scripting** for automation to ensure efficiency and scalability in enterprise environments.

---

## 🔴 **Creating Users in Active Directory**

- Open Server Manager > Tools > Active Directory Users and Computers (ADUC)

- Navigate to an OU (e.g., IT) > Right-click > New > User
  
![Create_user](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/Screenshots/Phase%202/Create_User.png)
   
- Put the credenitals
- Choose a password 
- Once done, you can see all your users

![IT_Users](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/Screenshots/Phase%202/IT_users.png)


### ⚙️ **PowerShell Automation (Optional):**

* [Add IT Users Script](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/IT_Support/PowerShell_Script/Add_IT_users.ps1)
* [Add Single User Script](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/IT_Support/PowerShell_Script/Add_user.ps1)

 ## 🔴 **Adding Users to Domain Users Group - Verification**
 *Ensure that the user is part of the `Domain Users` group for basic domain access permissions.*

If the user is not already a member of the **Domain Users** group, follow these steps:

1. **Open Active Directory Users and Computers (ADUC)**

   Open **Server Manager > Tools > Active Directory Users and Computers**.

2. **Navigate to Users --> Domain Users Group**

3. **Check if the User is Already in the Group**

4. **Add the User to Domain Users**

   - Right-click on **Domain Users** > **Add**.
   - Select the user (e.g., **sophia.martinez**) to add to the group.
   - Click on **Add** and then **OK**.

This will add the user to the **Domain Users** group, ensuring they have the basic domain access permissions.

![domain-users](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/Screenshots/Phase%202/domain-users.png)

---


## 🔴 **Managing Groups and Permissions**

### 🔧 **Create AD Security Groups:**

1. Navigate to the `Groups` OU
2. [Right-click > **New** > **Group**
  
![New_group](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/Screenshots/Phase%202/create_group.png)

3. Create the following groups for each department:

   * `IT-Admins` (Security, Global)
   * `IT-Users` (Security, Global)
  
 ![All-Groups)](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/Screenshots/Phase%202/allgroups.png)
 
4. Right-click each group > **Properties** > **Members** > **Add** users from IT OU and for each departement

![Add-member](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/Screenshots/Phase%202/add-member.png)

5. Now you should see all IT members

![IT-member](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/Screenshots/Phase%202/IT-member.png)

---

## ✅ Conclusion

By the end of this section:

- Users have been successfully created and placed in their corresponding **Organizational Units (OUs)**.
- Each user is a member of the **Domain Users** group to ensure basic access to domain resources.
- Department-specific **security groups** such as `IT-Admins` and `IT-Users` have been created and populated with the appropriate members.
- PowerShell scripts are available for bulk or individual user provisioning, enabling efficient, repeatable user onboarding processes.

This user and group structure is essential for applying **role-based access control (RBAC)**, managing file shares, applying GPOs, and preparing for future security configurations such as conditional access and endpoint protection.
