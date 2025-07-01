# 🖥️ Remote Support with TeamViewer

## 🎯 Objective

Install, configure, and use TeamViewer to provide secure remote support from the helpdesk workstation to end-user machines, enabling troubleshooting without direct domain or VPN access.

## 📝 Introduction

This section demonstrates how to deliver remote assistance using **TeamViewer** between a helpdesk workstation (`LTP-HLP01`) and an end-user machine (`LTP-EMP01`). TeamViewer is a reliable remote support tool that allows IT staff to troubleshoot systems securely over the internet, without requiring domain connectivity or VPN access.

You’ll learn how to install the appropriate versions on both devices, establish a secure session, and follow security best practices for closing a session safely.

---

## 🧰 **Prerequisites**

- TeamViewer installed on both **LTP-HLP01** (Helpdesk) and **LTP-EMP01** (Employee)
- Internet connectivity
- TeamViewer account
- TeamViewer QuickSupport or Full Client on the employee machine

---

## 🧭 **Steps:**

### 🚀 Step 1 - Download & Install TeamViewer

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

### 🚀 Step 2 - Simulate Remote Support from LTP-HLP01

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


### 🚀 Step 3 - **End Support Session Securely**

1. When support is complete, click the **X** in the TeamViewer window to end the session.

2. On **LTP-EMP01**, advise the user to:
   - Close TeamViewer if not needed
   - Change their temporary password (optional)
   - Revoke access if using permanent ID or unattended access.

#### 🔐 Security Tips
🔹 Ensure proper security measures are followed to protect the session and user credentials.

---

## 🔚 Conclusion

After completing this section:

- TeamViewer is properly installed and configured on both support and end-user machines.
- A successful remote session was initiated from `LTP-HLP01` to `LTP-EMP01`, simulating real-world helpdesk support.
- Security recommendations were followed, including safe session termination and optional password reset.

This setup is ideal for hybrid support scenarios, external users, or environments where RDP is not viable.

