# Liste of 10 users to ad to AD

$users = @(
    @{ FirstName = "Ali"; LastName = "Chou" },
    @{ FirstName = "John"; LastName = "Doe" },
    @{ FirstName = "Sarah"; LastName = "Jones" },
    @{ FirstName = "David"; LastName = "Miller" }
 
)

# Loop to create the users

foreach ($user in $users) {
    # Define user properties
    
    $firstName = $user.FirstName
    $lastName = $user.LastName
    $samAccountName = "$firstName$lastName"
    $userPrincipalName = "$samAccountName@corp.aclab.tech"

    # Create the AD User
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
}
