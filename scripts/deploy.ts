import { ethers } from "hardhat";

async function main() {
  const nftMarketplace = await ethers.deployContract("NFTMarketplace");

  await nftMarketplace.waitForDeployment();

  console.log(
    `NFTMarketplace deployed to ${nftMarketplace.target}`
  );
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
