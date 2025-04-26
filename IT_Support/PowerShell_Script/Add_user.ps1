# PowerShell script to create 10 users (from user-01 to user-10) :


for ($i = 1; $i -le 10; $i++) {
    $userNumber = "{0:D2}" -f $i
    $firstName = "user-$userNumber"
    $lastName = "Test"
    $samAccountName = "user$userNumber"
    $userPrincipalName = "user$userNumber@yourdomain.com"

    New-ADUser `
        -Name "$firstName $lastName" `
        -GivenName $firstName `
        -Surname $lastName `
        -SamAccountName $samAccountName `
        -UserPrincipalName $userPrincipalName `
        -Path "OU=CyberShield_Users,DC=yourdomain,DC=com" `
        -AccountPassword (ConvertTo-SecureString "TemporaryP@ssw0rd123!" -AsPlainText -Force) `
        -Enabled $true `
        -PasswordNeverExpires $false `
        -ChangePasswordAtLogon $true
}

# Name : Full display name.

# GivenName : First name.

# Surname : Last name.

# SamAccountName : Username for authentication (logon name).

# UserPrincipalName : Email format username (useful for Azure and cloud compatibility).

# Path : The Organizational Unit (OU) where you create the user.

# AccountPassword : Initial password (provided in plain text for the script).

# Enabled : Immediately enables the account.

# ChangePasswordAtLogon : Forces the user to change their password at first logon.
