## ✅ 3.4 Troubleshoot Network Connectivity

  ## 📌 Test 1 – Ping

#### 🎯 *Objective : Verify basic network connectivity by pinging the default gateway and the domain controller (DC).*

All commands below are executed from the employee workstation: **LTP-EMP01**.

---

#### ▶️ Test A – Ping the Default Gateway
- Purpose: Ensure the device can reach the router (gateway) and confirm LAN connectivity is functional.
- **Command:**
```bash
ping 192.168.2.1
```
![Ping-Router](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/Screenshots/Phase%20%203/Ping-Router.png)
  
#### ▶️ Test B – Ping the Domain Controller (DC)
- Purpose: Confirm that LTP-EMP01 can reach the Active Directory server (DC) over the network.
- **Command:**
```bash
ping 192.168.2.10
```
![Ping-DC](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/Screenshots/Phase%20%203/Ping-DC.png)


#### 🧠 Notes:
If the ping fails:

- ✅ Ensure the domain controller is powered on and properly connected to the network.
- 🔥 Check if ICMP traffic is allowed through Windows Firewall on the target machine.
- 🧩 Confirm that both the source (LTP-EMP01) and target (DC) machines are on the same subnet.
- 🛠️ Use the following command on the domain controller to verify its IP address:
  ```bash
  ipconfig
--- 
## 📌 Test 2 – IP Configuration

```bash
ipconfig /all
```
![ipconfig](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/Screenshots/Phase%20%203/ipconfig.png)

---

## ✅ 3.5 **Inspect Network Adapter Status**  

#### 🎯 Objective: *Verify if the network adapter is functioning properly.*

- **Why is this important?**  
  This step helps diagnose any network connectivity issues related to the hardware. If the NIC (Network Interface Controller) is having issues, it could cause network disruptions, affecting access to network resources, including domain services.

- **Procedure:**
  1. Open **Device Manager**.
  2. Expand the **Network Adapters** section.
  3. Check for warning icons or missing devices.  
     *(If no warning icons are present, it means no issues have been detected.)*
  4. If needed, right-click the network adapter and select **Update Driver** to check for driver updates.

 ![update-driver](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/Screenshots/Phase%20%203/update-driver.png)

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

