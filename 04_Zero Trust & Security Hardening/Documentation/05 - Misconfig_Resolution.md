# Secrurity Misconfiguration Identified & Resolved

## 1. Protocole obsolete non desactivé (IMAP/POP/SMTP)

verifie si active powershell

desactive : powershell

-> Impcat: even with MFA in place, i ensured legacy protocols such as IMAP and POP were disabled to prevent credential-based attacks by passing modern authentication mechanisms.

---

## 2. unused guest account sor inactive users still enabled 

Get-azureaduser etc poiwershell

---

## 3. pasd de control sur les insallations logicielles

-> to reduce the attack surface, i restriced software installations to approved applications via intune policeis and applocker.

----

## 4. bitlocker active mais sans backup securisé :

   azure ad -> devoces -> clique sur la machine -> recovery keys

   i verified that bitlocker recovery keys were properly backed up to azure ad, ensuring data recovery and compliance.

## 5. pas dexpiration ou de rotation de mot de passe admin local

   laps -> integré a intune
---

## 6. pas de journalisation dacces ou activité

   activer audit log dans entra id
   activer sign in logs+ ennvoyer vers sentinel
---
