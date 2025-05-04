# **Phase 2 – Domain Integration & User Management**

## 🎯 **Objectives**

In this phase, we focus on core IT support tasks:

✅ Creating and managing Active Directory (AD) user accounts and groups

✅ Assigning permissions and auditing user access

✅ Performing essential user account operations (reset, unlock, delete)

---

## 🔴 **Step 0 - Create OUs for Each Department**

Create the following Organizational Units directly under the domain `corp.aclab.tech`:

* IT
* HR
* Sales
* Management
* Groups (for all AD security groups)
* Service Accounts (for service-level accounts)

![* OU creation window](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/Screenshots/Phase%202/Create_OU.png)

Once done, verify the structure:

![* Final view showing all top-level OUs under the domain](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/Screenshots/Phase%202/All_OU.png)

---

## 🔴 **Step 1 - Creating Users in Active Directory**

Open Server Manager > Tools > Active Directory Users and Computers (ADUC)

Navigate to an OU (e.g., IT) > Right-click > New > User
  
![Create_user](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/Screenshots/Phase%202/Create_User.png)]
   

Once done

![IT_Users](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/Screenshots/Phase%202/IT_users.png)


### ⚙️ **PowerShell Automation (Optional):**

* [Add IT Users Script](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/IT_Support/PowerShell_Script/Add_IT_users.ps1)
* [Add Single User Script](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/IT_Support/PowerShell_Script/Add_user.ps1)

---

## 🔴 **Step 2 - Delete a User in Active Directory**

1. Open **ADUC**
2. Navigate to the appropriate OU
3. Right-click the user > **Delete** > Confirm

![Delete-user](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/Screenshots/Phase%202/delete_user.png)


### 🧑‍💻 **Pro Tip:**

Disable the account before deleting to avoid accidental data loss.

![* Disable account dialog](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/Screenshots/Phase%202/Disable_acc.png)

---

## 🔴 **Step 3 - Delete an Organizational Unit (OU)**

1. In ADUC, go to **View** > enable **Advanced Features**

![Advanced Features](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/Screenshots/Phase%202/Adv_feature.png)
   
2. Right-click the OU → **Properties** → **Object tab**  
3. Uncheck **Protect object from accidental deletion** > OK
   
![Protect](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/Screenshots/Phase%202/protect.png)
   
4. Right-click OU > **Delete**

---

## 🔴 **Step 4 - Managing Groups and Permissions**

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



## 📁 Step: Create & Share an IT Support Folder on Windows Server

### 🎯 Objective
Simulate a secure file-sharing environment by configuring NTFS and share permissions on a central folder hosted on the domain controller.

---

### 🛠️ Steps

1. On the **Windows Server 2022** (Domain Controller), create the folder:

C:\SharedFolders\IT


2. Right-click on the `IT` folder → **Properties** → go to the **Sharing** tab  
   - Click **Advanced Sharing**
   - Check **"Share this folder"**
   - Set the Share Name to `IT`
   - Click **Permissions** and configure as follows:

| Group       | Share Permission |
|-------------|------------------|
| IT_Admins   | Full Control     |
| IT_Users    | Read             |

![Sharing](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/Screenshots/Phase%202/Sharing.png)


3. Go to the **Security** tab → Click **Edit**  
   - Add and configure NTFS permissions for the same groups:

| Group       | NTFS Permission    |
|-------------|--------------------|
| IT_Admins   | Full Control       |
| IT_Users    | Read & Execute     |

![NTFS-admins](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/Screenshots/Phase%202/NTFS-admin.png)

> ⚠️ You may remove the default `Everyone` group for better security.

4. Click **Apply** and **OK** to save both sets of permissions.

---

## 🧠 Professional Summary

This phase demonstrates the implementation of foundational IT support and system administration tasks in a simulated small business environment. Key technical competencies covered include:

- **Active Directory Integration:** The Windows 11 Technician workstation was successfully joined to the Active Directory domain `corp.aclab.tech`, allowing centralized identity management and policy enforcement.
- **User and Group Management:** Security groups such as `IT_Admins` and `IT_Users` were created to manage folder access through group-based permissions, following best practices for least privilege.
- **Shared Folder Configuration:** A shared folder `C:\SharedFolders\IT` was created on the Windows Server 2022 Domain Controller and shared via the network (`\\DC01\IT`). Share and NTFS permissions were precisely configured to restrict or grant access based on group membership.

These exercises provide a solid foundation in enterprise IT operations and reflect real-world scenarios often encountered by junior IT technicians and support analysts.




