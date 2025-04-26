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
