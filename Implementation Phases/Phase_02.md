# Phase 2: **Active Directory User Management & IT Support Tasks**

## 🌟 **Objectives**

On Phase 2, we focus on the essential aspects of IT support operations, including:

* Creating and managing Active Directory (AD) user accounts and groups
* Assigning permissions and auditing user access
* Providing remote support (via RDP, TeamViewer)
* Performing basic network diagnostics (ping, ipconfig)
* Automating tasks using PowerShell

---

## Step 0 — Create OUs for Each Department

Create the following Organizational Units directly under the domain `corp.aclab.tech`:

* IT
* HR
* Sales
* Management
* Groups (for all AD security groups)
* Service Accounts (for service-level accounts)

![* OU creation window](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/Screenshots/Phase%202/Create_OU.png)

Now you should see this : 

![* Final view showing all top-level OUs under the domain](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/Screenshots/Phase%202/All_OU.png)

---

## 🌟 Step 1: **Creating Users in Active Directory**

### 🔧 **Why is this important?**

User account management is critical for maintaining access control, security, and efficient IT operations within the organization.

### 🔧 **Steps:**

1. Open **Server Manager** > **Tools** > **Active Directory Users and Computers**
2. Navigate to the target **Organizational Unit (OU)** (e.g., `IT`)
3. Right-click the OU > **New** > **User**
  
![Create_user](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/Screenshots/Phase%202/Create_User.png)]
   
5. Fill in user details (Name and Logon Name)
6. Set a **temporary password** and select **Force password change at next logon**
7. Click **Finish**
8. Repeat this process to add:

   * **4 users in `IT` OU**
   * **2 users in `HR` OU**
   * **2 users in `Management` OU**
   * **2 users in `Sales` OU**
  
Now you should see exanple of IT members

![IT_Users](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/Screenshots/Phase%202/IT_users.png)




### ⚙️ **PowerShell Automation (Optional):**

* [Add IT Users Script](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/IT_Support/PowerShell_Script/Add_IT_users.ps1)
* [Add Single User Script](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/IT_Support/PowerShell_Script/Add_user.ps1)

---

## 🌟 Step 2: **Delete a User in Active Directory**

### 🎯 **Objective**

Safely remove a user account from Active Directory.

### 🔧 **Steps:**

1. Open **ADUC**
2. Navigate to the appropriate OU
3. Right-click the user > **Delete** > Confirm

![Delete-user](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/Screenshots/Phase%202/delete_user.png)


### 🧑‍💻 **Pro Tip:**

Disable the account before deleting to avoid accidental data loss.

![* Disable account dialog](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/Screenshots/Phase%202/Disable_acc.png)

---

## 🌟 Step 3: **Delete an Organizational Unit (OU)**

### 🔧 **Steps:**

1. In ADUC, go to **View** > enable **Advanced Features**

![Advanced Features](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/Screenshots/Phase%202/Adv_feature.png)
   
2. Right-click the needed OU > **Properties** > **Object tab**  
3. Uncheck **Protect object from accidental deletion** > OK
   
![Protect](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/Screenshots/Phase%202/protect.png)
   
4. Right-click OU > **Delete**

---

## 👥 Step 4: **Managing Groups and Permissions**

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


### 🔐 **Assign NTFS Permissions to Groups:**

1. Create a folder (e.g., `C:\SharedFolders\IT` or on the desktop for testing)
2. Right-click the folder > **Properties** > **Security** tab
3. Click **Edit...** > **Add...**
4. Add `IT-Admins` and `IT-Users` groups
5. Assign desired permissions:

   * IT-Admins: **Full control**
   * IT-Users: **Read** or **Modify**

**📸 Screenshot:**

* NTFS folder permission window with both groups and their permissions

📝 **Note:**
NTFS permissions apply at the file system level (locally or over network). Combine with Share permissions to define final access rights.

---

## 🔄 Step 5: **Password Resets & Account Unlock**

### 🔧 **Steps:**

1. Locate the user in ADUC
2. Right-click > **Reset Password**
3. Enter new password and check **Unlock account** if needed

**📸 Screenshot:**

* Password reset dialog

---

## 🛠️ Step 6: **Remote Support (RDP & TeamViewer)**

### 🔧 **Steps:**

* **RDP**: Open Remote Desktop > Enter target hostname/IP > Login with admin credentials
* **TeamViewer**: Launch both ends > Input Partner ID > Connect

**📸 Screenshots:**

* RDP session open
* TeamViewer connection prompt

---

## 🌐 Step 7: **Network Diagnostics**

### 🔧 **Steps:**

* CMD:

  ```cmd
  ping 8.8.8.8
  ipconfig /all
  ```
* Run `devmgmt.msc` to open Device Manager

**📸 Screenshots:**

* Ping test result
* IPConfig details
* Device Manager window

---

## 💪 Step 8: **PowerShell Automation: Reset-UserPassword.ps1**

### 🔧 **Usage:**

```powershell
.\Reset-UserPassword.ps1 -Username "jdoe" -NewPassword "P@ssw0rd!"
```

**📸 Screenshot:**

* PowerShell script execution

---

## 🧠 Pro Tips

* Use **AD Administrative Center** for bulk tasks
* Enable **Fine-Grained Password Policies** for complex environments
* Use session logs for audit and compliance

---

## 🚀 At the End of Phase 2, You Will Have:

* A clean and organized AD structure by department
* 10 users spread across IT, HR, Sales, and Management
* All security groups stored under a central `Groups` OU
* Helpdesk operations simulated (reset, delete, disable)
* Folder permissions via NTFS assigned to groups
* Basic troubleshooting and PowerShell skills demonstrated

---

➡️ Ready for **Phase 3: Helpdesk & Network Troubleshooting**? Let’s go! 🚀
