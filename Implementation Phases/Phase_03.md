# **Phase 3: Helpdesk & Network Troubleshooting**

## 🧰 Prerequisites

* Administrative rights on the local workstation
* PowerShell 5.1+ installed
* RDP and/or TeamViewer installed and properly configured
* Internet access for TeamViewer functionality

---

## 📌 **Overview**

* Set up support tools (RSAT, PowerShell, Remote Assistance, Event Viewer)
* Manage tickets and escalate technical issues
* Network diagnostics: IPConfig, ping, tracert, Netstat, Wireshark (introductory)
* Provide secure and tracked user support

---

## 🔴 **Reset Passwords & Unlock Accounts**

### 🎯 Objective

Assist users who are locked out or need password resets using Active Directory Users and Computers (ADUC).

1. Open **Active Directory Users and Computers**
2. Locate the target user
3. Right-click > **Reset Password**

![Reset-passwd](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/Screenshots/Phase%202/reset-password.png)

4. Enter the new password
5. Check **Unlock account** if applicable
6. Click **OK**

---

## 🖥️ Remote Desktop Access Configuration – Enterprise-Style (RDP)

This section simulates a professional Remote Desktop setup where IT support personnel can securely access user workstations using domain-based group permissions.

### ⚠️ **Ensure Remote Desktop is enabled on ITClient01:**

**Settings > System > Remote Desktop > Enable Remote Desktop**

![Enable-RDP](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/Screenshots/Phase%20%203/RDP_enable.png)

* Verify that the firewall allows RDP (TCP 3389)
* Membership in `Remote Desktop Users` does not grant **admin privileges**, only remote session rights.

---

### ✅ Part 1 – Active Directory Preparation (Domain Controller)

#### 🎯 Objective:

Create a dedicated group for IT support staff and assign relevant users. This group will later be granted remote access rights on workstations.

#### 🛠️ Steps:

1. **Create a new security group** in Active Directory:

   * Name: `IT-Support-RDP`
   * Scope: Global
   * Type: Security

2. **Add members to the group**:

   * Example user: `ali.choukatli`

![RDP\_group](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/Screenshots/Phase%20%203/RDP_groupe.png)

✅ The group `IT-Support-RDP` contains the IT staff (ali.choukatli) who will be granted RDP access across selected domain-joined machines.

---

### ✅ Part 2 – Client Machine Configuration (ITClient01)

#### 🎯 Objective:

Grant the `IT-Support-RDP` domain group the ability to initiate Remote Desktop connections to the local machine `ITClient01`.

#### 🛠️ Method A – Graphical (Computer Management):

1. Log in to **ITClient01** with local or domain administrator rights.
2. Open **Computer Management**:

   * Press `Windows + R` → type `compmgmt.msc` → press **Enter**
3. Navigate to:

   * `System Tools > Local Users and Groups > Groups`
4. Double-click on **Remote Desktop Users**
5. Click **Add...**
6. In the object name field, enter:
   `corp.aclab.tech\IT-Support-RDP`
7. Click **Check Names** → then **OK**

![RDP\_member](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/Screenshots/Phase%20%203/RDP_member.png)

#### 🛠️ Method B – PowerShell (Alternative):

Open an elevated PowerShell session on **ITClient01** and run:

```powershell
Add-LocalGroupMember -Group "Remote Desktop Users" -Member "corp.aclab.tech\IT-Support-RDP"
```

---

### ✅ Step 3 – Enable and Test Remote Desktop Access

📍 This step demonstrates secure RDP configuration from the support machine `SRV-DC01` to the client `CL-WIN11-01`.

#### 🛡️ Enable Remote Desktop on CL-WIN11-01

1. Log in locally or via Hyper-V to `CL-WIN11-01`.
2. Go to:

   * `System Properties > Remote` tab
3. Check **“Allow remote connections to this computer”**
4. *(Optional)* Uncheck **“Allow connections only from computers running Remote Desktop with Network Level Authentication”** for compatibility.
5. Apply and confirm settings.

🖼️ Screenshot: Remote Desktop settings with RDP enabled.

#### 👥 Assign RDP Permissions via Group

