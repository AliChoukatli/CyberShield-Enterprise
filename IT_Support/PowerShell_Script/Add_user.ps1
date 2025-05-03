# DEfine the user info
$firstName = "Ali"
$lastName = "Chou"
$samAccountName = "$firstName.$lastName"
$userPrincipalName = "$samAccountName@corp.aclab.tech"

# Create User AD
New-ADUser `
    -Name "$firstName.$lastName" `
    -GivenName $firstName `
    -Surname $lastName `
    -SamAccountName $samAccountName `
    -UserPrincipalName $userPrincipalName `
    -Path "OU=IT,DC=corp,DC=aclab,DC=tech" `
    -AccountPassword (ConvertTo-SecureString "TempPassw0rd123!" -AsPlainText -Force) `
    -Enabled $true `
    -PasswordNeverExpires $false `
    -ChangePasswordAtLogon $true
