# 🌐 Network Troubleshooting & Connectivity Checks

## 🎯 Objective

Perform fundamental network diagnostics from the employee workstation to verify connectivity to the network gateway and domain controller, validate IP settings, and confirm the network adapter’s operational status.

## 📝 Introduction

This section guides you through essential network troubleshooting steps from a client workstation (`LTP-EMP01`) to ensure proper connectivity with the domain controller and internal network.

You'll perform diagnostic actions like pinging the default gateway and DC, checking the IP configuration, and verifying network adapter health. These steps are critical to resolving connectivity issues that may impact domain access, file sharing, or remote management.

---

## 🔴 **Troubleshoot Network Connectivity**

## 🚀 **1 - Ping**

#### 🎯 *Objective : Verify basic network connectivity by pinging the default gateway and the domain controller (DC).*

All commands below are executed from the employee workstation: **LTP-EMP01**.

#### ▶️ Test A – Ping the Default Gateway
- Purpose: Ensure the device can reach the router (gateway) and confirm LAN connectivity is functional.
- **Command:**
```bash
ping 192.168.2.1
```
![Ping-Router](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/Screenshots/Phase%20%203/Ping-Router.png)
  
#### ▶️ Test B – Ping the Domain Controller (DC)
- Purpose: Confirm that LTP-EMP01 can reach the Active Directory server (DC) over the network.
- **Command:**
```bash
ping 192.168.2.10
```
![Ping-DC](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/Screenshots/Phase%20%203/Ping-DC.png)


#### 🧠 Notes:
If the ping fails:

- ✅ Ensure the domain controller is powered on and properly connected to the network.
- 🔥 Check if ICMP traffic is allowed through Windows Firewall on the target machine.
- 🧩 Confirm that both the source (LTP-EMP01) and target (DC) machines are on the same subnet.
- 🛠️ Use the following command on the domain controller to verify its IP address:
  ```bash
  ipconfig

--- 

## 🚀 **2 - IP Configuration**

```bash
ipconfig /all
```
![ipconfig](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/Screenshots/Phase%20%203/ipconfig.png)

---

## 🔴 **Inspect Network Adapter Status**

#### 🎯 Objective: *Verify if the network adapter is functioning properly.*

- **Why is this important?**  
  This step helps diagnose any network connectivity issues related to the hardware. If the NIC (Network Interface Controller) is having issues, it could cause network disruptions, affecting access to network resources, including domain services.

- **Procedure:**
  1. Open **Device Manager**.
  2. Expand the **Network Adapters** section.
  3. Check for warning icons or missing devices.  
     *(If no warning icons are present, it means no issues have been detected.)*
  4. If needed, right-click the network adapter and select **Update Driver** to check for driver updates.

 ![update-driver](https://github.com/AliChoukatli/CyberShield-Enterprise/blob/main/Screenshots/Phase%20%203/update-driver.png)

 ---
 
 ## 🔚 Conclusion

After completing this section:

- Network connectivity was successfully validated between `LTP-EMP01` and core infrastructure components (gateway and DC).
- You confirmed that the workstation has a valid IP configuration using `ipconfig /all`.
- The health and driver status of the network adapter were verified via Device Manager.

These troubleshooting techniques are foundational for any IT support role, helping you quickly identify and resolve common connectivity problems in a domain environment.


