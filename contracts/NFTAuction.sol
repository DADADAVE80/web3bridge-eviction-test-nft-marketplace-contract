// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.21;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract NFTAuction is Ownable {
    struct Auction {
        address seller;
        uint256 tokenId;
        uint256 price;
        uint256 startTime;
        uint256 endTime;
    }

    ERC721 public nft;
    uint256 public auctionId;
    mapping(uint256 => Auction) public auctions;

    event AuctionCreated(
        uint256 auctionId,
        address seller,
        uint256 tokenId,
        uint256 price,
        uint256 startTime,
        uint256 endTime
    );
    event AuctionCancelled(uint256 auctionId);
    event AuctionSuccessful(
        uint256 auctionId,
        address seller,
        address buyer,
        uint256 price
    );

    constructor(address _nft) {
        nft = ERC721(_nft);
    }

    function createAuction(
        uint256 _tokenId,
        uint256 _price,
        uint256 _startTime,
        uint256 _endTime
    ) external {
        require(
            nft.ownerOf(_tokenId) == msg.sender,
            "NFTMarketplace: not the owner"
        );
        require(_price > 0, "NFTMarketplace: price must be greater than 0");
        require(
            _startTime < _endTime,
            "NFTMarketplace: start time must be less than end time"
        );
        require(
            _endTime > block.timestamp,
            "NFTMarketplace: end time must be greater than current time"
        );

        auctions[auctionId] = Auction({
            seller: msg.sender,
            tokenId: _tokenId,
            price: _price,
            startTime: _startTime,
            endTime: _endTime
        });

        nft.transferFrom(msg.sender, address(this), _tokenId);

        emit AuctionCreated(
            auctionId,
            msg.sender,
            _tokenId,
            _price,
            _startTime,
            _endTime
        );

        auctionId++;
    }

    function cancelAuction(uint256 _auctionId) external {
        Auction memory auction = auctions[_auctionId];
        require(auction.seller == msg.sender, "NFTMarketplace: not the seller");
        require(
            auction.endTime > block.timestamp,
            "NFTMarketplace: auction has ended"
        );

        nft.transferFrom(address(this), msg.sender, auction.tokenId);

        delete auctions[_auctionId];

        emit AuctionCancelled(_auctionId);
    }

    function bid(uint256 _auctionId) external payable {
        Auction memory auction = auctions[_auctionId];
        require(
            auction.seller != address(0),
            "NFTMarketplace: auction not found"
        );
        require(
            auction.startTime < block.timestamp,
            "NFTMarketplace: auction has not started"
        );
    }
}
