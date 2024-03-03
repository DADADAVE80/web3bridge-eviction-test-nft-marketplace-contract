import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import dotenv from "dotenv";

dotenv.config();

const {
  ALCHEMY_ETH_MAINNET_RPC_URL,
  SEPOLIA_RPC_URL,
  MUMBAI_RPC_URL,
  POLYGONSCAN_API_KEY,
  PRIVATE_KEY
} = process.env;

const config: HardhatUserConfig = {
  solidity: "0.8.24",
  networks: {
    hardhat: {
      forking: {
        url: ALCHEMY_ETH_MAINNET_RPC_URL!,
      },
    },
    sepolia: {
      url: SEPOLIA_RPC_URL!,
      accounts: [PRIVATE_KEY!],
    },
    mumbai: {
      url: MUMBAI_RPC_URL!,
      accounts: [PRIVATE_KEY!],
    },
  },
  etherscan: {
    apiKey: {
      polygonMumbai: POLYGONSCAN_API_KEY!,
    }
  },
  sourcify: {
    enabled: true
  }
};

export default config;