## 🔴 Step 1 – Windows 11 Client Machines

**🎯 Objective**: Install and prepare Windows 11 machines for later domain joining.

### Instructions

1. Download the official [Windows 11 ISO](https://www.microsoft.com/en-us/software-download/windows11).
2. Create a new VM and boot from the ISO.
3. Select **Install now** on the setup screen.
4. Choose **Custom** installation ➔ Create a new partition ➔ Click **Next**.

   ![Create Partition](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/Screenshots/Day1_Installation_AD/Create_Partition.png)

5. Wait for Windows installation to complete.
6. Choose your region and keyboard layout.
7. Select **Join Domain Instead** (do not sign in with a Microsoft account).

   ![Join Domain](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/Screenshots/Day1_Installation_AD/join-domain-instead.png)

8. Create a local user account:
   - Username
   - Strong password
9. For privacy settings, choose **Required only** ➔ Accept.
10. The system will finalize setup ("Preparing your PC" screen).

    ![Preparing PC](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/Screenshots/Day1_Installation_AD/preparing%20pc.png)

11. Once at the desktop, rename the machine:
    - **Settings ➔ System ➔ About ➔ Rename this PC** (e.g., `LTP-HLP01`).

12. Restart the VM to apply the new hostname.

    ![Rename Confirmation](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/Screenshots/Day1_Installation_AD/rename_confirmation.png)

---

### 📌 Notes:
- Create **2–3** Windows 11 VMs.

---

## 🔴 Step 2 - Domain Join – Windows 11 Workstation

**Objective:** Integrate the Windows 11 workstation into the `corp.aclab.tech` domain to enable centralized management via Active Directory.

### 🛠️ Steps:

1. Make sure your dns prerferd is 192.168.2.10 ( Dc ip)

1. On the Windows 11 machine (`LTP-HLP01`), go to:  
   `Settings` → `System` → `About` → Click **"Domain or workgroup"** → **Change settings**

2. In the **Computer Name/Domain Changes** window:  
   - Click **Change**  
   - Select **Domain**  
   - Enter: `corp.aclab.tech`

3. Enter credentials of a domain account with permission to join (e.g., `Administrator`)

![Domain_Join](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/Screenshots/Day1_Installation_AD/join%20domain.png)

4. Once joined, you'll see a welcome message.
5. Restart the workstation.
6.  On the Windows 11 machine (`LTP-HLP01`), go to:  
   `Settings` → `System` → `About`

![domain-verification](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/Screenshots/Day1_Installation_AD/domain-verification.png)

---

### ✅ Result:

- The machine appears under **Active Directory Users and Computers (ADUC)** in the **"Computers"** container.
- You can now log in using domain credentials (e.g., `corp\it.ali.choukatli`)
Capture  ADUC view showing the joined computer 

> 💡 *This step is required before deploying GPOs, endpoint protection, or centralized user policies.*

