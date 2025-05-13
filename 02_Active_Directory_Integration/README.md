# **Phase 2 – Active Directory Integration**

## 🎯 **Objectives**

In this phase, we focus on core IT support tasks:

✅ Creating and managing Active Directory (AD) user accounts and groups

✅ Assigning permissions and auditing user access

✅ Performing essential user account operations (reset, unlock, delete)

✅ Apply baseline Group Policy Objects (GPOs) (lock screen, wallpaper, folder redirection)

✅ Enforce password policies (length, complexity, expiration)

---

## 🔴 **Create OUs for Each Department**

Create the following Organizational Units directly under the domain `corp.aclab.tech`

* IT
* HR
* Sales
* Management
* Groups (for all AD security groups)
* Service Accounts (for service-level accounts)

![OU creation-window](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/Screenshots/Phase%202/Create_OU.png)

Once done, verify the structure:

![* Final view showing all top-level OUs under the domain](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/Screenshots/Phase%202/All_OU.png)

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


## 🔴 **Delete a User in Active Directory**

1. Open **ADUC**
2. Navigate to the appropriate OU
3. Right-click the user > **Delete** > Confirm

![Delete-user](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/Screenshots/Phase%202/delete_user.png)


### 🧑‍💻 **Pro Tip:**

Disable the account before deleting to avoid accidental data loss.

![* Disable account dialog](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/Screenshots/Phase%202/Disable_acc.png)


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


---



## 📁 **Share a folder : Create & Share an IT Support Folder on Windows Server**

### 🎯 Objective
Simulate a secure file-sharing environment by configuring NTFS and share permissions on a central folder hosted on the domain controller.

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
| IT-Admins   | Full Control     |
| IT-Users    | Read             |

![Sharing](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/Screenshots/Phase%202/Sharing.png)


3. Go to the **Security** tab → Click **Edit**  
   - Add and configure NTFS permissions for the same groups:

| Group       | NTFS Permission    |
|-------------|--------------------|
| IT-Admins   | Full Control       |
| IT-Users    | Read & Execute     |

![NTFS-admins](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/Screenshots/Phase%202/NTFS-admin.png)

> ⚠️ You may remove the default `Everyone` group for better security.

4. Click **Apply** and **OK** to save both sets of permissions.

### On win11, you can access now to the IT folder
capture

--- 

## 🔴 **Configuring RDP Permissions**

### 🎯 Objective
Ensure that selected users (e.g., `Sophia Martinez`) can securely connect via RDP to a VM (LTP-EMP01) by granting permissions only to an authorized group.

### 🛠️ Steps

1. **Create the `RDP-Users` Group**:

   - Open **Active Directory Users and Computers (ADUC)**.
   - Right-click on the **Users** container > **New** > **Group**.
   - Name the group `RDP-Users`.
   - Set the group type to **Security**.
   - Click **OK**.

2. **Add Users to the `RDP-Users` Group**:

   - Right-click on the `RDP-Users` group > **Properties** > **Members** > **Add**.
   - Add users such as `Sophia Martinez`.

3. **Create and Configure a GPO for RDP Access**:

   - Open the **Group Policy Management Console**.
   - Right-click on your **Domain** > **Create a GPO in this domain, and Link it here...**.
   - Name the GPO (e.g., `RDP Access Policy`).
   - Edit the GPO:
     - Navigate to:  
       **Computer Configuration** > **Policies** > **Windows Settings** >  
       **Security Settings** > **Local Policies** > **User Rights Assignment**.
     - Open **Allow log on through Remote Desktop Services**.
     - **Remove** any unnecessary default entries (like `Domain Users`) if present.
     - **Add only** the `RDP-Users` group.
    
  ![RDP-policy](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/Screenshots/Phase%202/RDP-policy.png)

4. **Force a Group Policy Update**:

   On the target VM (**LTP-EMP01**), run:

   ```bash
   gpupdate /force
   ```

5. Test the Access:

 - Log in as Sophia Martinez from another device using RDP to LTP-EMP01.
   
 - If issues occur, check:
   - Group membership of the user.
   - GPO application (use gpresult /r).
   - The local Remote Desktop Users group if needed.
 
 --- 
 
 ## ⚠️ **Delete an Organizational Unit (OU)**

1. In ADUC, go to **View** > enable **Advanced Features**

![Advanced Features](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/Screenshots/Phase%202/Adv_feature.png)
   
2. Right-click the OU → **Properties** → **Object tab**  
3. Uncheck **Protect object from accidental deletion** > OK
   
![Protect](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/Screenshots/Phase%202/protect.png)
   
4. Right-click OU > **Delete**


---

# 🧠 Summary – Phase 2: Domain Integration & User Management

This phase demonstrates foundational enterprise IT administration through centralized identity and access management using Active Directory.

### 🔹 Active Directory Structuring

Organizational Units (OUs) were created to mirror business departments, including `IT`, `HR`, `Sales`, and `Management`. Additional OUs like `Groups` and `Service Accounts` ensured clean separation of security groups and technical identities.

- Structured OUs enable delegated administration and easier Group Policy management.
- Advanced features were enabled to protect critical objects from accidental deletion.

### 🔹 User Lifecycle Management

- **Account Provisioning:** Department-specific users were created using the GUI and optionally automated with PowerShell scripts.
- **Deprovisioning:** Proper procedures for user and OU deletion were followed, including disabling accounts and removing protection flags.
- **Account Operations:** Tasks such as password resets, account unlocks, and attribute modifications simulate real-world Helpdesk interactions.

### 🔹 Group-Based Access Control (GBAC)

Security groups were created to align with business roles:

- `IT-Admins` – Full access and administrative privileges
- `IT-Users` – Limited, read-only access

Users were added to appropriate groups to enforce least privilege.

### 🔹 Shared Folder Configuration

A shared folder `C:\SharedFolders\IT` was created on the Domain Controller and exposed via network path `\\DC01\IT`.

- **Share Permissions:**  
  `IT-Admins` granted Full Control, `IT-Users` granted Read-only access.

- **NTFS Permissions:**  
  Fine-grained control applied—`IT-Admins` (Full), `IT-Users` (Read & Execute).

*This folder simulates a secure file-sharing environment aligned with Active Directory permissions, offering insight into the interaction between share-level and file-level security.*

---

🎯 ### This phase replicates real-world IT onboarding and access delegation workflows critical in any enterprise environment.


