require("@nomicfoundation/hardhat-toolbox");
// require("@nomicfoundation/hardhat-verify");

// Go to https://alchemy.com, sign up, create a new App in
// its dashboard, and replace "KEY" with its key
const ALCHEMY_API_KEY = "tKWetsLwa0lmazWaF4e3uVQ2eLb-fMBG";

// Replace this private key with your Sepolia account private key
// To export your private key from Coinbase Wallet, go to
// Settings > Developer Settings > Show private key
// To export your private key from Metamask, open Metamask and
// go to Account Details > Export Private Key
// Beware: NEVER put real Ether into testing accounts
const SEPOLIA_PRIVATE_KEY = "8f194815d35c19fcb665445bf25a72df6828cf9d44a4a492d9b2149cc567c35e";

module.exports = {
  solidity: "0.8.9",
  networks: {
    sepolia: {
      url: `https://eth-sepolia.g.alchemy.com/v2/${ALCHEMY_API_KEY}`,
      accounts: [SEPOLIA_PRIVATE_KEY]
    }
  },
  etherscan: {
    // Your API key for Etherscan
    // Obtain one at https://etherscan.io/
    apiKey: "Z5JH3W47TTPXHD16ZRVUWQBRUWS9WPJQU5"
  }
};
