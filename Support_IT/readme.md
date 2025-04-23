# 🛠️ Support IT – Active Directory & Remote Helpdesk

Ce module simule le rôle d’un technicien IT chargé de la gestion des utilisateurs, du support à distance et des opérations courantes via PowerShell. Il s’intègre dans le contexte d'une petite entreprise de 25 employés, avec une approche orientée sécurité et efficacité.

---

## 📌 Objectifs

- Créer et gérer des utilisateurs via Active Directory
- Réinitialiser des mots de passe en cas de besoin
- Gérer les groupes et permissions
- Offrir une assistance à distance avec RDP et TeamViewer
- Diagnostiquer les problèmes de connectivité et système
- Automatiser certaines tâches via scripts PowerShell

---

## 📂 Contenu du dossier

| Dossier/Fichier                  | Description |
|----------------------------------|-------------|
| `PowerShell_Scripts/`            | Scripts automatisés (Office, Reset Password, Check Sécurité) |
| `01_AD_User_Creation.png`        | Création d’un utilisateur via AD |
| `02_Group_Management.png`        | Ajout d’utilisateur à un groupe |
| `03_Password_Reset_AD.png`       | Réinitialisation de mot de passe |
| `04_AD_Permissions_Management.png` | Gestion des permissions sur dossiers |
| `05_Remote_Support_TeamViewer.png` | Support distant avec TeamViewer |
| `06_Remote_Desktop_Session.png`  | Connexion RDP à une machine cliente |
| `07_Device_Manager_Troubleshooting.png` | Diagnostic via Device Manager |
| `08_Windows_Network_Troubleshooter.png` | Outil de dépannage Windows |
| `09_CMD_Ping_Test.png`           | Test de connectivité avec `ping` |
| `10_CMD_Ipconfig_Results.png`    | Vérification réseau avec `ipconfig` |

---

## ⚙️ Scripts PowerShell disponibles

### ▶️ `DeployOffice365.ps1`

Installe Microsoft 365 via PowerShell de manière silencieuse.

```powershell
Start-Process "https://aka.ms/office-install" -Wait
