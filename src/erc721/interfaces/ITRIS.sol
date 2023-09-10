// SPDX-License-Identifier: MIT

pragma solidity >=0.8.7 <0.9.0;

import {IERC721} from "openzeppelin-contracts/contracts/token/ERC721/IERC721.sol";

interface ITRIS is IERC721 {
    function owner() external returns (address);

    function adminMint(address, uint) external;

    function mint(address, uint) external;
}
