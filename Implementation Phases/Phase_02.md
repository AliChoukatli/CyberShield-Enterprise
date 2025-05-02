# Phase 2: **Active Directory User Management & IT Support Tasks**

## 🌟 **Objectives**
On Phase 2, we focus on the essential aspects of IT support operations, including:

- Creating and managing Active Directory (AD) user accounts and groups
- Assigning permissions and auditing user access
- Providing remote support (via RDP, TeamViewer)
- Performing basic network diagnostics (ping, ipconfig)
- Automating tasks using PowerShell

---

## Step 0 — Create OU for Each Department

Create the following Organizational Units directly under the domain `corp.aclab.tech`:

- IT
- HR
- Sales
- Management
- Groups
- Service Accounts

**Screenshot:**
- OU creation window
- Final view of all top-level OUs

---

## 🌟 Step 1: **Creating Users in Active Directory**

### 🔧 **Why is this important?**
User account management is critical for maintaining access control, security, and efficient IT operations within the organization.

### 🔧 **Steps:**
1. Open **Server Manager** > **Tools** > **Active Directory Users and Computers**
2. Navigate to the target **Organizational Unit (OU)** (e.g., `IT`)
3. Right-click the OU > **New** > **User**
4. Fill in user details (Name and Logon Name)
5. Set a **temporary password** and select **Force password change at next logon**
6. Click **Finish**
7. Repeat until 10 users are created

**Screenshot:**
- User creation window
- List of 10 users in OU

### ⚙️ **PowerShell Automation:**
- [Add 10 Users Script](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/IT_Support/PowerShell_Script/Add_10_users.ps1)
- [Add Single User Script](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/IT_Support/PowerShell_Script/Add_user.ps1)

---

## 🌟 Step 2: **Delete a User in Active Directory**

### 🎯 **Objective**
Safely remove a user account from Active Directory.

### 🔧 **Steps:**
1. Open **ADUC**
2. Navigate to the appropriate OU
3. Right-click the user > **Delete** > Confirm

**Screenshot:**
- Delete user prompt

### 🧑‍💻 **Pro Tip:**
Disable the account before deleting to avoid accidental data loss.

**Screenshot:**
- Disable account dialog

---

## 🌟 Step 3: **Delete an Organizational Unit (OU)**

### 🔧 **Steps:**
1. In ADUC, go to **View** > enable **Advanced Features**
2. Right-click OU > **Properties** > **Object tab**
3. Uncheck **Protect object from accidental deletion** > OK
4. Right-click OU > **Delete**

**Screenshot:**
- Advanced Features enabled
- OU properties (Object tab)

---

## 👥 Step 4: **Managing Groups and Permissions**

### 🔧 **Steps:**
1. Go to `Groups` OU > Right-click > **New** > **Group**
2. Name the group (e.g., `IT-SMB-Admins`), choose type and scope
3. Right-click group > **Properties** > **Members** > **Add**
4. Assign this group permissions on folders via NTFS

**Screenshot:**
- Group properties with members
- NTFS permissions dialog

---

## 🔄 Step 5: **Password Resets & Account Unlock**

### 🔧 **Steps:**
1. Locate the user in ADUC
2. Right-click > **Reset Password**
3. Enter new password and check **Unlock account** if needed

**Screenshot:**
- Password reset dialog

---

## 🛠️ Step 6: **Remote Support (RDP & TeamViewer)**

### 🔧 **Steps:**
- **RDP**: Open Remote Desktop > Enter target hostname/IP > Login with admin credentials
- **TeamViewer**: Launch both ends > Input Partner ID > Connect

**Screenshot:**
- RDP session open
- TeamViewer connection prompt

---

## 🌐 Step 7: **Network Diagnostics**

### 🔧 **Steps:**
- CMD:
  ```
  ping 8.8.8.8
  ipconfig /all
  ```
  💪 Step 8: PowerShell Automation: Reset-UserPassword.ps1
🔧 Usage:
powershell
```
.\Reset-UserPassword.ps1 -Username "jdoe" -NewPassword "P@ssw0rd!"
Screenshot:
```
PowerShell script execution


