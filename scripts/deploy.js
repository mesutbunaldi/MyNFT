// deploy.js
const { ethers } = require("hardhat");

async function main() {
  const [deployer] = await ethers.getSigners();

  console.log("Deploying contracts with the account:", deployer.address);

  const MyNFT = await ethers.getContractFactory("MyNFT");
  const baseTokenURI = "https://eth-sepolia.g.alchemy.com/v2/tKWetsLwa0lmazWaF4e3uVQ2eLb-fMBG";
  const _liquidityWallet = "0xAE72602cfbE91fDfb07f889Eb74F60ADdaEa2b46"; // Replace with the address you want to set as the liquidity wallet
  const _treasuryWallet = "0x1007678884974E0D141fFe8C6cCb508e9eD923a2"; // Replace with the address you want to set as the treasury wallet

  const myNFT = await MyNFT.deploy(
    "MyNFT",
    "NFT",
    baseTokenURI,
    _liquidityWallet,
    _treasuryWallet
  );

  await myNFT.deployed();

  console.log("MyNFT contract deployed to:", myNFT.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
