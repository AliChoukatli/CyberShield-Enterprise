# Phase 2: **Active Directory User Management & IT Support Tasks**

## 🎯 **Objectives**
On Phase 2, we focus on the essential aspects of IT support operations, including:

- Creating and managing Active Directory (AD) user accounts and groups
- Assigning permissions and auditing user access
- Providing remote support (via RDP, TeamViewer)
- Performing basic network diagnostics (ping, ipconfig)
- Automating tasks using PowerShell

---

Step 0  Create OU for each departement hr sales management IT

Capture OU create 

## 🎯 1. **Creating Users in Active Directory**

### **Why is this important?**
User account management is critical for maintaining access control, security, and efficient IT operations within the organization.

### 🔧 **Steps:**
1. Open **Server Manager** > **Tools** > **Active Directory Users and Computers**
2. Navigate to the target **Organizational Unit (OU)**, for instance, `IT`
3. Right-click on the OU > **New** > **User**
   
   ![Create user Screenshot](/////)
   
5. Fill in user details, including **Name** and **Logon Name**
6. Set a **temporary password** and select the option to **Force password change at next logon**
7. Click **Finish**
8. In this project, we will add 10 users to Active Directory
   
   ![show screesnhot 10 users)

### ⚙️ **PowerShell Automation:**
To automate the process of adding users to AD, you can use the following PowerShell script:

- [PowerShell Script to Add 10 Users](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/IT_Support/PowerShell_Script/Add_10_users.ps1)
- For adding a single user, refer to this [Add_user.ps1](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/IT_Support/PowerShell_Script/Add_user.ps1)

## 🎯 2. **Delete a User in Active Directory**
🎯 **Objective**: Safely remove a user account from Active Directory.

### Instructions

1. Open **Server Manager ➔ Tools ➔ Active Directory Users and Computers**.
2. Navigate to the **OU** (Organizational Unit) where the user account is located.
3. Right-click the user you want to delete ➔ Click **Delete**.
   
   ![Delete_user](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/Screenshots/Phase%202/delete_user.png)
   
4. Confirm the deletion when prompted.
   
   📌 **Note**: Deleted user accounts are **permanently removed** unless you have a backup or Active Directory Recycle Bin enabled.


### 🧑‍💻 **Pro Tip:**
Before deleting a user, it is best practice to **first disable the account** for a period of time to prevent accidental data loss or the need for recovery.

To disable a user:
- Right-click the user ➔ **Disable Account**.

  ![Disable_user](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/Screenshots/Phase%202/disable_user.png)

---
## 🎯 3. **Delete an Organizational unit**

- Enable **Advanced Features** in Active Directory Users and Computers. Navigate to **View** > **Advanced Features**, then right-click the OU you wish to delete. 

![Advanced](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/Screenshots/Phase%202/Advanced.png)

Before deleting, ensure that the **"Protect object from accidental deletion"** option is unchecked:
1. Right-click the OU and select **Properties**.
2. Go to the **Object** tab.
3. Uncheck the box for **Protect object from accidental deletion**.
 
 ![Protect](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/Screenshots/Phase%202/Protect_OU.png)

4. Click **OK** to confirm.

Now you can safely delete the OU.


---


## 2. 👥 Managing Groups and Permissions
### Why?
Groups simplify permission management across multiple resources.

### 🔧 Steps:
1. In **Active Directory Users and Computers**, navigate to the `Groups` OU
2. Right-click > **New** > **Group**
3. Name the group (e.g., `IT-SMB-Admins`), choose scope and type
4. Add members via **Properties** > **Members** > **Add* 

5. On file servers or folders, assign NTFS permissions to this group

### 📸 Capture to Take:
- Group properties showing members (`02_Group_Management.png`)
- NTFS permissions dialog on a folder (`03_AD_Permissions_Management.png`)

---

## 3. 🔄 Password Resets & Account Unlock
### Why?
Helpdesk frequently resets passwords and unlocks accounts for users.

### 🔧 Steps:
1. In **ADUC**, locate the user account
2. Right-click > **Reset Password**
3. Enter a new password and select **Unlock account** if needed

### 📸 Capture to Take:
- Reset Password dialog with options (`04_Password_Reset_AD.png`)

---

## 4. 🛠️ Remote Support (RDP & TeamViewer)
### Why?
Quickly resolving issues without physical presence.

### 🔧 Steps:
- **RDP**:
  1. Open **Remote Desktop Connection** on your admin PC
  2. Enter the target machine’s name or IP
  3. Authenticate with admin credentials
- **TeamViewer**:
  1. Launch TeamViewer on both ends
  2. Enter the partner ID and request connection

### 📸 Capture to Take:
- RDP session window (`05_Remote_Desktop_Session.png`)
- TeamViewer connection prompt (`06_Remote_Support_TeamViewer.png`)

---

## 5. 🌐 Network Diagnostics
### Why?
Verifying connectivity and network configuration.

### 🔧 Steps:
- **Ping Test**:
  ```cmd
  ping 8.8.8.8
  ```
- **IP Configuration**:
  ```cmd
  ipconfig /all
  ```
- **Device Manager** for hardware checks: `devmgmt.msc`

### 📸 Capture to Take:
- Ping results in CMD (`07_CMD_Ping_Test.png`)
- IPConfig output (`08_CMD_Ipconfig_Results.png`)
- Device Manager open on screen (`09_Device_Manager_Troubleshooting.png`)

---

## 6. 🔧 PowerShell Automation: Reset-UserPassword.ps1
### Why?
Automate common helpdesk tasks to save time and reduce errors.

### 🧰 Usage Example:
```powershell
.\Reset-UserPassword.ps1 -Username "jdoe" -NewPassword "P@ssw0rd!"
```

### 📸 Capture to Take:
- PowerShell console showing script execution (`10_PowerShell_Reset.png`)

---

## 🧠 Pro Tips
- Use **AD Administrative Center** for a modern UI and bulk tasks
- Enable **Fine-Grained Password Policies** for different OU requirements
- Record remote sessions for audit using built-in RDP logging or third-party tools

---

✅ At the end of Day 4, you will have:
- Multiple AD users and groups created and managed
- Password reset workflows automated
- Remote support techniques demonstrated
- Basic network troubleshooting validated

  💡 Bonus Tip: How to Delete an Organizational Unit (OU)
By default, Organizational Units (OUs) are protected from accidental deletion. If you want to delete an OU, follow these steps:

🔧 Steps:
Open Active Directory Users and Computers (ADUC)

Go to View > check Advanced Features

Navigate to the OU you want to delete

Right-click on the OU > Properties

Go to the Object tab

Uncheck Protect object from accidental deletion

Click OK, then right-click the OU again and choose Delete

✅ You must enable Advanced Features to see the Object tab and modify deletion protection.



Ready for **Phase 3: Helpdesk & Network Troubleshooting**? Let’s go! 🚀


