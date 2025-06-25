# 📁🌐 File Share & NTFS Permissions Configuration

## 📝 Introduction

This section focuses on assigning proper **NTFS and Share permissions** to a departmental shared folder (`C:\SharedFolders\IT`) to ensure secure and role-based access. By leveraging **Active Directory security groups**, we enforce a permission model that aligns with organizational roles and responsibilities.

### 🎯 Objective  
Create and securely share a central folder on the domain controller for the IT department, configuring both **NTFS** and **share permissions** based on Active Directory security groups.

### 🛠️ Steps

1. On the **Windows Server 2022 (Domain Controller)**, create the folder:
C:\SharedFolders\IT


2. Right-click the `IT` folder → **Properties** → **Sharing** tab  
- Click **Advanced Sharing**  
- Check **Share this folder**  
- Set the share name to `IT`  
- Click **Permissions** and configure:

| Group       | Share Permission |
|-------------|------------------|
| IT-Admins   | Full Control     |
| IT-Users    | Read             |

![Sharing](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/Screenshots/Phase%202/Sharing.png)

3. Switch to the **Security** tab → Click **Edit**  
- Add `IT-Admins` and `IT-Users` groups if not already present  
- Assign the following NTFS permissions:

| Group       | NTFS Permission    |
|-------------|--------------------|
| IT-Admins   | Full Control       |
| IT-Users    | Read & Execute     |

![NTFS-admins](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/Screenshots/Phase%202/NTFS-admin.png)

4. Remove the **Everyone** group from both Share and NTFS permissions for enhanced security.

5. Click **Apply** and **OK** to save changes.

---

### ✅ Verification

From a **Windows 11 client machine** joined to the domain:

- Open File Explorer and enter the path:  
- Test access using different user accounts:
  - A user in `IT-Admins`: should have full control (read/write/delete)
  - A user in `IT-Users`: should have read-only access
  - A user **not** in either group: should be denied access

---

### 🔐 Notes & Best Practices

- **Share permissions** govern network access, while **NTFS permissions** control both local and network file system access with finer granularity. The most restrictive permission between the two applies.
- Always assign permissions to **Active Directory security groups**, never directly to users.
- Regularly audit folder permissions and document all applied settings.
- Removing the **Everyone** group reduces exposure to unauthorized access.

---

## ✅ Conclusion

After completing this configuration:

- The `IT` shared folder is accessible over the network via `\\DC01\IT`.
- Members of the `IT-Admins` group have **full control** over the folder, including the ability to modify, delete, and manage files.
- Members of the `IT-Users` group have **read-only access**, ensuring they can consume information without making changes.
- The **Everyone** group has been removed from both share and NTFS permissions to tighten access control.
- A clear separation of access rights has been implemented using **Active Directory security groups**, enabling easier management and scalability.





