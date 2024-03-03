// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.21;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract NFTMarketplace is ERC721URIStorage {
    address public owner;
    uint256 public tokenId;
    mapping(uint256 => uint256) public tokenPrices;
    mapping(uint256 => bool) public tokenListings;

    // Events
    event MintedNFT(address indexed _to, string _tokenURI, uint256 _price);
    event ListedNFT(uint256 indexed _tokenId, uint256 _price);
    event BoughtNFT(uint256 indexed _tokenId, address indexed _buyer);

    constructor() ERC721("NFTMarketplace", "NFTM") {
        owner = msg.sender;
    }

    function mintNFT(
        address _to,
        string memory _tokenURI,
        uint256 _price
    ) external {
        tokenId++;
        tokenPrices[tokenId] = _price;
        _mint(_to, tokenId);
        _setTokenURI(tokenId, _tokenURI);
        emit MintedNFT(_to, _tokenURI, _price);
    }

    function listNFT(uint256 _tokenId, uint256 _price) external {
        require(
            ownerOf(_tokenId) == msg.sender,
            "NFTMarketplace: only owner can list token"
        );
        tokenPrices[_tokenId] = _price;
        tokenListings[_tokenId] = true;
        emit ListedNFT(_tokenId, _price);
    }

    function buyNFT(uint256 _tokenId) external payable {
        require(
            msg.value >= tokenPrices[_tokenId],
            "NFTMarketplace: value must be greater than or equal to token price"
        );
        address seller = ownerOf(_tokenId);
        address buyer = msg.sender;
        uint256 price = msg.value;

        safeTransferFrom(seller, buyer, _tokenId);
        payable(seller).transfer(price);
        tokenListings[_tokenId] = false;
        emit BoughtNFT(_tokenId, buyer);
    }
}
