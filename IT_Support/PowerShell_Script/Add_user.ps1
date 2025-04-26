# Définir the information of the user FirstName.LastName
$firstName = "John"
$lastName = "Doe"
$samAccountName = "$firstName.$lastName"
$userPrincipalName = "$samAccountName@corp.aclab.tech"

# Créer l'utilisateur Active Directory
New-ADUser `
    -Name "$firstName.$lastName" `
    -GivenName $firstName `
    -Surname $lastName `
    -SamAccountName $samAccountName `
    -UserPrincipalName $userPrincipalName `
    -Path "OU=CyberShield_Users,DC=corp,DC=aclab,DC=tech" `
    -AccountPassword (ConvertTo-SecureString "TempPassw0rd123!" -AsPlainText -Force) `
    -Enabled $true `
    -PasswordNeverExpires $false `
    -ChangePasswordAtLogon $true
