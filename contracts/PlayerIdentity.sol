// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract PlayerIdentity is ERC721, Ownable {
    uint256 private _nextTokenId;
    
    // Mapping to store human-readable aliases
    mapping(uint256 => string) public playerAliases;

    constructor(address initialOwner) 
        ERC721("PlayCoin Identity", "PLAYID") 
        Ownable(initialOwner) 
    {}

    // Mint a new Player ID to a specific address
    function registerPlayer(address player, string memory aliasName) public {
        uint256 tokenId = _nextTokenId++;
        _safeMint(player, tokenId);
        playerAliases[tokenId] = aliasName;
    }

    // Update alias (only owner of that specific ID)
    function updateAlias(uint256 tokenId, string memory newAlias) public {
        require(ownerOf(tokenId) == msg.sender, "Not the ID owner");
        playerAliases[tokenId] = newAlias;
    }
}