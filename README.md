#  Patient Fundraising Platform (Blockchain-Based)

A transparent and secure patient fundraising platform powered by **Ethereum smart contracts**, designed to ensure donations are used strictly for medical purposes via vendor-only payouts.

##  Overview

Traditional fundraising platforms suffer from a lack of transparency, high transaction fees, and fund misuse. This blockchain-based solution addresses those issues by using smart contracts to manage:

- **Verified patient registration**
- **Traceable donor transactions**
- **Controlled fund release to verified medical vendors only**
##  Features

-  **Smart Contract Enforcement**: Only approved vendors can receive payments.
-  **Full Transaction Transparency**: Every donation and fund transfer is recorded on-chain.
-  **Verified Patient Registry**: Only approved patients can raise funds.
-  **Purpose-Linked Spending**: Each vendor payment includes a spending purpose.

##  Technologies

- **Solidity** (Ethereum Smart Contracts)
- **Hardhat** for deployment/testing

##  Smart Contract Key Functions

| Function | Description |
|---------|-------------|
| `donateToPatient(patientId)` | Public function allowing donations to a verified patient |
| `payVendor(patientId, vendor, amount, purpose)` | Admin-only function to release funds to a verified hospital/pharmacy |
| `verifyPatient(address, name, condition, targetAmount)` | Admin function to onboard new patients |
