## 🔴 **Configuring RDP Permissions**

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
 
