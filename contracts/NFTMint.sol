// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.21;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract NFTMint is ERC721, Ownable {
    uint256 public tokenId;
    mapping(uint256 => string) public tokenURIs;

    constructor(string memory _name, string memory _symbol) ERC721() {
        name = _name;
        symbol = _symbol;
    }

    function mint(string memory _tokenURI) external onlyOwner {
        tokenId++;
        tokenURIs[tokenId] = _tokenURI;
        _safeMint(msg.sender, tokenId);
    }

    function _baseURI() internal pure override returns (string memory) {
        return "https://nft-maker.com/api/token/";
    }

    function tokenURI(uint256 _tokenId)
        public
        view
        override
        returns (string memory)
    {
        return string(abi.encodePacked(_baseURI(), tokenURIs[_tokenId]));
    }
}