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

**📸 Screenshots to capture:**

* OU creation window
* Final view showing all top-level OUs under the domain

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
7. Repeat this process to add:

   * **4 users in `IT` OU**
   * **2 users in `HR` OU**
   * **2 users in `Management` OU**
   * **2 users in `Sales` OU**

**📸 Screenshot to capture:**

* Example: User creation window (for 1 user in IT)
* Final view of users inside only **one** OU (e.g., `IT`) — sufficient to demonstrate the structure

### ⚙️ **PowerShell Automation (Optional):**

* [Add 10 Users Script](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/IT_Support/PowerShell_Script/Add_10_users.ps1)
* [Add Single User Script](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/IT_Support/PowerShell_Script/Add_user.ps1)

---

## 🌟 Step 2: **Delete a User in Active Directory**

### 🎯 **Objective**

Safely remove a user account from Active Directory.

### 🔧 **Steps:**

1. Open **ADUC**
2. Navigate to the appropriate OU
3. Right-click the user > **Delete** > Confirm

**📸 Screenshot:**

* Delete user prompt

### 🧑‍💻 **Pro Tip:**

Disable the account before deleting to avoid accidental data loss.

**📸 Screenshot:**

* Disable account dialog

---

## 🌟 Step 3: **Delete an Organizational Unit (OU)**

### 🔧 **Steps:**

1. In ADUC, go to **View** > enable **Advanced Features**
2. Right-click OU > **Properties** > **Object tab**
3. Uncheck **Protect object from accidental deletion** > OK
4. Right-click OU > **Delete**

**📸 Screenshots:**

* Advanced Features enabled
* OU properties (Object tab)

---

## 👥 Step 4: **Creating and Managing Security Groups**

### 🔧 **4.1 – Create Security Groups**

1. Dans la console **Active Directory Users and Computers**, va dans l’OU `Groups`.
2. Clic droit > **New > Group**.
3. Donne un nom comme `IT-Admins` ou `IT-Users`.
4. Type : **Security**, Scope : **Global**.
5. Clique **OK** pour créer le groupe.
6. Ensuite, fais clic droit sur le groupe > **Properties** > **Members** > **Add...**
7. Ajoute les utilisateurs des différentes OUs (ex: les 5 users de l’OU IT pour `IT-Users`).

**📸 Captures d’écran à prendre :**

* Fenêtre de création d’un groupe
* Propriétés du groupe montrant ses membres

### 🔐 **4.2 – Assign NTFS Permissions to Groups**

1. Sur le serveur, crée un dossier partagé (ex: `C:\SharedFolders\IT`).
2. Clic droit sur ce dossier > **Properties** > onglet **Security**.
3. Clique sur **Edit** > **Add** > entre le nom du groupe (ex: `IT-Admins`).
4. Sélectionne les permissions à attribuer (ex: **Read**, **Modify**, ou **Full control**).
5. Clique **OK** pour valider.

**📸 Captures d’écran à prendre :**

* Onglet Security avec le groupe ajouté
* Boîte de dialogue de sélection des permissions NTFS

💡 **Note** : On sépare bien :

* 🔧 **La création des groupes AD**
* 🔐 **L’usage de ces groupes pour contrôler l’accès aux dossiers**

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
* 11 users spread across IT, HR, Sales, and Management
* All security groups stored under a central `Groups` OU
* Helpdesk operations simulated (reset, delete, disable)
* Folder permissions via NTFS assigned to groups
* Basic troubleshooting and PowerShell skills demonstrated

---

➡️ Ready for **Phase 3: Helpdesk & Network Troubleshooting**? Let’s go! 🚀
