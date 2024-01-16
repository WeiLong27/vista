const hre = require("hardhat");
const path = require("path");
require('dotenv').config({ path: '../.env' });


async function main() {
  // Define the admin addresses
  const operatorAdmin = process.env.OPERATOR_ADMIN_ADDRESS; // Replace with actual address
  const traderAdmin = process.env.TRADER_ADMIN_ADDRESS; // Replace with actual address
  const serviceAdmin = process.env.SERVICE_ADMIN_ADDRESS; // Replace with actual address

  // Deploy the contract
  const vistaState = await hre.ethers.deployContract("VistaState", [operatorAdmin, traderAdmin, serviceAdmin]);
  await vistaState.waitForDeployment();

  console.log("VistaState deployed: ", vistaState.target);

  saveFrontendFiles(vistaState);

}

function saveFrontendFiles(vistaState) {
  const fs = require("fs");
  const contractsDir = path.join(__dirname, "..", "frontend", "src", "contracts");

  if (!fs.existsSync(contractsDir)) {
    fs.mkdirSync(contractsDir);
  }

  fs.writeFileSync(
    path.join(contractsDir, "contract-address.json"),
    JSON.stringify({ VistaState: vistaState.target }, undefined, 2)
  );

  const StateArtifact = artifacts.readArtifactSync("VistaState");

  fs.writeFileSync(
    path.join(contractsDir, "VistaState.json"),
    JSON.stringify(StateArtifact, null, 2)
  );
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
