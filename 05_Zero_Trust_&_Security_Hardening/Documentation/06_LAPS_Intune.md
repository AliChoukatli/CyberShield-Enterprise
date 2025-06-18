# Local Administrator Password Management (LAPS) with Intune

## Overview

Local Administrator Password Management (LAPS) in Intune allows you to automatically manage and rotate local administrator passwords on Windows devices enrolled in Microsoft Endpoint Manager (Intune). Each device gets a unique, complex local admin password that is rotated periodically and securely stored in Azure AD.

This improves security by reducing the risk of lateral movement through shared or static local admin passwords.

## 📘 Table of Contents

- Unique local administrator password per device
- Automatic password rotation (configurable interval)
- Secure storage of passwords in Azure Active Directory
- Retrieval of passwords via Intune or PowerShell
- Integration possibilities with Microsoft Sentinel for alerting (not native in Intune)

1- Créer la politique LAPS dans Intune
(celle que tu as bien décrite : Local admin password solution, configurer tous les paramètres, assigner aux groupes de devices)

2- Automatiser la création du compte local LAPS_Admin

Écrire un script PowerShell qui crée le compte LAPS_Admin (si absent) et l’ajoute au groupe Administrateurs.

Déployer ce script via Intune (Devices > Scripts > Add > PowerShell).

3- Déploiement sur les machines cibles

Les machines reçoivent la politique LAPS et le script PowerShell.

Le compte LAPS_Admin est créé automatiquement.

Le mot de passe de ce compte est géré et tourné automatiquement par LAPS.

4- Surveillance & gestion

Surveiller les accès à la récupération du mot de passe (via Azure AD roles).

Vérifier le bon déploiement dans Intune (monitoring).

## Prerequisites

- Devices enrolled and managed by Intune (Windows 10/11)
- Appropriate Intune licenses and permissions
- Devices must be Azure AD joined or Hybrid Azure AD joined

---

## How to Enable LAPS via Intune (2025)

1. Sign in to the [Microsoft Endpoint Manager admin center](https://endpoint.microsoft.com).

2. Navigate to **Endpoint security** > **Account protection**.

3. Click **+ Create Policy**.

4. Configure the policy:
   - **Platform**: Windows 10 and later
   - **Profile**: Local admin password solution (Windows LAPS)

| Setting                                          | Description                                                                                             
|--------------------------------------------------|----------------------------------------------------------------------------------------------------------
| **Backup Directory**                             | Entra ID                                                                                                 |
| **Password Age Days**                            | 30                                                                                                        |
| **Administrator Account Name**                   | Leave Empty                                                                                              | 
| **Password Complexity**                          | LowerCase + Uppercase + Numbers + Special characters                                                     | 
| **Password Length**                              | 16                                                                                                       | 
| **Post Authentication Actions**                  | Reset password and log off the managed account.                                                          | 
| **Post Authentication Reset Delay**              | 24                                                                                                       |
| **Automatic Account Management Enabled**         | The target account will be automatically managed                                                         | 
| **Automatic Account Management Enable Account**  | The target account will be enabled                                                                       | 
| **Automatic Account Management Randomize Name**  | the name of the target account will not use a random numeric suffix                                      | 
| Automatic Account Management Target              | Built-in local Administrator                                                                             | 
| **Name or Prefix of Managed Account**            | `Laps_Admin`                                                                           | 
| **Automatic Account Management Target**          | Manage a new account custom administarator account                                                       | 
| **Automatic Account Management Name Or Prefix**  |  Laps_Admin                                                                                              | 

5. Assign the policy to the device groups you want to manage.

6. Save and deploy.

![LAPS_Policy](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/05_Zero_Trust_%26_Security_Hardening/Screenshots/LAPS_Policy.png)


### Notes

- This policy automatically manages the local administrator password on Azure AD joined or Hybrid Azure AD joined devices.
- The password is rotated automatically based on the configured interval.
- Monitor password retrieval permissions via Azure AD roles to maintain security.


---

## 🔐 Automating Local Administrator Account Creation for LAPS via Intune

## Overview

To properly manage local administrator passwords using LAPS (Local Administrator Password Solution) via Intune, the target local administrator account (e.g., `LAPS_Admin`) must exist on the client devices. 

## Steps to Automate LAPS_Admin Account Creation and Deployment

### 1. Create PowerShell Script to Add Local Administrator Account

The following PowerShell script checks if the local user `LAPS_Admin` exists. If not, it creates the account, sets it to enabled, and adds it to the local Administrators group.

```powershell
$AccountName = "LAPS_Admin"

# Générer un mot de passe aléatoire simple (exemple ici en PS 5.1)
Add-Type -AssemblyName System.Web
$plainPassword = [System.Web.Security.Membership]::GeneratePassword(16,3)
$Password = ConvertTo-SecureString $plainPassword -AsPlainText -Force

$user = Get-LocalUser -Name $AccountName -ErrorAction SilentlyContinue

if (-not $user) {
New-LocalUser -Name $AccountName -Password $Password -FullName "LAPS Managed Admin Account" -Description "Account managed by LAPS via Intune" -PasswordNeverExpires:$true -AccountNeverExpires:$true
    Add-LocalGroupMember -Group "Administrators" -Member $AccountName

    Write-Output "User '$AccountName' created and added to Administrators group."
    Write-Output "Generated password: $plainPassword"
} else {
    Write-Output "User '$AccountName' already exists."
}
```
> Note: The password set here is temporary. LAPS will rotate and manage the password automatically after deployment.

## 2. Deploy the PowerShell Script via Intune

1. Sign in to the Microsoft Endpoint Manager admin center.

2. Navigate to **Devices** > **Scripts**.

3. Click **+ Add** > **Windows 10 and later**.

4. Upload the PowerShell script created in step 1.

5. Configure script settings as needed:  
   - Run this script using the logged on credentials: **No**  
   - Enforce script signature check: **No**

6. Assign the script to the same device groups targeted by your LAPS policy.

7. Save and deploy.


## 3. Apply the LAPS Policy in Intune

- Create and assign the **Local admin password solution (Windows LAPS)** policy as per your organizational standards.

- Ensure the policy is assigned to the same groups where the script is deployed.


## 4. Deployment and Operation on Client Devices

- Upon receiving the PowerShell script, client devices will create the `LAPS_Admin` local administrator account (if not already present).

- The LAPS policy will manage and rotate the password of this account automatically according to your configured schedule.

- The password is securely backed up to Azure AD or your specified backup directory.


## 5. Monitoring and Security

- Use Azure AD role-based access control (RBAC) to restrict and monitor who can retrieve the managed passwords.

- Regularly audit access logs for any unauthorized attempts.

- Monitor device compliance and script execution status via Intune reporting.
