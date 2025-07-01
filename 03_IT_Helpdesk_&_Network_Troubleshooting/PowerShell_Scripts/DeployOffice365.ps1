# DeployOffice365.ps1
# Description: Download and install Microsoft 365 Apps using Office Deployment Tool

$installFolder = "C:\OfficeInstall"

# Create the folder for installation files
if (!(Test-Path $installFolder)) {
    New-Item -Path $installFolder -ItemType Directory -Force | Out-Null
}

# Download the Office Deployment Tool (ODT)
$odtUrl = "https://aka.ms/O365Install"
$odtPath = "$installFolder\OfficeSetup.exe"

Write-Host "Downloading Office Deployment Tool..." -ForegroundColor Cyan
Invoke-WebRequest -Uri $odtUrl -OutFile $odtPath

# Check if config file exists
$configFile = ".\install.xml"
if (!(Test-Path $configFile)) {
    Write-Host "install.xml not found. Please create the configuration file first." -ForegroundColor Red
    exit
}

# Launch Office installation
Write-Host "Starting Microsoft 365 installation..." -ForegroundColor Green
Start-Process -FilePath $odtPath -ArgumentList "/configure `"$configFile`"" -Wait

Write-Host "Microsoft 365 installation completed." -ForegroundColor Green
