# 🧰 Configure "Block Untrusted and Unsigned Processes from USB Devices" via GPO

This guide explains how to enable the Attack Surface Reduction (ASR) rule that blocks untrusted and unsigned processes from running from USB devices by setting the corresponding registry key via Group Policy Object (GPO).

---

## Rule Details

- **Rule name:** Block untrusted and unsigned processes from USB devices
- **Description:** Prevents execution of processes from USB devices that are not trusted or signed.
- **GUID:** `3B576869-A4EC-4529-8536-B80A7769E899`
- **Registry path:**  
  `HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Windows Defender Exploit Guard\ASR\Rules`
- **Registry value:**  
  - **Name:** `3B576869-A4EC-4529-8536-B80A7769E899`  
  - **Type:** `REG_SZ` (String)  
  - **Value:** `"1"` (Block mode)

---

## Steps to configure via GPO

1. Open the **Group Policy Management Console (GPMC)** on a domain controller or management workstation.

2. Create a new GPO or edit an existing one linked to the target OU(s) or domain.

3. Navigate to:  
   `Computer Configuration` > `Preferences` > `Windows Settings` > `Registry`

4. Right-click **Registry**, select **New** > **Registry Item**.

5. Configure the new registry item as follows:

   - **Action:** Update  
   - **Hive:** HKEY_LOCAL_MACHINE  
   - **Key Path:** `SOFTWARE\Policies\Microsoft\Windows Defender\Windows Defender Exploit Guard\ASR\Rules`  
   - **Value name:** `3B576869-A4EC-4529-8536-B80A7769E899`  
   - **Value type:** `REG_SZ`  
   - **Value data:** `1`

6. Click **OK** to save.

7. Close the Group Policy Editor and ensure the GPO is linked correctly.

8. On target machines, run `gpupdate /force` or wait for policy refresh.

---

## Additional Notes

- If the registry path does not exist, the system will create it during policy application.
- `"1"` enables the rule in **Block mode**.
- To audit only without blocking, use `"2"` instead (Audit mode).
- This ASR rule requires Microsoft Defender Antivirus and Exploit Guard enabled.

---

This configuration helps to prevent malware execution from USB devices by blocking untrusted or unsigned processes.


