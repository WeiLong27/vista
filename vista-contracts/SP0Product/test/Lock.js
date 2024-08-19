const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("SP0Product - Extended Tests", function () {
  let sp0Product, vistaState, vaultAddress, asset, owner, traderAdmin, operatorAdmin, addr1, addr2;

  beforeEach(async function () {
    // Get signers dynamically
    [owner, traderAdmin, operatorAdmin, serviceAdmin, addr1, addr2, addr3] = await ethers.getSigners();

    // Deploy TestUSDC with an initial supply
    const TestUSDC = await ethers.getContractFactory("TestUSDC");
    asset = await TestUSDC.deploy(ethers.parseUnits("1000000", 6)); // 1,000,000 USDC with 6 decimals
    await asset.waitForDeployment();
    console.log("TestUSDC deployed at:", asset.target);

    // Deploy the Calculations library
    const calculations = await ethers.deployContract("Calculations");
    await calculations.waitForDeployment();
    console.log("Calculations library deployed at:", calculations.target);

    // Deploy the VistaState contract
    const VistaState = await ethers.getContractFactory("VistaState");
    vistaState = await VistaState.deploy(operatorAdmin.address, traderAdmin.address, serviceAdmin.address);
    await vistaState.waitForDeployment();
    console.log("VistaState deployed at:", vistaState.target);

    // Deploy the SP0Product contract
    const SP0Product = await ethers.getContractFactory("SP0Product", {
      libraries: {
        Calculations: calculations.target,
      },
    });

    sp0Product = await SP0Product.deploy(
      vistaState.target,
      asset.target,
      "SP0 Product",
      500, // management fee (5%)
      300, // yield fee (3%)
      ethers.parseUnits("1000000", 6), // max deposit limit in USDC
      ethers.parseUnits("10", 6), // min deposit in USDC
      ethers.parseUnits("5", 6) // min withdrawal in USDC
    );
    await sp0Product.waitForDeployment();
    console.log("SP0Product deployed at:", sp0Product.target);

    const txCreateVault = await sp0Product.connect(traderAdmin).createVault("Vault Token", "VLT", Math.floor(Date.now() / 1000));
    const result = await txCreateVault.wait();
    // console.log('txn events', result.logs);
    const eventLog = result.logs[1]; // We assume the second log (index 1) is the VaultCreated event
    const event = sp0Product.interface.parseLog(eventLog);

    console.log("Event name:", event.name);  // Should print "VaultCreated"
  console.log("Vault Address:", event.args[0]);  // First argument (vault address)
  console.log("Token Symbol:", event.args[1]);   // Second argument (token symbol)
  console.log("Token Name:", event.args[2]);     // Third argument (token name)
  console.log("Vault Start:", event.args[3]);    

  vaultAddress = event.args[0];
    
      // Mint and approve USDC tokens for addr1 and addr2
      await asset.mint(addr1.address, ethers.parseUnits("100", 6)); // 100 USDC to addr1
      await asset.mint(addr2.address, ethers.parseUnits("100", 6)); // 100 USDC to addr2
      console.log("here");
      await asset.connect(addr1).approve(sp0Product.target, ethers.parseUnits("50", 6));
      await asset.connect(addr2).approve(sp0Product.target, ethers.parseUnits("50", 6));
      await asset.connect(addr3).approve(sp0Product.target, ethers.parseUnits("50", 6));
      console.log("done before each");
  });

  describe("processDepositQueue", function () {
    beforeEach(async function () {
      await sp0Product.connect(operatorAdmin).setIsDepositQueueOpen(true);
    });

    it("Should process deposits and update vault balances", async function () {
      await sp0Product.connect(addr1).addToDepositQueue(ethers.parseUnits("20", 6));
      await sp0Product.connect(addr2).addToDepositQueue(ethers.parseUnits("30", 6));

      await sp0Product.connect(operatorAdmin).setVaultStatus(vaultAddress, "1");
      // Process deposit queue using traderAdmin
      await sp0Product.connect(traderAdmin).processDepositQueue(vaultAddress, 2);

      const vaultMetadata = await sp0Product.getVaultMetadata(vaultAddress);
      expect(vaultMetadata.underlyingAmount).to.equal(ethers.parseUnits("50", 6));
      expect(await sp0Product.queuedDepositsCount()).to.equal(0);
    });
  });

  describe("sendAssetsToTrade", function () {
    it("Should send assets from the vault to a receiver", async function () {
      await sp0Product.connect(operatorAdmin).setIsDepositQueueOpen(true);
      await sp0Product.connect(addr1).addToDepositQueue(ethers.parseUnits("20", 6));
      await sp0Product.connect(operatorAdmin).setVaultStatus(vaultAddress, "1");
      await sp0Product.connect(traderAdmin).processDepositQueue(vaultAddress, 1);
      var vaultMetadata = await sp0Product.getVaultMetadata(vaultAddress);
      console.log(vaultMetadata);
      console.log(vaultMetadata[6]);

      const vaultABI = [
        "function totalAssets() view returns (uint256)",
        "function totalSupply() view returns (uint256)"
    ];

      const vaultContract = new ethers.Contract(vaultAddress, vaultABI, ethers.provider);

        // Call totalAssets and totalSupply
        const totalAssets = await vaultContract.totalAssets();
        const totalSupply = await vaultContract.totalSupply();
        
        console.log("Total Assets:", totalAssets.toString());
        console.log("Total Supply:", totalSupply.toString());

      // Add mock market maker address to the allow list in VistaState
      await vistaState.connect(operatorAdmin).updateMarketMakerPermission(addr3.address, true);

      // Send assets to trade using traderAdmin
      await sp0Product.connect(traderAdmin).sendAssetsToTrade(vaultAddress, addr3.address, totalAssets);

      vaultMetadata = await sp0Product.getVaultMetadata(vaultAddress);
      console.log(vaultMetadata);
      expect(vaultMetadata[6]).to.equal(0);
      expect(await asset.balanceOf(addr3.address)).to.equal(totalAssets);
    });

    it("Should revert if receiver is not on the allow list", async function () {
      await sp0Product.connect(operatorAdmin).setIsDepositQueueOpen(true);
      await sp0Product.connect(addr1).addToDepositQueue(ethers.parseUnits("20", 6));
      await sp0Product.connect(operatorAdmin).setVaultStatus(vaultAddress, "1");
      await sp0Product.connect(traderAdmin).processDepositQueue(vaultAddress, 1);

      // Attempt to send assets to non-approved receiver
      await expect(sp0Product.connect(traderAdmin).sendAssetsToTrade(vaultAddress, addr3.address, ethers.parseUnits("10", 6)))
        .to.be.revertedWith("400:NotAllowed");
    });
  });

  // describe("addToWithdrawalQueue", function () {
  //   it("Should allow users to queue withdrawals", async function () {
  //     await sp0Product.setIsDepositQueueOpen(true);
  //     await sp0Product.connect(addr1).addToDepositQueue(ethers.utils.parseEther("20"));
  //     await sp0Product.connect(traderAdmin).processDepositQueue(vault, 1);

  //     // Simulate vault token minting to addr1
  //     const Vault = await ethers.getContractAt("SP0Vault", vault);
  //     await Vault.connect(traderAdmin).mint(addr1.address, ethers.utils.parseEther("20"));

  //     // Approve vault tokens and add to withdrawal queue
  //     await Vault.connect(addr1).approve(sp0Product.address, ethers.utils.parseEther("15"));
  //     await sp0Product.connect(addr1).addToWithdrawalQueue(vault, ethers.utils.parseEther("15"));

  //     const vaultMetadata = await sp0Product.getVaultMetadata(vault);
  //     expect(vaultMetadata.queuedWithdrawalsSharesAmount).to.equal(ethers.utils.parseEther("15"));
  //   });

  //   it("Should revert if withdrawal amount is less than the minimum", async function () {
  //     await sp0Product.setIsDepositQueueOpen(true);
  //     await sp0Product.connect(addr1).addToDepositQueue(ethers.utils.parseEther("20"));
  //     await sp0Product.connect(traderAdmin).processDepositQueue(vault, 1);

  //     // Simulate vault token minting to addr1
  //     const Vault = await ethers.getContractAt("SP0Vault", vault);
  //     await Vault.connect(traderAdmin).mint(addr1.address, ethers.utils.parseEther("5"));

  //     // Try to withdraw less than the minimum withdrawal amount
  //     await Vault.connect(addr1).approve(sp0Product.address, ethers.utils.parseEther("3"));
  //     await expect(sp0Product.connect(addr1).addToWithdrawalQueue(vault, ethers.utils.parseEther("3")))
  //       .to.be.revertedWith("400:WA");
  //   });
  // });

  // describe("processWithdrawalQueue", function () {
  //   beforeEach(async function () {
  //     await sp0Product.setIsDepositQueueOpen(true);
  //     await sp0Product.connect(addr1).addToDepositQueue(ethers.utils.parseEther("20"));
  //     await sp0Product.connect(traderAdmin).processDepositQueue(vault, 1);

  //     // Simulate vault token minting to addr1
  //     const Vault = await ethers.getContractAt("SP0Vault", vault);
  //     await Vault.connect(traderAdmin).mint(addr1.address, ethers.utils.parseEther("20"));
  //     await Vault.connect(addr1).approve(sp0Product.address, ethers.utils.parseEther("20"));
  //   });

  //   it("Should process withdrawals and update balances", async function () {
  //     // Queue a withdrawal
  //     await sp0Product.connect(addr1).addToWithdrawalQueue(vault, ethers.utils.parseEther("15"));

  //     // Process the withdrawal
  //     await sp0Product.connect(traderAdmin).processWithdrawalQueue(vault, 1);

  //     const vaultMetadata = await sp0Product.getVaultMetadata(vault);
  //     expect(vaultMetadata.queuedWithdrawalsSharesAmount).to.equal(ethers.utils.parseEther("0"));
  //   });

  //   it("Should revert if trying to process more withdrawals than available", async function () {
  //     await sp0Product.connect(addr1).addToWithdrawalQueue(vault, ethers.utils.parseEther("10"));

  //     await expect(sp0Product.connect(traderAdmin).processWithdrawalQueue(vault, 2))
  //       .to.be.revertedWith("500:WS");
  //   });
  // });
});
