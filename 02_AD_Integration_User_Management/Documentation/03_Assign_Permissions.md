## 📝 Introduction

This section focuses on assigning proper **NTFS and Share permissions** to a departmental shared folder (`C:\SharedFolders\IT`) to ensure secure and role-based access. By leveraging **Active Directory security groups**, we enforce a permission model that aligns with organizational roles and responsibilities.

Correctly configuring both **Share** and **NTFS permissions** is essential to avoid unauthorized access and to maintain data integrity in a multi-user environment.

---

# 🔴 Assign Permissions

## 🎯 Objective  
Configure **NTFS** and **share permissions** on the `IT` folder to ensure fine-grained security and access separation based on **Active Directory security groups**.

## 📁 Context  
The shared folder `C:\SharedFolders\IT` hosts sensitive and collaborative data for the **IT department**. Access must be role-based with the following permissions:

- **IT-Admins**: Full control (read, write, modify, delete)  
- **IT-Users**: Read-only access (read & execute)

---

## 🛠️ Configuration Steps

### 1. Configure Share Permissions

- Right-click on the `IT` folder → **Properties** → **Sharing** tab  
- Click **Advanced Sharing**  
- Check **Share this folder**  
- Share name: `IT`  
- Click **Permissions**  
- Configure the following:

| Group       | Share Permissions |
|-------------|-------------------|
| IT-Admins   | Full Control       |
| IT-Users    | Read              |

- Remove the **Everyone** group to tighten security  
- Apply the settings

---

### 2. Configure NTFS Permissions

- In the same folder properties, go to the **Security** tab → Click **Edit**  
- Add the AD groups `IT-Admins` and `IT-Users` if not already present  
- Set the following NTFS permissions:

| Group       | NTFS Permissions         |
|-------------|--------------------------|
| IT-Admins   | Full Control             |
| IT-Users    | Read & Execute           |

- Remove the **Everyone** group if present  
- Apply and confirm changes

---

## 🔐 Explanation

- **Share permissions** control access over the network  
- **NTFS permissions** control both local and network access with more granularity  
- **The most restrictive rule applies**: if a user has conflicting Share and NTFS permissions, the most restrictive one takes effect  
- That’s why it’s essential to configure **both layers correctly**

---

## ✅ Verification

- From a client machine, access the network path: `\\DC01\IT`  
- Test access with an **IT-Users** account (should have read-only access)  
- Test access with an **IT-Admins** account (should have full access)  
- Verify that a user **not in either group** has no access

---

## 🧠 Best Practices

- Remove **Everyone** from all permissions to limit uncontrolled access  
- Always assign permissions to **AD security groups**, not individual users  
- Document all applied permissions in a central permissions inventory  
- Perform **regular audits** of permissions on all shared folders

---

# ✅ End of NTFS and Share Permission Configuration for the IT Folder
---

## ✅ Conclusion

After completing this configuration:

- The `IT` shared folder is accessible over the network via `\\DC01\IT`.
- Members of the `IT-Admins` group have **full control** over the folder, including the ability to modify, delete, and manage files.
- Members of the `IT-Users` group have **read-only access**, ensuring they can consume information without making changes.
- The **Everyone** group has been removed from both share and NTFS permissions to tighten access control.
- A clear separation of access rights has been implemented using **Active Directory security groups**, enabling easier management and scalability.

This structured permission model enhances both **security** and **administrative efficiency**, while adhering to best practices for shared folder access management in a corporate Active Directory environment.
Souhaites-tu que je rédige la suite logique pour la création des lecteurs réseaux via GPO, ou une autre
---

# Fin de la configuration des permissions NTFS et partage pour le dossier IT.
