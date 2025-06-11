## 📦 Office 365 Deployment via ODT

#### 🎯 *Objective : Install Microsoft 365 Apps (Office 365) and Visio Pro using Office Deployment Tool (ODT) with a custom PowerShell script.*

#### Step 1 – Uninstall Existing Office Installation (if applicable)

### Recommended Method: Microsoft Support and Recovery Assistant (SaRA)
1. Run this script :
```powershell
iwr https://raw.githubusercontent.com/Admonstrator/msoffice-removal-tool/main/msoffice-removal-tool.ps1 -OutFile msoffice-removal-tool.ps1; powershell -ExecutionPolicy Bypass .\msoffice-removal-tool.ps1
```
2. Restart the machine after uninstallation.

---

#### **Step 2 – Download and Prepare the Office Deployment Tool (ODT)**

1. Download ODT from Microsoft:
   [https://www.microsoft.com/en-us/download/details.aspx?id=49117](https://www.microsoft.com/en-us/download/details.aspx?id=49117)

2. Extract the content to:  
   `C:\ODT`

3. This folder should contain:
   
        C:\ODT
        │ setup.exe
        │ config.xml
---

#### **Step 3 – Customize `config.xml`**

Create or edit `C:\ODT\config.xml` with the following content:
```xml
<?xml version="1.0" encoding="utf-8"?>
<Configuration>
    <Add OfficeClientEdition="64" Channel="Current">
        <Product ID="O365ProPlusRetail">
            <Language ID="en-us"/>
        </Product>
        <Product ID="VisioProRetail">
            <Language ID="en-us"/>
        </Product>
    </Add>
    <Updates Enabled="TRUE" Channel="Current" />
    <Display Level="None" AcceptEULA="TRUE" />
    <Property Name="AUTOACTIVATE" Value="1" />
</Configuration>
```

#### **Step 4 – Create the PowerShell Script**
- Create a new script file: C:\Scripts\DeployOffice365.ps1
```powershell
# DeployOffice365.ps1
$OfficeDeploymentPath = "C:\ODT"
$SetupFilePath = "$OfficeDeploymentPath\setup.exe"
$ConfigFilePath = "$OfficeDeploymentPath\config.xml"

# Temporarily allow script execution
Set-ExecutionPolicy RemoteSigned -Scope Process -Force

# Start the Office deployment
Start-Process -FilePath $SetupFilePath -ArgumentList "/configure $ConfigFilePath" -Wait
```

#### **Step 5 – Run the Script**
- Open PowerShell as Administrator

- Run the script:
```powershell
cd C:\Scripts
.\DeployOffice365.ps1
```
You should see Office 365 begin installing in the background.

- If setup.exe opens a blank CMD and does nothing, Office is likely already installed.
- If Office is partially or already installed, the ODT setup may silently fail.

----
