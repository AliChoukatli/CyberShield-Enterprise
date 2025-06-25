## 📝 Introduction

This section focuses on organizing your Active Directory structure by creating **Organizational Units (OUs)** for each department within the domain `corp.aclab.tech`. Proper OU design is essential for applying Group Policies, managing user permissions, and maintaining a clean and scalable AD environment.

Additionally, you will learn how to safely delete an OU by disabling accidental deletion protection — a common safeguard in enterprise environments.

---

## 🔴 **Create OUs for Each Department**

Create the following Organizational Units directly under the domain `corp.aclab.tech`

* IT
* HR
* Sales
* Management
* Groups (for all AD security groups)
* Service Accounts (for service-level accounts)

![OU creation-window](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/Screenshots/Phase%202/Create_OU.png)

Once done, verify the structure:

![* Final view showing all top-level OUs under the domain](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/Screenshots/Phase%202/All_OU.png)

---

 ## ⚠️ **Delete an Organizational Unit (OU)**

1. In ADUC, go to **View** > enable **Advanced Features**

![Advanced Features](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/Screenshots/Phase%202/Adv_feature.png)
   
2. Right-click the OU → **Properties** → **Object tab**  
3. Uncheck **Protect object from accidental deletion** > OK
   
![Protect](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/Screenshots/Phase%202/protect.png)
   
4. Right-click OU > **Delete**

---

## ✅ Conclusion

After completing this section:

- The domain now contains a well-structured set of top-level OUs representing key departments: **IT**, **HR**, **Sales**, **Management**, **Groups**, and **Service Accounts**.
- This OU structure provides a foundation for applying **targeted Group Policies**, organizing users and devices logically, and enforcing administrative boundaries.
- You’ve also learned how to delete an OU properly by first disabling accidental deletion protection.

This is a critical step in building a professional, manageable, and secure Active Directory environment.
