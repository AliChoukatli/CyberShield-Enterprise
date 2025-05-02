# Liste of 10 users to ad to AD

$users = @(
    @{ FirstName = "John"; LastName = "Doe" },
    @{ FirstName = "Alice"; LastName = "Smith" },
    @{ FirstName = "Bob"; LastName = "Johnson" },
    @{ FirstName = "Emma"; LastName = "Williams" },
    @{ FirstName = "Michael"; LastName = "Brown" },
    @{ FirstName = "Sarah"; LastName = "Jones" },
    @{ FirstName = "David"; LastName = "Miller" },
    @{ FirstName = "Olivia"; LastName = "Davis" },
    @{ FirstName = "James"; LastName = "Garcia" },
    @{ FirstName = "Sophia"; LastName = "Martinez" }
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
