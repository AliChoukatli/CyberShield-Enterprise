# 🧩 Microsoft Sentinel & Defender for Endpoint Integration

This guide walks you through the steps required to connect Microsoft Defender for Endpoint (MDE) to Microsoft Sentinel for centralized threat detection and response.

---

## 🛠️ Prerequisite – Defender for Endpoint Onboarding

Before proceeding, ensure that your devices are properly onboarded to Microsoft Defender for Endpoint.

📄 Refer to the onboarding guide:  
[`Defender_Endpoint_Onboarding.md`](../04_AzureAD_&_Endpoint_Security/Defender_Endpoint_Onboarding.md)

Devices must:
- Appear in **Microsoft 365 Defender > Assets > Devices**
- Show telemetry in the timeline

---

## 🔗 Step 1 – Connect Defender for Endpoint to Sentinel

1. Go to the [Azure Portal](https://portal.azure.com)
2. Navigate to:  
   `Microsoft Sentinel → Your Workspace → Content Hub`
3. Search for **Microsoft 365 Defender**
4. Click **Install** and follow the wizard to complete the connection
5. Confirm these connectors are active:
   - `Microsoft 365 Defender (Unified XDR)`
   - `Microsoft Defender for Endpoint (Device telemetry and alerts)`

✅ Once installed, the solution will automatically connect Defender alerts and telemetry to Sentinel.

---

## 🔍 Step 2 – Validate Data Ingestion

To confirm that alerts are coming from Defender into Sentinel:

1. Go to `Microsoft Sentinel → Logs`
2. Run the following Kusto Query Language (KQL) query:

```kql
SecurityAlert
| where ProductName == "Microsoft Defender for Endpoint"
| sort by TimeGenerated desc
```
3. You should see recent alerts generated from Defender for Endpoint.

💡 Tip: You can simulate a test alert (e.g., by using Defender test scripts or EICAR) to verify live ingestion.

## ✅ Best Practices

| **Area**              | **Recommendation**                                                    |
|-----------------------|------------------------------------------------------------------------|
| Alert Ingestion       | Use the unified **Microsoft 365 Defender** connector                   |
| Alert Correlation     | Enable **advanced fusion rules** for cross-product incident linking    |
| Automation            | Use **Logic Apps** for auto-isolation, tagging, and escalation         |
| Noise Reduction       | **Tune analytic rules** and apply appropriate filters                  |
| Enrichment            | Use **entity behavior analytics** and **workbook dashboards**          |
| Endpoint Visibility   | Onboard **all Windows endpoints and servers**                          |


