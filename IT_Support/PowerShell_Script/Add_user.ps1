New-ADUser `
 -Name "John Doe" `
 -GivenName "John" `
 -Surname "Doe" `
 -SamAccountName "jdoe" `
 -UserPrincipalName "jdoe@yourdomain.com" `
 -Path "OU=Users,DC=yourdomain,DC=com" `
 -AccountPassword (ConvertTo-SecureString "TemporaryP@ssw0rd!" -AsPlainText -Force) `
 -Enabled $true `
 -ChangePasswordAtLogon $true

------ 

-Name : Full display name.

-GivenName : First name.

-Surname : Last name.

-SamAccountName : Username for authentication (logon name).

-UserPrincipalName : Email format username (useful for Azure and cloud compatibility).

-Path : The Organizational Unit (OU) where you create the user.

-AccountPassword : Initial password (provided in plain text for the script).

-Enabled : Immediately enables the account.

-ChangePasswordAtLogon : Forces the user to change their password at first logon.
