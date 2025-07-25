

## 🌐 Identity Governance with SailPoint (Simulation & Concepts)

SailPoint is a leading commercial Identity Governance and Administration (IGA) platform widely used in the banking sector to automate and govern identity lifecycle management, access certifications, and compliance.

### 🎯 Goal

Demonstrate core SailPoint concepts and typical IAM analyst tasks related to access governance, certification campaigns, and access request workflows — using simulation and official documentation.

---

### 🔧 Key Features Overview

- **Connectors** to synchronize identities and entitlements from Active Directory and other systems
- **Automated provisioning and deprovisioning** based on HR triggers or request approvals
- **Access certification campaigns** to review, approve, or revoke user access periodically
- **Access request and approval workflows** with delegated approvals and audit trails
- **Compliance reporting and dashboards** for audit readiness
- **Policy enforcement** to prevent segregation of duties (SoD) conflicts

---

### 📝 Simulation Steps (Conceptual)

1. **Connector Setup**  
   - Simulate the connection between SailPoint and Active Directory to import users and group memberships.

2. **Defining Entitlements**  
   - Model application access rights as entitlements (e.g., `APP_Swift_Read`, `APP_Swift_Admin`).

3. **Onboarding Automation**  
   - Simulate an onboarding workflow where a new hire is automatically assigned base roles and entitlements via SailPoint.

4. **Access Certification Campaign**  
   - Launch a campaign to review user access to `APP_Swift_*` groups.
   - Analysts review, certify or revoke access based on business need.

5. **Access Request Workflow**  
   - Simulate a user submitting a request for elevated access via SailPoint portal.
   - Workflow routes request to manager for approval, then provisions access upon approval.

6. **Reporting & Audit**  
   - Generate reports summarizing certifications, outstanding requests, and compliance status.

---

### 💡 Benefits of Using SailPoint

- **Improved Security**: Reduces risk of excessive or outdated privileges.
- **Regulatory Compliance**: Ensures periodic access reviews and maintains audit trails.
- **Operational Efficiency**: Automates manual tasks, freeing up analysts for strategic work.
- **Centralized Governance**: Provides a unified view of identities across multiple systems.

---



