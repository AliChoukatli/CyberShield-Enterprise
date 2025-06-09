# 🛡️ Apply ASR Rule via Microsoft Intune


## Rule : Enable PUA Protection in Block Mode using Microsoft Intune

This setting blocks potentially unwanted applications (PUAs) such as adware, spyware, or other low-reputation software.

---

## Steps to configure in Intune

1. Sign in to the [Microsoft Endpoint Manager admin center](https://endpoint.microsoft.com/).
2. Go to **Devices** > **Configuration profiles** > **Create profile**.
3. Select:
   - **Platform**: Windows 10 and later
   - **Profile type**: Templates > Endpoint protection
4. Under **Microsoft Defender Antivirus**, locate **Potentially unwanted application protection**.
5. Set **Enable Potentially Unwanted Application Protection** to **Enable**.
6. Set **PUA Protection mode** to **Block**.
7. Assign the profile to your target device groups.
8. Save and deploy.

---

Enabling PUA Protection in Block mode helps prevent potentially unwanted applications from running on your Windows devices managed by Intune.

---



> Rule: **Block executable content from email client and webmail**  
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
