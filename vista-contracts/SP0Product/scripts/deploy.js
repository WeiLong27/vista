const hre = require("hardhat");
const path = require("path");
require('dotenv').config({ path: '../.env' });
require("@nomicfoundation/hardhat-ethers");


async function main() {

  // console.log("Deploying Calculations library...");
  // const calculations = await hre.ethers.deployContract("Calculations");
  // await calculations.waitForDeployment();

  // console.log("Calculations library deployed: ", calculations.target);

  // Define the admin addresses
  const vistaStateAddress = process.env.VISTA_STATE_ADDRESS; // Address of the deployed VistaState contract
  const assetAddress = process.env.UNDERLYING_MASS_TOKEN_ADDRESS; // Address of the underlying asset (ERC20 token)
  const productName = process.env.PRODUCT_NAME;
  const managementFeeBps = process.env.MANAGEMENT_FEE;
  const yieldFeeBps = process.env.YIELD_FEE_BPS;
  const maxDepositAmountLimit = process.env.MAX_DEPOSIT_AMOUNT_LIMIT; 
  const minDepositAmount = process.env.MIN_DEPOSIT_AMOUNT; 
  const minWithdrawalAmount = process.env.MIN_WITHDRAWAL_AMOUNT;

  console.log("Deploying SP0Product");
  // Deploy the contract
  const SP0Product = await hre.ethers.getContractFactory("SP0Product", {
        libraries: {
            Calculations: "0x20322DC538F70C76b77afC2e38E947bB613Aa0db",
        },
    });

  const sp0Product = await SP0Product.deploy(
        vistaStateAddress,
        assetAddress,
        productName,
        managementFeeBps,
        yieldFeeBps,
        maxDepositAmountLimit,
        minDepositAmount,
        minWithdrawalAmount
    );

  await sp0Product.waitForDeployment();

  console.log("SP0Product deployed: ", sp0Product.target);
  console.log("SP0Product deployed (backup): ", sp0Product.address);

  saveFrontendFiles(sp0Product);
  //saveCalculationsLibraryAddress(calculations);
}

function saveFrontendFiles(sp0Product) {
  const fs = require("fs");
  const contractsDir = path.join(__dirname, "..", "frontend", "src", "contracts");

  if (!fs.existsSync(contractsDir)) {
    fs.mkdirSync(contractsDir);
  }

  fs.writeFileSync(
    path.join(contractsDir, "contract-address.json"),
    JSON.stringify({ SP0Product: sp0Product.target }, undefined, 2)
  );

  const ProductArtifact = artifacts.readArtifactSync("SP0Product");

  fs.writeFileSync(
    path.join(contractsDir, "SP0Product.json"),
    JSON.stringify(ProductArtifact, null, 2)
  );
}

function saveCalculationsLibraryAddress(calculations) {
  const fs = require("fs");
  const contractsDir = path.join(__dirname, "..", "frontend", "src", "contracts");

  if (!fs.existsSync(contractsDir)) {
    fs.mkdirSync(contractsDir);
  }

  fs.writeFileSync(
    path.join(contractsDir, "contract-address.json"),
    JSON.stringify({ Calculations: calculations.target }, undefined, 2)
  );

  const LibraryArtifact = artifacts.readArtifactSync("Calculations");

  fs.writeFileSync(
    path.join(contractsDir, "Calculations.json"),
    JSON.stringify(LibraryArtifact, null, 2)
  );
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
