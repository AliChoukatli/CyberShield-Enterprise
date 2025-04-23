$User = "jdoe"
Set-ADAccountPassword -Identity $User -Reset -NewPassword (ConvertTo-SecureString "Secure@2024" -AsPlainText -Force)
Enable-ADAccount -Identity $User
