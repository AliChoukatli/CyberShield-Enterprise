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

