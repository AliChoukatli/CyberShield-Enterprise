## ⚙️ Prerequisites

Before starting **Phase 1**, ensure you meet the following requirements:

- ✅ A host machine with at least 8 GB RAM and virtualization enabled (BIOS/UEFI).
- ✅ Windows 11 ISO (64-bit).
- ✅ Windows Server 2022 ISO.
- ✅ Internet access (ports 80/443 open).
- ✅ PowerShell 5.1 or later installed (`$PSVersionTable.PSVersion`).
- ✅ Microsoft 365 Business Premium subscription (includes Azure AD P1 and Intune).
- ✅ Virtualization platform: Hyper-V, VMware, or VirtualBox.
- ✅ Local administrative privileges.

---

## 🛠️ Overview

In this phase, you will:

- Install and configure 2–3 Windows 11 client VMs.
- Install Windows Server 2022 for Active Directory setup.
- Configure static IP addresses.
- Promote the server to a Domain Controller.
- Verify Active Directory installation.

---

## 🧠 Summary **Phase 1 - Installation & Domain Join**

This phase covers the initial setup of the server and workstation environment in a secure domain-based structure:

- **Windows Server 2022 Configuration:** A Domain Controller (`DC01`) was installed and configured with Active Directory Domain Services (AD DS) for the domain `corp.aclab.tech`.
- **Workstation Installation:** A Windows 11 Pro machine (`Win11-01`) was installed to simulate an end-user or IT technician system.
- **Domain Join:** The Windows 11 workstation was joined to the `corp.aclab.tech` domain, enabling centralized identity and device management from the Domain Controller.

These steps simulate real-world onboarding of new devices into an enterprise Active Directory environment.
