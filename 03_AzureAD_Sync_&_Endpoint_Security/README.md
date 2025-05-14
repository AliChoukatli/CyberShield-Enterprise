# Phase 3 – Azure AD Sync & Endpoint Security

## 🎯 Objective

This phase enables you to:

1. Hybrid join your on-premises devices to Azure AD  
2. Manage Windows devices using Microsoft Intune  
3. Apply security and compliance policies  

---

## ✅ Prerequisites

Before getting started, ensure the following:

- A Microsoft 365 account with a license including Intune (e.g., Business Premium)
- On-premises Active Directory domain (e.g., `corp.aclab.tech`)
- Azure AD tenant linked to your domain (e.g., `corp.aclab.tech.onmicrosoft.com`)
- Azure AD Connect installed and configured
- BitLocker configured on all endpoints
  - Deployed via Intune or Group Policy
  - Recovery keys backed up to Azure AD or on-prem AD
- Windows Defender Antivirus and Firewall enabled by default
- Security features configured: Windows Hello, SmartScreen, Exploit Protection
- Devices enrolled in Intune (MDM)
- Device compliance policies created and enforced

---

# 🔗 Step 1 – Hybrid Azure AD Join of On-Premises Devices

## 🧭 Goal

Enable domain-joined Windows devices to be automatically registered in Azure AD as **Hybrid Azure AD joined**, allowing for modern device management (Intune, Conditional Access, Defender, etc.).

### 1.1 – Verify On-Prem Domain Join

Run the following on client machines:

```powershell
whoami /fqdn
systeminfo | findstr /i "domain"
```

📸 Screenshots:
whoami help01 (photo)
whoamiemp01 (photo)


### 1.2 – Download and Install Azure AD Connect
Download Azure AD Connect

Launch the installer and proceed through the wizard

### 1.3 – Azure AD Connect Configuration (Custom)
Open Azure AD Connect > Click "Configure"

Choose "Customize"

Select Password Hash Synchronization
✅ Recommended for simplicity and security



Sign in with your Azure AD Global Admin credentials
(e.g., admin@corp.aclab.tech)



Create a sync account (corp.aclab.tech\syncadmin)

Temporarily add to Domain Admins and Administrators

Remove privileges after setup

Optionally place in a restricted group (e.g., Azure-AD-Connect)

Link your directories

Select "Use Existing Account" to connect to your on-premises AD forest.

Enter the sync account credentials.



7. Once directory validation is complete, click Next.

8.Enable Password Writeback and Group Writeback.
- Recommended to enable these features for hybrid identity management.

📁 Recommended OU Structure:

```sql
corp.aclab.tech/
└── AzureAD-Groups/
```
Groupewriteback phoot



9. Enable Single Sign-On (SSO) for seamless login experience.

💡 Only Domain Admin privileges are required for configuring SSO delegation.

10. Start the installation and synchronization process
After reviewing the settings, click Install to begin synchronization.
Once complete, run the following PowerShell command to force a delta sync:
```powershell
Start-ADSyncSyncCycle -PolicyType Delta
```
Screenshot of sync success:


### 1.4 – Configure Hybrid Azure AD Join (Windows + Azure AD Connect)
Launch Azure AD Connect and select Configure Device Options.

Choose Configure Hybrid Azure AD Join.

📸 Screenshot of Hybrid Join configuration:


Add your domain (e.g., corp.aclab.tech) and sign in with a Global Administrator account.

Apply the configuration to enable automatic device registration in Azure AD.

### 1.5 – Configure Group Policy for Automatic Hybrid Join
Open Group Policy Management Console (gpmc.msc).

Create a new GPO linked to the Devices Organizational Unit (OU).

Redirect devices to a new OU if necessary.

Configure the following settings:

Network Access:
Set to Enabled for allowing domain-joined devices to register with Azure AD.

Device Registration:
Enable automatic registration of domain-joined devices with Azure AD.

Apply the GPO and force an update on client devices:
```bash
gpupdate /force
```
Validate the device registration with the following command:
```bash
dsregcmd /status
```


# Step 2 – Device Management Using Microsoft Intune
🎯 Objective
Manage Windows devices through Microsoft Intune for security and compliance.

Actions
Log in to Microsoft Intune via the Azure Portal.

Ensure all devices are enrolled for management (MDM).

Apply security policies (e.g., password requirements, screen lock, etc.).

Monitor compliance policies and manage device health.

# Step 3 – Apply Security and Compliance Policies
🎯 Objective
Enforce security policies and ensure device compliance.

Actions
Create and assign security policies (e.g., password, encryption settings).

Apply compliance policies to enforce required standards, such as antivirus, firewall, and disk encryption.

# Step 4 – Deploy BitLocker on Endpoints
🎯 Objective
Encrypt all devices using BitLocker for data protection.

Actions
Deploy BitLocker via Intune or Group Policy.

Ensure recovery keys are backed up to Azure AD or Active Directory.

# Step 5 – Enable Windows Defender Antivirus and Firewall
🎯 Objective
Ensure Windows Defender Antivirus and Firewall are enabled by default on all devices.

Actions
Configure Windows Defender Antivirus and Firewall settings through Intune or Group Policy.

# Step 6 – Configure Windows Hello, SmartScreen, and Exploit Protection
🎯 Objective
Enhance security by enabling Windows Hello, SmartScreen, and Exploit Protection.

Actions
Configure Windows Hello, SmartScreen, and Exploit Protection within Intune for added device security.

# Step 7 – Enroll Devices in Intune (MDM)
🎯 Objective
Ensure all devices are enrolled in Intune for ongoing management.

Actions
Enroll devices via MDM (Mobile Device Management) to ensure consistent management and monitoring.

# Step 8 – Verify Device Compliance
🎯 Objective
Verify that all devices are compliant with the defined security standards.

Actions
Create and monitor Device Compliance Policies in Intune.

Verify compliance for devices across all security criteria, including password complexity, encryption, and antivirus settings.

























