// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/Base64.sol";

contract ChainBottles is ERC721URIStorage {
    using Strings for uint256;
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    struct tokenInfo {
        uint256 level;
        uint256 speed;
        uint256 strength;
        uint256 life;
    }

    mapping(uint256 => tokenInfo) public tokenIdToLevels;
    tokenInfo token;

    constructor() ERC721("Chain Bottles", "CBTLS") {}

    function generateCharacter(uint256 tokenId) public returns (string memory) {
        bytes memory svg = abi.encodePacked(
            '<svg xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMinYMin meet" viewBox="0 0 350 350">',
            "<style>",
            ".base { fill: white; font-family: 'Open Sans', sans-serif; font-size: 20px; font-weight: 500 }",
            "rect { fill: url(#gradient); }",
            "</style>",
            "<defs>",
            '<linearGradient id="gradient" x1="0%" y1="0%" x2="0%" y2="100%">',
            '<stop offset="0%" stop-color="#5F0A87"/>',
            '<stop offset="100%" stop-color="#A4508B"/>',
            "</linearGradient>",
            "</defs>",
            '<rect width="100%" height="100%" />',
            '<text x="50%" y="80%" class="base" dominant-baseline="middle" text-anchor="middle">',
            "Warrior",
            "</text>",
            '<text x="50%" y="55%" class="base" dominant-baseline="middle" text-anchor="middle">',
            "Levels: ",
            getLevels(tokenId),
            "</text>",
            '<text x="50%" y="45%" class="base" dominant-baseline="middle" text-anchor="middle">',
            "Speed: ",
            getSpeed(tokenId),
            "</text>",
            '<text x="50%" y="35%" class="base" dominant-baseline="middle" text-anchor="middle">',
            "Strength: ",
            getStrength(tokenId),
            "</text>",
            '<text x="50%" y="25%" class="base" dominant-baseline="middle" text-anchor="middle">',
            "Life Span: ",
            getLife(tokenId),
            "</text>",
            "</svg>"
        );
        return
            string(
                abi.encodePacked(
                    "data:image/svg+xml;base64,",
                    Base64.encode(svg)
                )
            );
    }

    //function to get level of the NFT
    function getLevels(uint256 tokenId) public view returns (string memory) {
        uint256 levels = tokenIdToLevels[tokenId].level;
        return levels.toString();
    }

    function getSpeed(uint256 tokenId) public view returns (string memory) {
        uint256 speed = tokenIdToLevels[tokenId].speed;
        return speed.toString();
    }

    function getStrength(uint256 tokenId) public view returns (string memory) {
        uint256 strength = tokenIdToLevels[tokenId].strength;
        return strength.toString();
    }

    function getLife(uint256 tokenId) public view returns (string memory) {
        uint256 life = tokenIdToLevels[tokenId].life;
        return life.toString();
    }

    //function to genereate tokenURI
    function getTokenURI(uint256 tokenId) public returns (string memory) {
        bytes memory dataURI = abi.encodePacked(
            "{",
            '"name": "Chain Battles #',
            tokenId.toString(),
            '",',
            '"description": "Battles on chain",',
            '"image": "',
            generateCharacter(tokenId),
            '"',
            "}"
        );

        return
            string(
                abi.encodePacked(
                    "data:application/json;base64,",
                    Base64.encode(dataURI)
                )
            );
    }

    function mint() public {
        _tokenIds.increment();
        uint256 newItemId = _tokenIds.current();
        _safeMint(msg.sender, newItemId); // msg.sender: sender of the message (current call)
        //declare default value of token struct
        tokenInfo memory token1 = tokenInfo(0, 0, 0, 10);

        tokenIdToLevels[newItemId] = token1;
        _setTokenURI(newItemId, getTokenURI(newItemId));
    }

    function train(uint256 tokenId) public {
        require(_exists(tokenId), "Please use existing tokenId");
        require(
            ownerOf(tokenId) == msg.sender,
            "You must be the owner of the token to train it"
        );
        token = tokenIdToLevels[tokenId];
        tokenIdToLevels[tokenId] = tokenInfo(
            token.level += 1,
            token.speed += 50,
            token.strength += 200,
            token.life += 1
        );
        _setTokenURI(tokenId, getTokenURI(tokenId));
    }
}
