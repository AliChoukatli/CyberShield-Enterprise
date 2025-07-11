# 🖥️ RDP Access Control via Group Policy

## 🎯 Objective

Restrict RDP access on domain-joined machines (e.g., `LTP-EMP01`) to a designated security group (`RDP-Users`) using Group Policy. This ensures only authorized personnel can remotely access workstations, reducing the attack surface and enforcing security boundaries.

## 📝 Introduction

Remote Desktop Protocol (RDP) is a powerful but high-risk feature if left open to all users. Improper configuration can expose endpoints to credential brute-force attacks and lateral movement within a network.

This section walks through the process of:
- Creating a dedicated `RDP-Users` Active Directory security group.
- Assigning remote logon rights through Group Policy.
- Applying the policy to restrict access on a specific machine (`LTP-EMP01`).
- Validating enforcement through testing and local policy inspection.

This is a best practice in hardening domain-joined endpoints in enterprise environments.

---



## 🚀 Step 1 - Create Active Directory Security Groups for RDP Access:
   
A. **Create the `RDP-Users` Group:**

  * Open Active Directory Users and Computers (ADUC).
  * Right-click on the Users container > New > Group.
  * Name the group `RDP-Users`.
  * Set the group type to Security.
  * Click OK.


B. **Add Users to the `RDP-Users` Group**:

   - Right-click on the `RDP-Users` group > **Properties** > **Members** > **Add**.
   - Add users such as `Sophia Martinez`.
  

C. **Create the `IT-Support-RDP` : For IT support staff to manage RDP permissions centrally.**

- Open **Active Directory Users and Computers**
- Create a new **security group**:
  
   * Name: `IT-Support-RDP`
   * Scope: Global
   * Type: Security

D. **Add Support Team Users to the IT-Support-RDP Group:**

* Right-click on the `IT-Support-RDP` group > Properties > Members > Add.
* Add users such as `ali.choukatli`.

![RDP-Member](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/Screenshots/Phase%20%203/RDP_groupe.png)

>(This image shows the IT-Support-RDP group with a member added.)

## 🚀 Step 2 - **Create and Configure a GPO for RDP Access**:

   - Open the **Group Policy Management Console**.
   - Right-click on your **Domain** > **Create a GPO in this domain, and Link it here...**.
   - Name the GPO (e.g., `RDP Access Policy`).
   - Edit the GPO:
     - Navigate to:  
       **Computer Configuration** > **Policies** > **Windows Settings** >  
       **Security Settings** > **Local Policies** > **User Rights Assignment**.
     - Open **Allow log on through Remote Desktop Services**.
     - **Remove** any unnecessary default entries (like `Domain Users`) if present.
     - **Add** the `RDP-Users` and  `IT-Support-RDP` group.
    
  ![RDP-policy](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/02_AD_Integration_User_Management/Screenshots/RDP_Policy.png)

## 🚀 Step 3 - **Force a Group Policy Update**:

   On the target VM (**LTP-EMP01**), run:

   ```bash
   gpupdate /force
   ```

## 🚀 Step 4 - Test the Access:

 - Log in as Sophia Martinez from another device using RDP to LTP-EMP01.
   
 - If issues occur, check:
   - Group membership of the user.
   - GPO application (use gpresult /r).
   - The local Remote Desktop Users group if needed.
  
   ---

## 🔚 Conclusion

By completing these steps:

- The `RDP-Users` security group has been created and populated with authorized users.
- A Group Policy Object (GPO) restricts RDP logon rights exclusively to members of the `RDP-Users` group.
- The targeted VM (`LTP-EMP01`) applies this policy, allowing only authorized users to connect remotely.
- This approach significantly reduces the attack surface and enforces secure remote access management within the Active Directory environment. 
