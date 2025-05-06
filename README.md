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

## How to Run the Project

To run this code demo, start a terminal and locate to the patient-fundraising-demo folder, and apply the command:
`npx hardhat node`

Then, open another terminal, under the same folder, use the following command to run the demo of this project.
`npx hardhat run console-demo.js --network localhost`

You may need to set system settings to run the code. On Mac, if your first attempt throws an error, you may need to go to System Settings -> Privacy & Security, and click "Allow Anyway" when you see something like "edr.darwin-arm64.node was blocked...".

You may also interact with the program by lanuching a console.
`npx hardhat console --network localhost`
