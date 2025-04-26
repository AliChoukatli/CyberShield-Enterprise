# Loop to create 10 users
for ($i = 1; $i -le 10; $i++) {
    # Format user number with leading zero
    $userNumber = "{0:D2}" -f $i

    # Define user properties
    $firstName = "user" 
    $lastName = $userNumber  
    $samAccountName = "user$userNumber"
    $userPrincipalName = "user$userNumber@corp.aclab.tech"

    # Create the AD User
    New-ADUser `
        -Name "$firstName $lastName" `
        -GivenName $firstName `
        -Surname $lastName `
        -SamAccountName $samAccountName `
        -UserPrincipalName $userPrincipalName `
        -Path "OU=CyberShield_Users,DC=corp,DC=aclab,DC=tech" `
        -AccountPassword (ConvertTo-SecureString "TempPassw0rd123!" -AsPlainText -Force) `
        -Enabled $true `
        -PasswordNeverExpires $false `
        -ChangePasswordAtLogon $true
}
