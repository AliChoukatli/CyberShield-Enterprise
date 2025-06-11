New-NetIPAddress -InterfaceAlias "Ethernet" -IPAddress 192.168.2.10 -PrefixLength 24 -DefaultGateway 192.168.2.1
Set-DnsClientServerAddress -InterfaceAlias "Ethernet" -ServerAddresses ("127.0.0.1","8.8.8.8")
