// Run these commands in the Hardhat console to demonstrate the functionality

const accounts = await ethers.getSigners();
const admin = accounts[0];
const patient = accounts[1];
const donor = accounts[2];
const hospital = accounts[3];


const PatientFundraising = await ethers.getContractFactory("PatientFundraising");
const fundraising = await PatientFundraising.deploy();
await fundraising.deployed();
console.log("Contract deployed at address:", fundraising.address);


await fundraising.addTestPatient(
  patient.address, 
  "John Smith", 
  "Heart Surgery", 
  ethers.utils.parseEther("5")
);
console.log("Added patient: John Smith, needs 5 ETH for Heart Surgery");


await fundraising.addTestVendor(hospital.address);
console.log("Added medical vendor:", hospital.address);


const initialPatientFunds = await fundraising.patientFunds(1);
console.log("Initial patient funds:", ethers.utils.formatEther(initialPatientFunds), "ETH");

await fundraising.connect(donor).donateToPatient(
  1, 
  "Get well soon!", 
  { value: ethers.utils.parseEther("2") }
);
console.log("Donor has donated 2 ETH to patient");

const afterDonationFunds = await fundraising.patientFunds(1);
console.log("Patient funds after donation:", ethers.utils.formatEther(afterDonationFunds), "ETH");


await fundraising.connect(patient).payVendor(
  1, 
  hospital.address, 
  ethers.utils.parseEther("1"), 
  "Initial consultation fee"
);
console.log("Patient has paid 1 ETH to hospital for initial consultation");


const afterPaymentFunds = await fundraising.patientFunds(1);
console.log("Patient funds after payment:", ethers.utils.formatEther(afterPaymentFunds), "ETH");

const transactions = await fundraising.getAllTransactions();
console.log("\nTransaction Records:");
for (let i = 0; i < transactions.length; i++) {
  console.log(`Transaction ${i+1}:`);
  console.log(`- From: ${transactions[i].from}`);
  console.log(`- To: ${transactions[i].to}`);
  console.log(`- Amount: ${ethers.utils.formatEther(transactions[i].amount)} ETH`);
  console.log(`- Purpose: ${transactions[i].purpose}`);
  console.log(`- Time: ${new Date(transactions[i].timestamp.toNumber() * 1000).toLocaleString()}`);
  console.log("-------------------");
}

console.log("\nDemo completed! This demonstrates how blockchain solves key problems in medical fundraising:");
console.log("1. Risk of fund misuse - Funds can only be paid to verified medical providers");
console.log("2. Transparency - All transactions are recorded on the blockchain and viewable anytime");
console.log("3. Fund traceability - Every donation and expense is clearly recorded");