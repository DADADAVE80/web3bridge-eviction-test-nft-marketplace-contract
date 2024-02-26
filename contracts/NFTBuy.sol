// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.21;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract NFTBuy {
    ERC721 public nft;

    constructor(address _nft) {
        nft = ERC721(_nft);
    }

    function buyNFT(uint256 _tokenId) external payable {
        require(msg.value > 0, "NFTBuy: value must be greater than 0");
        require(
            nft.ownerOf(_tokenId) != address(0),
            "NFTBuy: token does not exist"
        );
        require(
            nft.ownerOf(_tokenId) != msg.sender,
            "NFTBuy: cannot buy your own token"
        );

        address seller = nft.ownerOf(_tokenId);
        address buyer = msg.sender;
        uint256 price = msg.value;

        nft.safeTransferFrom(seller, buyer, _tokenId);
        payable(seller).transfer(price);
    }
}