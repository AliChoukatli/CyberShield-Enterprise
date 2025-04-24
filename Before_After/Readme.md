✅ Exemple complet pour MFA (Multifactor Authentication)
1. Admin View – Conditional Access Policy
📸 after_mfa_admin_policy.png

Va dans : Entra ID > Security > Conditional Access

Capture une policy :

Name : Require MFA for all users

Assignments : All users, All cloud apps

Grant : Require multifactor authentication

Bonus pro : Ajoute un petit encadré rouge autour des sections importantes.

2. User View – MFA Prompt
📸 after_mfa_user_prompt.png

Capture de l’écran de connexion d’un utilisateur :

Juste après l’entrée du mot de passe

L’écran de validation via Microsoft Authenticator ou SMS code

Tu peux utiliser une VM utilisateur pour simuler ça.

🔐 Exemple pour BitLocker
1. Admin View – Intune Policy
📸 after_bitlocker_intune_policy.png

Va dans Endpoint Security > Disk Encryption

Montre :

Target : All Windows 10/11 devices

Configuration : BitLocker enabled, recovery key saved to Azure AD

2. Device View – BitLocker Status
📸 after_bitlocker_device_status.png

Sur la machine cliente (Win11), lance Manage BitLocker

Capture : “BitLocker is on” sur disque C:
