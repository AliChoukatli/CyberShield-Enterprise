# Azure AD & Intune Integration

This step enables you to:

✅ Hybrid join your on-premises devices to **Azure AD**  
✅ Manage Windows devices using **Microsoft Intune**  
✅ Apply security and compliance policies

---

## 🧰 Prerequisites

Before you begin, make sure you have:

- A **Microsoft 365** account with a license that includes **Intune** (e.g., **Business Premium**)
- A **local Active Directory domain** set up (e.g., `acpracticelab.local`)
- Your Microsoft account connected to **Azure AD** (e.g., `acpracticelab.onmicrosoft.com`)
- **Azure AD Connect** installed and configured (for Hybrid Join scenarios)

---

## 🔧 Main Steps

### 1. Connect On-Prem AD to Azure AD (Hybrid Join)

❗ If you're doing a **Hybrid Azure AD Join**, you need to install Azure AD Connect.

- Download [Azure AD Connect](https://www.microsoft.com/en-us/download/details.aspx?id=47594)
- Install it on your domain controller (or dedicated sync server)
- Choose **Express** or **Custom** setup (custom allows filtering)
- Select **Password Hash Synchronization**
- Ensure users and devices from your local domain are syncing to Azure AD

📸 **Screenshots to capture:**

- Azure AD Connect main interface after setup  
- Azure AD portal showing a synced user (`Source: Synced from on-premises`)

---

### 2. Enable Intune for Device Management

- Go to [Microsoft Endpoint Manager Admin Center](https://endpoint.microsoft.com)
- Navigate to **Devices > Enroll Devices > Automatic Enrollment**
- Set both **MDM User scope** and **MAM User scope** to **All**

📸 **Screenshot to capture:**

- Intune automatic enrollment configuration page

---

### 3. Create Security Groups in Microsoft 365/Azure AD

- Go to Microsoft 365 or Azure AD > **Groups**
- Create a group like `IT-SMB-Users` to manage user access

📸 **Screenshot to capture:**

- Group list with `IT-SMB-Users` visible

---

### 4. Join a Windows Device to Azure AD or Hybrid Join

On the client machine (VM or physical):

- Go to **Settings > Accounts > Access work or school > Connect**
- Enter your Microsoft 365 account (e.g., `alichoukatli@acpracticelab.onmicrosoft.com`)
- Complete the sign-in process

Then verify:

- Go to **Devices > All Devices** in Intune – confirm the device appears
- In **Azure AD**, verify the device shows as **Hybrid Azure AD Joined** or **Azure AD Joined**

📸 **Screenshots to capture:**

- Windows sign-in screen (during M365 account connection)  
- Device visible in Intune  
- Azure AD > Device info (`Join Type` confirmation)

