## ✅ – TeamViewer Remote Assistance

#### 🎯 Objective : *Set up TeamViewer on both machines (support and end-user), ensure secure configuration, and simulate a remote support session from the helpdesk workstation.*

#### 🧰 **Prerequisites**

- TeamViewer installed on both **LTP-HLP01** (Helpdesk) and **LTP-EMP01** (Employee)
- Internet connectivity
- TeamViewer account
- TeamViewer QuickSupport or Full Client on the employee machine

---

#### Download & Install TeamViewer

🔹 **On both LTP-HLP01 and LTP-EMP01:**

1. Open a browser and navigate to:  
   [https://www.teamviewer.com/en/download](https://www.teamviewer.com/en/download)

2. **On LTP-HLP01:**  
   Download the **TeamViewer Full Client** (for providing support).
   
![TV-Download](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/Screenshots/Phase%20%203/Teamviewer_Download.png)

3. **On LTP-EMP01:**  
   Download the **TeamViewer QuickSupport** (for receiving support).


4. Run the installer and select:
   - Default installation
   - Personal / Non-commercial use (or custom for simulation)
   
5. Click **Accept** – finish and wait for the installation to complete.

6. Launch TeamViewer on both machines.

---

#### Simulate Remote Support from LTP-HLP01

1. On **LTP-EMP01**, ensure TeamViewer is open and note:
   - Your ID
   - Password

![TV-Download](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/Screenshots/Phase%20%203/EMP-ID.png)

3. On **LTP-HLP01**, under the **Control Remote Computer** section:
   - Sign-in
   - Go To **Remote Support** on the left side
   - Enter the **Partner ID** from **LTP-EMP01**
   - Click **Connect**
     
![Partner-ID](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/Screenshots/Phase%20%203/Partner-ID.png)

   - When prompted, enter the **Password** from **LTP-EMP01**.

You should now have remote access to the user's desktop.

![Session-TV](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/Screenshots/Phase%20%203/session-TV.png)


#### 🔴**End Support Session Securely**

1. When support is complete, click the **X** in the TeamViewer window to end the session.

2. On **LTP-EMP01**, advise the user to:
   - Close TeamViewer if not needed
   - Change their temporary password (optional)
   - Revoke access if using permanent ID or unattended access.

#### 🔐 Security Tips
🔹 Ensure proper security measures are followed to protect the session and user credentials.
