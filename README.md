# NFT Marketplace Smart Contract

This is a simple Ethereum smart contract built using the Hardhat framework for creating and managing an NFT (Non-Fungible Token) marketplace. The smart contract allows users to mint NFTs, list them for sale, and buy NFTs from the marketplace.

## Features

1. **Minting NFTs**: Users can mint new NFTs by providing the recipient's address, a token URI, and the price for the NFT.

2. **Listing NFTs for Sale**: NFT owners can list their tokens for sale by specifying the token ID and the desired sale price.

3. **Buying NFTs**: Users can purchase listed NFTs by sending the required amount of Ether, fulfilling the specified sale price. The NFT ownership is then transferred to the buyer.

## Smart Contract Details

- **Name**: NFTMarketplace
- **Symbol**: NFTM
- **Inherits from**: ERC721URIStorage

### State Variables

- `owner`: The address of the contract owner.
- `tokenId`: The unique identifier for each minted NFT.
- `tokenPrices`: Mapping from token ID to its sale price.
- `tokenListings`: Mapping from token ID to its listing status.

### Events

- `MintedNFT`: Fired when a new NFT is minted.
- `ListedNFT`: Fired when an NFT is listed for sale.
- `BoughtNFT`: Fired when an NFT is successfully purchased.

### Functions

- `mintNFT`: Mint a new NFT and assign ownership to the specified address.
- `listNFT`: List an owned NFT for sale with a specified price.
- `buyNFT`: Purchase a listed NFT by sending the required Ether.

## Deployment

To deploy the NFT marketplace smart contract, use the provided deploy script in the `scripts` directory. The script uses Hardhat and ethers.js for deployment.

```bash
npx hardhat run scripts/deploy.js
```

After successful deployment, the contract address will be logged to the console.

## Dependencies

The smart contract relies on the OpenZeppelin library for ERC721 functionality. Ensure that the required dependencies are installed before deploying the contract:

```bash
npm install @openzeppelin/contracts
```

## Sample deployment

https://mumbai.polygonscan.com/address/0x29B95a3B6fCD43Ed94e5cbf20eFF011fb59e1CD1#code

![](images\mumbai.png)

## License

This smart contract is released under the UNLICENSED license.

## Disclaimer

This smart contract is provided as-is without any warranty. Use it at your own risk. The developers are not responsible for any issues or losses that may arise from using this smart contract.