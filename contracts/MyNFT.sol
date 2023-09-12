// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;
import "hardhat/console.sol";

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MyNFT is ERC721Enumerable, Ownable {
    string private _baseTokenURI;
    address public liquidityWallet;
    address public treasuryWallet;
    uint256 public royaltyFee = 10; // 10% royalty fee
    uint256 public liquidityShare = 4; // 4% of 10% goes to liquidity wallet
    uint256 public treasuryShare = 6; // 6% of 10% goes to treasury wallet

    constructor(
        string memory name,
        string memory symbol,
        string memory baseTokenURI,
        address _liquidityWallet,
        address _treasuryWallet
    ) ERC721(name, symbol) {
        _baseTokenURI = baseTokenURI;
        liquidityWallet = _liquidityWallet;
        treasuryWallet = _treasuryWallet;
    }

    function mint(address to, uint256 tokenId) external onlyOwner {
        require(!_exists(tokenId), "Token ID already minted");
        _mint(to, tokenId);
    }

    function _baseURI() internal view override returns (string memory) {
        return _baseTokenURI;
    }

    function setBaseURI(string memory baseTokenURI) external onlyOwner {
        _baseTokenURI = baseTokenURI;
    }

    function setLiquidityWallet(address _liquidityWallet) external onlyOwner {
        liquidityWallet = _liquidityWallet;
    }

    function setTreasuryWallet(address _treasuryWallet) external onlyOwner {
        treasuryWallet = _treasuryWallet;
    }

    function setRoyaltyFee(uint256 fee) external onlyOwner {
        royaltyFee = fee;
    }

    function setLiquidityShare(uint256 share) external onlyOwner {
        liquidityShare = share;
    }

    function setTreasuryShare(uint256 share) external onlyOwner {
        treasuryShare = share;
    }

    function mintNFT(uint256 tokenId) external payable {
        require(msg.value > 0, "ETH value must be greater than 0");
        require(!_exists(tokenId), "Token ID already minted");

        // Calculate royalty fee amount
        uint256 royaltyAmount = (msg.value * royaltyFee) / 100;

        // Transfer royalty fee amounts to wallets
        payable(liquidityWallet).transfer((royaltyAmount * liquidityShare) / 100);
        payable(treasuryWallet).transfer((royaltyAmount * treasuryShare) / 100);

        // Mint the NFT
        _mint(msg.sender, tokenId);
    }
}
