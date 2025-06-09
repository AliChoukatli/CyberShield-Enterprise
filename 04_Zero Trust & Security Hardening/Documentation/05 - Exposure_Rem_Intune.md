# 🛡️ Apply ASR Rule via Microsoft Intune




## Rule: Block executable content from email client and webmail
> GUID: `BE9BA2D9-53EA-4CDC-84E5-9B1EEEE46550`

## 🔧 Step-by-step via Intune

1. Go to the **Microsoft Intune Admin Center**: [https://intune.microsoft.com](https://intune.microsoft.com)
2. Navigate to:  
   `Endpoint Security` → `Attack Surface Reduction`
3. Click on **+ Create Policy**
   - Platform: **Windows 10 and later**
   - Profile: **Attack surface reduction rules**
4. Configure the following:
   - Rule name: `Block executable content from email client and webmail`
   - GUID: `BE9BA2D9-53EA-4CDC-84E5-9B1EEEE46550`
   - Action: `Block`
5. Assign the policy to your **targeted devices or groups**
6. Review + Create

✅ Once deployed, the rule will be enforced on all assigned devices.

## 📘 Reference:
[Microsoft Docs – ASR via Intune](https://learn.microsoft.com/en-us/microsoft-365/security/defender-endpoint/attack-surface-reduction-rules-reference)

---

# Configure "Block credential stealing from LSASS" ASR Rule via Intune

This guide explains how to enable the Attack Surface Reduction (ASR) rule that blocks credential stealing from the Windows Local Security Authority Subsystem Service (LSASS) using Microsoft Intune.

---

## Rule Details

- **Rule name:** Block credential stealing from LSASS
- **Description:** Prevents processes from accessing LSASS process memory to steal credentials.
- **GUID:** `9E6C4E1F-7D60-472F-BA1A-A39EF669E4B2`
- **Intune Profile Type:** Endpoint Security > Attack Surface Reduction
- **Recommended Mode:** Block (`1`)

---

## Steps to enable in Intune

1. Sign in to the [Microsoft Endpoint Manager admin center](https://endpoint.microsoft.com/).

2. Navigate to **Endpoint security** > **Attack surface reduction**.

3. Click **Create Policy**.

4. Configure the following:

   - **Platform:** Windows 10 and later  
   - **Profile:** Attack Surface Reduction Rules

5. Under **Attack Surface Reduction Rules**, find the rule **Block credential stealing from LSASS** or add the rule using its GUID:  
   `9E6C4E1F-7D60-472F-BA1A-A39EF669E4B2`

6. Set the rule state to **Block**.

7. Assign the policy to the appropriate device groups.

8. Review and create the policy.

---

## Notes

- If **LSA Protection** (Local Security Authority Protection) is enabled on devices, this ASR rule is considered redundant and may be classified as *not applicable* in Defender for Endpoint.
- The rule does **not** support Warn mode.
- This rule can generate many audit events; it's recommended to start with a pilot group before broad deployment.

---

Enable this policy to help protect Windows devices against credential theft attacks targeting LSASS.

