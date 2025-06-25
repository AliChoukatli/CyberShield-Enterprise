## 📝 Introduction

This section focuses on assigning proper **NTFS and Share permissions** to a departmental shared folder (`C:\SharedFolders\IT`) to ensure secure and role-based access. By leveraging **Active Directory security groups**, we enforce a permission model that aligns with organizational roles and responsibilities.

Correctly configuring both **Share** and **NTFS permissions** is essential to avoid unauthorized access and to maintain data integrity in a multi-user environment.

---

# Assign Permissions

# 🎯 Objectif  
Configurer les permissions NTFS et les droits de partage sur le dossier IT pour assurer une sécurité fine et une séparation des accès selon les groupes Active Directory.

---

## 📁 Contexte  
Le dossier partagé `C:\SharedFolders\IT` héberge des fichiers sensibles et collaboratifs pour le département IT. Il doit être accessible selon les rôles avec des permissions adaptées :

- **IT-Admins** : Contrôle total (lecture, écriture, modification, suppression)  
- **IT-Users** : Accès en lecture seule (lecture & exécution)

---

## 🛠️ Étapes de configuration

### 1. Configuration des permissions en partage (Share Permissions)

- Clic droit sur le dossier `IT` → **Propriétés** → onglet **Partage**  
- Cliquer sur **Partage avancé**  
- Cocher **Partager ce dossier**  
- Nom du partage : `IT`  
- Cliquer sur **Permissions**  
- Configurer comme suit :

| Groupe      | Permissions   |
|-------------|---------------|
| IT-Admins   | Contrôle total |
| IT-Users    | Lecture       |

- Retirer le groupe **Everyone** pour renforcer la sécurité  
- Valider les paramètres

---

### 2. Configuration des permissions NTFS

- Toujours dans les propriétés du dossier, onglet **Sécurité** → cliquer sur **Modifier**  
- Ajouter les groupes AD `IT-Admins` et `IT-Users` si non présents  
- Assigner les permissions suivantes :

| Groupe      | Permissions NTFS             |
|-------------|-----------------------------|
| IT-Admins   | Contrôle total              |
| IT-Users    | Lecture et exécution        |

- Retirer le groupe **Everyone** si présent  
- Appliquer et valider

---

## 🔐 Explications

- **Permissions en partage** contrôlent l’accès au dossier via le réseau.  
- **Permissions NTFS** contrôlent les accès locaux et réseau avec un contrôle plus fin.  
- **La règle la plus restrictive s’applique** : si un utilisateur a des permissions différentes en partage et NTFS, c’est la permission la plus limitée qui prévaut.  
- Il est donc essentiel de configurer correctement les deux couches.

---

## ✅ Vérification

- Depuis un poste client, accéder au chemin réseau : `\\DC01\IT`  
- Tester la connexion avec un utilisateur IT-Users (accès lecture uniquement)  
- Tester la connexion avec un utilisateur IT-Admins (accès total)  
- Vérifier qu’un utilisateur non membre des groupes n’a aucun accès

---

## 🧠 Bonnes pratiques

- Supprimer les groupes **Everyone** des permissions pour limiter l’accès non contrôlé  
- Utiliser des groupes de sécurité AD pour gérer les permissions, ne jamais assigner directement à des utilisateurs  
- Documenter toutes les permissions appliquées dans un référentiel central  
- Faire des audits réguliers des permissions sur les dossiers partagés  

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