1. Open **Computer Management** on `CL-WIN11-01`
2. Navigate to: `System Tools > Local Users and Groups > Groups`
3. Double-click **Remote Desktop Users**
4. Click **Add…**
5. Enter: `corp.aclab.tech\IT-Support-RDP`
6. Validate and confirm

🖼️ Screenshot: "Remote Desktop Users" group showing `corp.aclab.tech\IT-Support-RDP` added.

✅ This simulates domain group-based access control as done in real enterprise via GPO.

---

### 🖥️ Step 4 – Test RDP from SRV-DC01

#### 🔹 Launch Remote Desktop Connection:

1. On `SRV-DC01`, open **Remote Desktop Connection** (`mstsc.exe`)
2. In **Computer**, enter:
   `CL-WIN11-01.corp.aclab.tech`
3. Click **Show Options**
4. Under **Username**, enter:
   `corp.aclab.tech\ali.choukatli`

🖼️ Screenshot: Remote Desktop Connection window before login (with hostname and username filled in).

#### 🔹 Authenticate and Access

1. Click **Connect**
2. Enter the password when prompted
3. The session opens with full desktop access

🖼️ Screenshot: Active RDP session on Windows 11 showing the user's desktop.

✅ This demonstrates a working remote access workflow through Active Directory and proper permissions.

---

## 🔗 TeamViewer – Remote Support Alternative

### Steps

1. Install and launch TeamViewer on both `CL-WIN11-01` and the technician device (e.g., `ITClient01`)
2. On `ITClient01`, retrieve the **Partner ID** and **Password**
3. On `CL-WIN11-01`, enter the Partner ID and click **Connect**
4. Input the password when prompted to initiate the session

🖼️ Screenshot: TeamViewer session or Partner ID dialog

### ⚠️ Important Notes

* Requires internet access on both systems
* Ensure firewall and antivirus do not block TeamViewer
* Use Conditional Access and firewall rules to restrict RDP in production

---

## 🔴 Troubleshoot Network Connectivity

### 🧪 Test 1: Ping Command

1. Open **Command Prompt (CMD)**
2. Run:

```bash
ping 192.168.2.1
```

3. Analyze latency and packet response

🖼️ Screenshot: Ping test showing successful replies or failures

### 🧪 Test 2: IP Configuration

1. In CMD, run:

```bash
ipconfig /all
```

2. Review:

   * IPv4 Address
   * Subnet Mask
   * Default Gateway
   * DNS Servers

🖼️ Screenshot: `ipconfig /all` output

---

## 🔴 Check Network Adapter via Device Manager

🎯 Objective: Ensure the NIC is correctly recognized and functioning.

1. Right-click Start > **Device Manager**
2. Expand **Network Adapters**
3. Look for:

   * Yellow exclamation marks
   * Missing drivers or disabled devices
4. Right-click > **Update driver** if necessary

🖼️ Screenshot: Device Manager with NIC status

---

## 🔴 Deploy Office 365 via PowerShell

🎯 Objective: Automate Microsoft 365 installation from the support station.

1. Open PowerShell as Administrator
2. Run:

```powershell
.\DeployOffice365.ps1
```

The script will initiate a silent installation.

🖼️ Screenshot: PowerShell showing script execution

### ⚠️ Notes

* Ensure the script path is correct
* Signed scripts may be required depending on execution policy
* Installation duration may vary by bandwidth

---

## 🧠 Pro Tips

* Use `tracert 8.8.8.8` for detailed network path analysis
* Validate firewall/AV exclusions for RDP and TeamViewer
* Document steps clearly when escalating issues
* Use automation scripts for repetitive tasks

---

## 🧠 Professional Summary

This phase simulated real-world Tier 1–2 support workflows:

* **Remote Support:** Enabled secure RDP and TeamViewer sessions
* **Active Directory Tasks:** Resolved lockouts and password issues
* **Network Troubleshooting:** Verified local and remote connectivity
* **Software Deployment:** Installed Office 365 using PowerShell automation
* **Security Best Practices:** Implemented group-based access without full admin rights

✅ These are essential skills for aspiring IT Support and Helpdesk professionals in modern enterprise environments.
