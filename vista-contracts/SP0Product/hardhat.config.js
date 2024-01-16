require("@nomicfoundation/hardhat-toolbox");
require("@nomicfoundation/hardhat-verify");
require('dotenv').config();

const DEFAULT_BLOCK_GAS_LIMIT = 12450000;

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: {
    version: "0.8.17",
    settings: {
      optimizer: {
        runs: 150,
        enabled: true,
        details: {
          yul: true
        }
      },
      viaIR: true
    },
  },
  networks: {
    hardhat: {
      blockGasLimit: DEFAULT_BLOCK_GAS_LIMIT,
      gas: DEFAULT_BLOCK_GAS_LIMIT,
      gasPrice: 8000000000,
      allowUnlimitedContractSize: true,
    },
    localhost: {
      blockGasLimit: DEFAULT_BLOCK_GAS_LIMIT,
      gas: DEFAULT_BLOCK_GAS_LIMIT,
      gasPrice: 8000000000,
      allowUnlimitedContractSize: true,
    },
    sepolia: {
      url: process.env.ALCHEMY_SEPOLIA_URL,
      accounts: [process.env.SEPOLIA_PRIVATE_KEY]
    }
  },
  etherscan: {
    apiKey: "N8R8SHDPC2MM4SRKAXGICBEYSVXQMR3S8V",
  }
};
