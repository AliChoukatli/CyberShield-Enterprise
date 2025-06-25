

## 🔴 **Configuring RDP Permissions**

### 📝 Introduction

This section guides you through configuring **Remote Desktop Protocol (RDP)** permissions to securely restrict RDP access on a VM (`LTP-EMP01`) to authorized users only. By creating a dedicated security group (`RDP-Users`) and linking it via Group Policy, you enforce granular control over who can remotely connect to critical machines.

This practice enhances security by limiting RDP access, which is often a common attack vector, to a carefully controlled set of users.

---

### 🎯 Objective
Ensure that selected users (e.g., `Sophia Martinez`) can securely connect via RDP to a VM (LTP-EMP01) by granting permissions only to an authorized group.

### 🛠️ Steps

1. **Create the `RDP-Users` Group**:

   - Open **Active Directory Users and Computers (ADUC)**.
   - Right-click on the **Users** container > **New** > **Group**.
   - Name the group `RDP-Users`.
   - Set the group type to **Security**.
   - Click **OK**.

2. **Add Users to the `RDP-Users` Group**:

   - Right-click on the `RDP-Users` group > **Properties** > **Members** > **Add**.
   - Add users such as `Sophia Martinez`.

3. **Create and Configure a GPO for RDP Access**:

   - Open the **Group Policy Management Console**.
   - Right-click on your **Domain** > **Create a GPO in this domain, and Link it here...**.
   - Name the GPO (e.g., `RDP Access Policy`).
   - Edit the GPO:
     - Navigate to:  
       **Computer Configuration** > **Policies** > **Windows Settings** >  
       **Security Settings** > **Local Policies** > **User Rights Assignment**.
     - Open **Allow log on through Remote Desktop Services**.
     - **Remove** any unnecessary default entries (like `Domain Users`) if present.
     - **Add only** the `RDP-Users` group.
    
  ![RDP-policy](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/Screenshots/Phase%202/RDP-policy.png)

4. **Force a Group Policy Update**:

   On the target VM (**LTP-EMP01**), run:

   ```bash
   gpupdate /force
   ```

5. Test the Access:

 - Log in as Sophia Martinez from another device using RDP to LTP-EMP01.
   
 - If issues occur, check:
   - Group membership of the user.
   - GPO application (use gpresult /r).
   - The local Remote Desktop Users group if needed.
  
   ---

   ### ✅ Conclusion

By completing these steps:

- The `RDP-Users` security group has been created and populated with authorized users.
- A Group Policy Object (GPO) restricts RDP logon rights exclusively to members of the `RDP-Users` group.
- The targeted VM (`LTP-EMP01`) applies this policy, allowing only authorized users to connect remotely.
- This approach significantly reduces the attack surface and enforces secure remote access management within the Active Directory environment.
Veux-tu que je t’aide à préparer une section sur la configuration d’une bastion host ou d’un jump server
 
