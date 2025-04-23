// scripts/deploy.js
const { ethers } = require("hardhat");

async function main() {
  const [deployer] = await ethers.getSigners();
  console.log("deployer's address:", deployer.address);

  const PatientFundraising = await ethers.getContractFactory("PatientFundraising");
  const fundraising = await PatientFundraising.deploy();

  console.log("PatientFundraising contract address:", fundraising.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });