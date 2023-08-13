// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {ERC721Permit} from "./erc721/ERC721Permit.sol";
import {ERC721Enumerable} from "openzeppelin-contracts/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import {Ownable} from "openzeppelin-contracts/contracts/access/Ownable.sol";
import {ClonesUpgradeable} from "openzeppelin-contracts-upgradeable/contracts/proxy/ClonesUpgradeable.sol";
import {sipERC20} from "./sipERC20.sol";

contract OPPS is ERC721Permit, Ownable {
    mapping(uint256 => uint256) public nonces;
    mapping(bytes32 => bool) public nameTaken;
    address public immutable sipImplementation;

    function version() public pure returns (string memory) {
        return "1";
    }

    string private __baseURI;
    modifier onlySIP() {
        address asset = sipERC20(msg.sender).asset();
        require(
            msg.sender ==
                ClonesUpgradeable.predictDeterministicAddress(
                    sipImplementation,
                    bytes32(uint256(uint160(asset)))
                ),
            "!sip"
        );
        _;
    }

    function deployVault(address asset) public {
        ClonesUpgradeable.cloneDeterministic(
            sipImplementation,
            bytes32(uint256(uint160(asset)))
        );
    }

    function registerName(bytes32 nameHash) public onlySIP {
        nameTaken[nameHash] = true;
    }

    constructor() ERC721Permit("OPPS", "OPPS", "1") Ownable() {
        setBaseURI(
            "ipfs://bafybeiezpbqq6favps74erwn35ircae2xqqdmczxjs7imosdkn6ahmuxme/"
        );
        sipImplementation = address(new sipERC20());
    }

    function _baseURI() internal view override returns (string memory) {
        return __baseURI;
    }

    function _getAndIncrementNonce(
        uint256 _tokenId
    ) internal virtual override returns (uint256) {
        uint256 nonce = nonces[_tokenId];
        nonces[_tokenId]++;
        return nonce;
    }

    function setBaseURI(string memory _uri) public onlyOwner {
        __baseURI = _uri;
    }

    function mint(address _to, uint256 _tokenId) public onlyOwner {
        _mint(_to, _tokenId);
    }
}
