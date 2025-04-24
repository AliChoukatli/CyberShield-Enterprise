# MFA – Before vs After (Realistic Attack Scenario)

## ⚠️ Before – MFA Off (Vulnerable)

### 📸 `before_mfa_login_success.png`
Capture a successful login to **Microsoft 365 / Outlook Web** using **just the password**.
- Simulate a **brute-force attack** or login with a **stolen password** (e.g., user@test.com / Password123!)
  
#### Sentinel Log Example:
- Event: `Impossible Travel` detected from **another country**
  


✅ After – MFA On (Secure)
📸 after_mfa_prompt.png
Capture of Microsoft prompting for MFA verification (e.g., a code or Authenticator app).

This shows that the attack fails without the second factor (e.g., SMS code, Authenticator App).

📸 after_mfa_signin_blocked.png
Capture of a sign-in blocked message due to Conditional Access policies.

Event shown in Azure AD Sign-in Logs:

Filter by Status: Interrupted or Failure

Mention Conditional Access policies active

Message: Even with a stolen password, the attacker cannot access the account without the second factor of authentication.
